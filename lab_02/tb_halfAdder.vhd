library ieee;
use ieee.std_logic_1164.all;

entity tb_halfAdder is
end entity tb_halfAdder;

architecture arch of tb_halfAdder is

    component lc_halfAdder is
        port(
            a: in std_logic;
            b: in std_logic;
            s: out std_logic;
            cOut: out std_logic
        );
    end component lc_halfAdder;

    signal a, b, s, cOut: std_logic;
    
    begin
        uut: lc_halfAdder port map(
            a => a,
            b => b,
            s => s,
            cOut => cOut
        );

        simulate: process
            begin
                a <= '0'; b <= '0';
                wait for 10 ns;
                assert((s = '0')) report "Test failed for input combination 00 (s)" severity error;
                assert((cOut = '0')) report "Test failed for input combination 00 (cOut)" severity error;

                a <= '0'; b <= '1';
                wait for 10 ns;
                assert((s = '1')) report "Test failed for input combination 01 (s)" severity error;
                assert((cOut = '0')) report "Test failed for input combination 01 (cOut)" severity error;

                a <= '1'; b <= '0';
                wait for 10 ns;
                assert((s = '1')) report "Test failed for input combination 10 (s)" severity error;
                assert((cOut = '0')) report "Test failed for input combination 10 (cOut)" severity error;

                a <= '1'; b <= '1';
                wait for 10 ns;
                assert((s = '0')) report "Test failed for input combination 11 (s)" severity error;
                assert((cOut = '1')) report "Test failed for input combination 11 (cOut)" severity error;
        end process simulate;

end architecture arch;