library ieee;
use ieee.std_logic_1164.all;

entity tb_ex01p01_mux is
end entity tb_ex01p01_mux;

architecture arch of tb_ex01p01_mux is

    component lc_ex01p01_mux is
        port(
            D: in std_logic_vector(3 downto 0);
            Q: out std_logic;
            SEL: in std_logic_vector(1 downto 0)
        );
    end component lc_ex01p01_mux;

    signal d: std_logic_vector(3 downto 0);
    signal q: std_logic;
    signal sel: std_logic_vector(1 downto 0);

    begin
        uut: lc_ex01p01_mux port map(
            D => d,
            Q => q,
            SEL => sel
        );

        simulate: process
            begin

                d <= "1010";    -- d(3)=1, d(2)=0, d(1)=1, d(0)=0

                sel <= "00";
                -- expected output: d(3) c.f. design!
                wait for 10 ns;
                assert((q = '1')) report "Test failed for sel=00" severity error;

                sel <= "01";
                -- expected output: d(2)
                wait for 10 ns;
                assert((q = '0')) report "Test failed for sel=01" severity error;

                sel <= "10";
                -- expected output: d(1)
                wait for 10 ns;
                assert((q = '1')) report "Test failed for sel=10" severity error;

                sel <= "11";
                -- expected output: d(0)
                wait for 10 ns;
                assert((q = '0')) report "Test failed for sel=11" severity error;

        end process simulate;

end architecture arch;