library ieee;
use ieee.std_logic_1164.all;

entity tb_ex01p02_truthTable is
end entity tb_ex01p02_truthTable;

architecture arch of tb_ex01p02_truthTable is

    component lc_ex01p02_truthTable is
        port(
            SEL: in std_logic_vector(1 downto 0);
            D: in std_logic_vector(3 downto 0);
            Q: out std_logic        
        );
    end component lc_ex01p02_truthTable;

    signal sel: std_logic_vector(1 downto 0);
    signal d: std_logic_vector(3 downto 0);
    signal q: std_logic;

    begin
        uut: lc_ex01p02_truthTable port map(
            SEL => sel,
            D => d,
            Q => q
        );

        stim: process
            begin

                d <= "1010";    -- d(3)=1, d(2)=0, d(1)=1, d(0)=0

                sel <= "00";
                -- expected output: d(0)
                wait for 10 ns;
                assert q = '0' report "Test failed for sel=00" severity error;

                sel <= "01";
                -- expected output: d(1)
                wait for 10 ns;
                assert q = '1' report "Test failed for sel=01" severity error;

                sel <= "10";
                -- expected output: d(2)
                wait for 10 ns;
                assert q = '0' report "Test failed for sel=10" severity error;

                sel <= "11";
                -- expected output: d(3)
                wait for 10 ns;
                assert q = '1' report "Test failed for sel=11" severity error;

                wait;

        end process stim;

end architecture arch;
