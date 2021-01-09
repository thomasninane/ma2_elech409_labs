library ieee;
use ieee.std_logic_1164.all;

entity tb_ex02p02_parallelRegister is
    generic(N_tb: integer := 4);
end entity tb_ex02p02_parallelRegister;

architecture arch of tb_ex02p02_parallelRegister is

    component lc_ex02p02_parallelRegister is
        generic(
            N: integer := 4
        );
        port(
            CLK: in std_logic;
            RESET: in std_logic;
            LOAD: in std_logic;
            D: in std_logic_vector(N-1 downto 0);
            Q: out std_logic_vector(N-1 downto 0)
        );
    end component lc_ex02p02_parallelRegister;

    signal clk, reset, load: std_logic;
    signal d, q: std_logic_vector(N_tb-1 downto 0);

    begin
        uut: lc_ex02p02_parallelRegister
        generic map(
            N => N_tb
        ) -- no ';' until the end of the component !
        port map(
            CLK => clk,
            RESET => reset,
            LOAD => load,
            D => d,
            Q => q
        );

        simulate: process
            begin

                -- Normal operations
                clk <= '0'; reset <= '0'; load <= '1'; d <= "1010";
                wait for 5 ns;
                clk <= '1'; reset <= '0'; load <= '1'; d <= "1010";
                wait for 5 ns;
                assert q = "1010" report "Test number 1 failed" severity error;

                clk <= '0'; reset <= '0'; load <= '1'; d <= "0000";
                wait for 5 ns;
                clk <= '1'; reset <= '0'; load <= '1'; d <= "0000";
                wait for 5 ns;
                assert q = "0000" report "Test number 2 failed" severity error;

                clk <= '0'; reset <= '0'; load <= '1'; d <= "0001";
                wait for 5 ns;
                clk <= '1'; reset <= '0'; load <= '1'; d <= "0001";
                wait for 5 ns;
                assert q = "0001" report "Test number 3 failed" severity error;

                clk <= '0'; reset <= '0'; load <= '1'; d <= "1000";
                wait for 5 ns;
                clk <= '1'; reset <= '0'; load <= '1'; d <= "1000";
                wait for 5 ns;
                assert q = "1000" report "Test number 4 failed" severity error;

                -- Reset
                clk <= '0'; reset <= '1'; load <= '1'; d <= "1010";
                wait for 5 ns;
                clk <= '1'; reset <= '1'; load <= '1'; d <= "1010";
                wait for 5 ns;
                assert q = "0000" report "Test number 5 failed" severity error;

                -- Check that nothing happens if load = 0
                clk <= '0'; reset <= '0'; load <= '0'; d <= "1010";
                wait for 5 ns;
                clk <= '1'; reset <= '0'; load <= '0'; d <= "1010";
                wait for 5 ns;
                assert q = "0000" report "Test number 6 failed" severity error;

                wait;


        end process simulate;

end architecture arch;