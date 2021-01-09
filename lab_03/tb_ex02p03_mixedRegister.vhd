library ieee;
use ieee.std_logic_1164.all;

entity tb_ex02p03_mixedRegister is
    generic(N_tb: integer := 4);
end entity tb_ex02p03_mixedRegister;

architecture arch of tb_ex02p03_mixedRegister is

    component lc_ex02p03_mixedRegister is
        generic(
            N: integer := 4
        );
        port(
            CLK: in std_logic;
            RESET: in std_logic;
            LOAD: in std_logic;
            SERIAL: in std_logic;
            D: in std_logic_vector(N-1 downto 0);
            Q: out std_logic_vector(N-1 downto 0)
    );
    end component lc_ex02p03_mixedRegister;

    signal clk, reset, load, serial: std_logic;
    signal d, q: std_logic_vector(N_tb-1 downto 0);

    begin
        uut: lc_ex02p03_mixedRegister
        generic map(
            N => N_tb
        ) -- no ';' until the end of the component !
        port map(
            CLK => clk,
            RESET => reset,
            LOAD => load,
            SERIAl => serial,
            D => d,
            Q => q
        );

        stim: process
            begin

                -- Check parallel-in
                clk <= '0'; reset <= '0'; load <= '1'; serial <= '0'; d <= "1010";
                wait for 5 ns;
                clk <= '1'; reset <= '0'; load <= '1'; serial <= '0'; d <= "1010";
                wait for 5 ns;
                assert q = "1010" report "Test number 1 failed" severity error;

                clk <= '0'; reset <= '0'; load <= '1'; serial <= '0'; d <= "0000";
                wait for 5 ns;
                clk <= '1'; reset <= '0'; load <= '1'; serial <= '0'; d <= "0000";
                wait for 5 ns;
                assert q = "0000" report "Test number 2 failed" severity error;

                clk <= '0'; reset <= '0'; load <= '1'; serial <= '0'; d <= "0001";
                wait for 5 ns;
                clk <= '1'; reset <= '0'; load <= '1'; serial <= '0'; d <= "0001";
                wait for 5 ns;
                assert q = "0001" report "Test number 3 failed" severity error;

                -- Check asynchronous reset (parallel-in)
                clk <= '0'; reset <= '1'; load <= '1'; serial <= '0'; d <= "0001";
                wait for 5 ns;
                assert q = "0000" report "Test number 4.1 failed" severity error;
                clk <= '1'; reset <= '1'; load <= '1'; serial <= '0'; d <= "0001";
                wait for 5 ns;
                assert q = "0000" report "Test number 4.2 failed" severity error;

                -- Check serial-in
                clk <= '0'; reset <= '0'; load <= '1'; serial <= '1'; d <= "1001";
                wait for 5 ns;
                clk <= '1'; reset <= '0'; load <= '1'; serial <= '1'; d <= "1001";
                wait for 5 ns;
                assert q = "0001" report "Test number 5 failed" severity error;

                clk <= '0'; reset <= '0'; load <= '1'; serial <= '1'; d <= "1110";
                wait for 5 ns;
                clk <= '1'; reset <= '0'; load <= '1'; serial <= '1'; d <= "1110";
                wait for 5 ns;
                assert q = "0010" report "Test number 6 failed" severity error;

                clk <= '0'; reset <= '0'; load <= '1'; serial <= '1'; d <= "0001";
                wait for 5 ns;
                clk <= '1'; reset <= '0'; load <= '1'; serial <= '1'; d <= "0001";
                wait for 5 ns;
                assert q = "0101" report "Test number 7 failed" severity error;

                clk <= '0'; reset <= '0'; load <= '1'; serial <= '1'; d <= "0001";
                wait for 5 ns;
                clk <= '1'; reset <= '0'; load <= '1'; serial <= '1'; d <= "0001";
                wait for 5 ns;
                assert q = "1011" report "Test number 8 failed" severity error;

                -- Check asynchronous reset (serial-in)
                clk <= '0'; reset <= '1'; load <= '1'; serial <= '1'; d <= "0001";
                wait for 5 ns;
                assert q = "0000" report "Test number 9.1 failed" severity error;
                clk <= '1'; reset <= '1'; load <= '1'; serial <= '1'; d <= "0001";
                wait for 5 ns;
                assert q = "0000" report "Test number 9.2 failed" severity error;

                wait;

        end process stim;

end architecture arch;