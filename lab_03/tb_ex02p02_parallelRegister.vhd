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
            D: in std_logic_vector(N-1 downto 0);
            LOAD: in std_logic;
            Q: out std_logic_vector(N-1 downto 0)
        );
    end component lc_ex02p02_parallelRegister;

    signal d: std_logic_vector(N_tb-1 downto 0);
    signal load: std_logic;
    signal q: std_logic_vector(N_tb-1 downto 0);

    begin
        uut: lc_ex02p02_parallelRegister
        generic map(
            N => N_tb
        ) -- no ';' until the end of the component !
        port map(
            D => d,
            LOAD => load,
            Q => q
        );

        simulate: process
            begin

                -- Fill the register
                d <= "1010"; load <= '1';
                wait for 10 ns;
                assert((q = "1010")) report "Test number 1 failed" severity error;

                d <= "0000"; load <= '0';
                wait for 10 ns;
                assert((q = "1010")) report "Test number 2 failed" severity error;

                d <= "0001"; load <= '0';
                wait for 10 ns;
                assert((q = "1010")) report "Test number 3 failed" severity error;

                d <= "1000"; load <= '1';
                wait for 10 ns;
                assert((q = "1000")) report "Test number 4 failed" severity error;


        end process simulate;

end architecture arch;
