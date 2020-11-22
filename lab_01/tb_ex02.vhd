library ieee;
use ieee.std_logic_1164.all;

entity tb_ex02 is
end entity tb_ex02;

architecture arch of tb_ex02 is
    
    component lc_ex02 is
        port(
            in1: in std_logic;
            in2: in std_logic;
            in3: in std_logic;
            out1: out std_logic
        );
    end component lc_ex02;

    signal a, b, c, o: std_logic;

    begin
        uut: lc_ex02 port map(
            in1 => a,
            in2 => b,
            in3 => c,
            out1 => o
        );

        simulate: process
            begin
                a <= '0'; b <= '0'; c <= '0';
                wait for 10 ns;
                assert ((o = '0'));
                report "test failed for input combination 000" severity error;

                a <= '1'; b <= '1'; c <= '1';
                wait for 10 ns;
                assert ((o = '1'));
                report "test failed for input combination 111" severity error;

                a <= '0'; b <= '1'; c <= '0';
                wait for 10 ns;
                assert ((o = '0'));
                report "test failed for input combination 010" severity error;
        end process simulate;

end architecture arch;