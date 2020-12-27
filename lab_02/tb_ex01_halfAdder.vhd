library ieee;
use ieee.std_logic_1164.all;

entity tb_ex01_halfAdder is
end entity tb_ex01_halfAdder;

architecture arch of tb_ex01_halfAdder is

    component lc_ex01_halfAdder is
        port(
            a: in std_logic;
            b: in std_logic;
            s: out std_logic;
            cOut: out std_logic
        );
    end component lc_ex01_halfAdder;

    signal a, b, s, cOut: std_logic;
    
    begin
        uut: lc_ex01_halfAdder port map(
            a => a,
            b => b,
            s => s,
            cOut => cOut
        );

        stim: process
            begin
                a <= '0'; b <= '0';
                wait for 10 ns;
                assert s = '0' report "Test failed for input combination 00 (s)" severity error;
                assert cOut = '0' report "Test failed for input combination 00 (cOut)" severity error;

                a <= '0'; b <= '1';
                wait for 10 ns;
                assert s = '1' report "Test failed for input combination 01 (s)" severity error;
                assert cOut = '0' report "Test failed for input combination 01 (cOut)" severity error;

                a <= '1'; b <= '0';
                wait for 10 ns;
                assert s = '1' report "Test failed for input combination 10 (s)" severity error;
                assert cOut = '0' report "Test failed for input combination 10 (cOut)" severity error;

                a <= '1'; b <= '1';
                wait for 10 ns;
                assert s = '0' report "Test failed for input combination 11 (s)" severity error;
                assert cOut = '1' report "Test failed for input combination 11 (cOut)" severity error;

                wait;
                
        end process stim;

end architecture arch;