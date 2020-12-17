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
            UP: in std_logic;
            RST: in std_logic;
            CLK: in std_logic;
            Q: out std_logic_vector(N-1 downto 0)
        );
    end component lc_ex03_counter;

    signal up, rst, clk: std_logic;
    signal q: std_logic_vector(N_tb-1 downto 0);

    begin
        uut: lc_ex03_counter
        generic map(
            N => N_tb
        ) -- no ';' until the end of the component !
        port map(
            UP => up,
            RST => rst,
            CLK => clk,
            Q => q
        );

        simulate: process
            variable tmp: std_logic_vector(N_tb-1 downto 0);
            begin

                -- Check rst and up
                up <= '1'; rst <= '1'; clk <= '0';
                wait for 10 ns;
                assert((q = "0000")) report "Test number 1 failed" severity error;

                -- Count up
                up <= '1'; rst <= '0';
                for i in 0 to 15 loop
                    -- when i=15, we should have an overflow --> q = "0000"
                    clk <= '1';
                    wait for 5 ns;
                    clk <= '0';
                    wait for 5 ns;

                    tmp := std_logic_vector(to_unsigned(i+1, q'length));
                    assert((q = tmp)) report "Test failed for up count!" severity error;

                end loop;

                -- Check rst and down
                up <= '0'; rst <= '1'; clk <= '0';
                wait for 5 ns;
                assert((q = "1111")) report "Test number 10 failed" severity error;

                -- Count down
                up <= '0'; rst <= '0';
                for i in 15 downto 0 loop   -- NOTE: that 'to' has been replaced by 'downto'
                    -- when i=0, we should have an overflow --> q = "1111"
                    clk <= '1';
                    wait for 5 ns;
                    clk <= '0';
                    wait for 5 ns;

                    tmp := std_logic_vector(to_unsigned(i-1, q'length));    -- NOTE: that '+' has been replaced by '-'
                    assert((q = tmp)) report "Test failed for up cnt!" severity error;

                end loop;

        end process simulate;

end architecture arch;

