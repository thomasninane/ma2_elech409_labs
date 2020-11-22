library ieee;
use ieee.std_logic_1164.all;

entity tb_fullAdder is
end entity tb_fullAdder;

architecture arch of tb_fullAdder is

    component lc_fullAdder is
        port(
            a: in std_logic;
            b: in std_logic;
            cIn: in std_logic;
            s: out std_logic;
            cOut: out std_logic
        );
    end component lc_fullAdder;

    signal a, b, cIn, s, cOut: std_logic;
    
    begin
        uut: lc_fullAdder port map(
            a => a,
            b => b,
            cIn => cIn,
            s => s,
            cOut => cOut
        );

        simulate: process
            begin
                a <= '0'; b <= '0'; cIn <= '0';
                wait for 10 ns;
                assert((s = '0')) report "Test failed for input combination 000 (s)" severity error;
                assert((cOut = '0')) report "Test failed for input combination 000 (cOut)" severity error;

                a <= '0'; b <= '0'; cIn <= '1';
                wait for 10 ns;
                assert((s = '1')) report "Test failed for input combination 001 (s)" severity error;
                assert((cOut = '0')) report "Test failed for input combination 001 (cOut)" severity error;

                a <= '0'; b <= '1'; cIn <= '0';
                wait for 10 ns;
                assert((s = '1')) report "Test failed for input combination 010 (s)" severity error;
                assert((cOut = '0')) report "Test failed for input combination 010 (cOut)" severity error;
                

                a <= '0'; b <= '1'; cIn <= '1';
                wait for 10 ns;
                assert((s = '0')) report "Test failed for input combination 011 (s)" severity error;
                assert((cOut = '1')) report "Test failed for input combination 011 (cOut)" severity error;

                a <= '1'; b <= '0'; cIn <= '0';
                wait for 10 ns;
                assert((s = '1')) report "Test failed for input combination 100 (s)" severity error;
                assert((cOut = '0')) report "Test failed for input combination 100 (cOut)" severity error;

                a <= '1'; b <= '0'; cIn <= '1';
                wait for 10 ns;
                assert((s = '0')) report "Test failed for input combination 101 (s)" severity error;
                assert((cOut = '1')) report "Test failed for input combination 101 (cOut)" severity error;

                a <= '1'; b <= '1'; cIn <= '0';
                wait for 10 ns;
                assert((s = '0')) report "Test failed for input combination 110 (s)" severity error;
                assert((cOut = '1')) report "Test failed for input combination 110 (cOut)" severity error;

                a <= '1'; b <= '1'; cIn <= '1';
                wait for 10 ns;
                assert((s = '1')) report "Test failed for input combination 111 (s)" severity error;
                assert((cOut = '1')) report "Test failed for input combination 111 (cOut)" severity error;
        end process simulate;

end architecture arch;
