library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_ex03_counter is
    generic(N_tb: integer := 4);
end entity tb_ex03_counter;

architecture arch of tb_ex03_counter is

    component lc_ex03_counter is
        generic(
            N: integer := 4
        );
        port(
            CLK: in std_logic;
            RESET: in std_logic;
            UP: in std_logic;
            Q: out std_logic_vector(N-1 downto 0)
        );
    end component lc_ex03_counter;

    signal clk, reset, up: std_logic;
    signal q: std_logic_vector(N_tb-1 downto 0);

    begin
        uut: lc_ex03_counter
        generic map(
            N => N_tb
        ) -- no ';' until the end of the component !
        port map(
            CLK => clk,
            RESET => reset,
            UP => up,
            Q => q
        );

        stim: process

            variable tmp: std_logic_vector(N_tb-1 downto 0);

            begin

                -- Check reset and up
                clk <= '0'; reset <= '1'; up <= '1';
                wait for 5 ns;
                assert q = "0000" report "Test number 1.1 failed" severity error;
                clk <= '1'; reset <= '1'; up <= '1';
                wait for 5 ns;
                assert q = "0000" report "Test number 1.2 failed" severity error;

                -- Count up
                for i in 1 to 16 loop
                    -- when i=1, q goes from "0000" to "0001"
                    -- when i=2, q goes from "0001" to "0002"
                    -- ...
                    -- when i=16, q goes from "1111" to "0000" (overflow!)
                    clk <= '0'; reset <= '0'; up <= '1';
                    wait for 5 ns;
                    clk <= '1'; reset <= '0'; up <= '1';
                    wait for 5 ns;

                    if (i = 16) then tmp := "0000";
                    else tmp := std_logic_vector(to_unsigned(i, q'length));
                    end if;

                    assert q = tmp report "Test failed for up count. i = " & integer'image(i) severity error;
                end loop;

                -- Check reset and down
                clk <= '0'; reset <= '1'; up <= '0';
                wait for 5 ns;
                assert q = "1111" report "Test number 2.1 failed" severity error;
                clk <= '1'; reset <= '1'; up <= '0';
                wait for 5 ns;
                assert q = "1111" report "Test number 2.2 failed" severity error;

                -- Count down
                for i in 14 downto -1 loop   -- NOTE: that 'to' has been replaced by 'downto'
                    -- when i=14, q goes from "1111" to "1110"
                    -- when i=13, q goes from "1110" to "1101"
                    -- ...
                    -- when i=-1, q goes from "0000" to "1111" (overflow!)
                    clk <= '0'; reset <= '0'; up <= '0';
                    wait for 5 ns;
                    clk <= '1'; reset <= '0'; up <= '0';
                    wait for 5 ns;

                    if (i = -1) then tmp := "1111";
                    else tmp := std_logic_vector(to_unsigned(i, q'length));
                    end if;

                    assert q = tmp report "Test failed for down cnt. i = " & integer'image(i) severity error;
                end loop;

                wait;

        end process stim;

end architecture arch;

