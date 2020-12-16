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
                wait for 5 ns;
                d <= "0000"; load <= '0';    -- En must go from 1 to 0 to 1 to reactivate the process of the logical component.
                wait for 5 ns;

                -- What we have in the register so far: "1010". The register is full.

                -- Check the first output (expected result: 1010)
                d <= "1100"; load <= '1';
                wait for 5 ns;
                assert((q = "1010")) report "Test failed for input number 1" severity error;
                d <= "1010"; load <= '0';
                wait for 5 ns;

                -- Check the second output (expected result: 1100)
                d <= "0101"; load <= '1';
                wait for 5 ns;
                assert((q = "1100")) report "Test failed for input number 2" severity error;
                d <= "0000"; load <= '0';
                wait for 5 ns;

                -- Check the third output (expected result: 0101)
                d <= "0000"; load <= '1';
                wait for 5 ns;
                assert((q = "0101")) report "Test failed for input number 3" severity error;
                d <= "0000"; load <= '0';
                wait for 5 ns;

        end process simulate;

end architecture arch;
