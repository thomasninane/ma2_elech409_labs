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
            D: in std_logic_vector(N-1 downto 0);
            LOAD: in std_logic;
            SERIAL: in std_logic;
            RST: in std_logic;
            Q: out std_logic_vector(N-1 downto 0)
        );
    end component lc_ex02p03_mixedRegister;

    signal d: std_logic_vector(N_tb-1 downto 0);
    signal load, serial, rst: std_logic;
    signal q: std_logic_vector(N_tb-1 downto 0);

    begin
        uut: lc_ex02p03_mixedRegister
        generic map(
            N => N_tb
        ) -- no ';' until the end of the component !
        port map(
            D => d,
            LOAD => load,
            SERIAL => serial,
            RST => rst,
            Q => q
        );

        simulate: process
            begin

                -- Check parallel-in
                d <= "1010"; load <= '1'; serial <= '0'; rst <= '0';
                wait for 10 ns;
                assert((q = "1010")) report "Test number 1 failed" severity error;

                d <= "0000"; load <= '0'; serial <= '0'; rst <= '0';
                wait for 10 ns;
                assert((q = "1010")) report "Test number 2 failed" severity error;

                d <= "1111"; load <= '1'; serial <= '0'; rst <= '0';
                wait for 10 ns;
                assert((q = "1111")) report "Test number 3 failed" severity error;

                -- Check rst
                d <= "0001"; load <= '0'; serial <= '0'; rst <= '1';
                wait for 10 ns;
                assert((q = "0000")) report "Test number 4 failed" severity error;

                d <= "0010"; load <= '0'; serial <= '1'; rst <= '1';
                wait for 10 ns;
                assert((q = "0000")) report "Test number 5 failed" severity error;

                d <= "0011"; load <= '1'; serial <= '0'; rst <= '1';
                wait for 10 ns;
                assert((q = "0000")) report "Test number 6 failed" severity error;

                d <= "0100"; load <= '1'; serial <= '1'; rst <= '1';
                wait for 10 ns;
                assert((q = "0000")) report "Test number 7 failed" severity error;

                -- Check serial-in
                d <= "1111"; load <= '1'; serial <= '1'; rst <= '0';
                wait for 10 ns;
                assert((q = "0001")) report "Test number 8 failed" severity error;

                d <= "1111"; load <= '0'; serial <= '1'; rst <= '0';
                wait for 10 ns;
                assert((q = "0001")) report "Test number 9 failed" severity error;

                d <= "0101"; load <= '1'; serial <= '1'; rst <= '0';
                wait for 10 ns;
                assert((q = "0011")) report "Test number 10 failed" severity error;


        end process simulate;

end architecture arch;

