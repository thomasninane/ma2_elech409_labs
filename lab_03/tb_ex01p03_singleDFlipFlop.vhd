library ieee;
use ieee.std_logic_1164.all;

entity tb_ex01p03_singleDFlipFlop is
end entity tb_ex01p03_singleDFlipFlop;

architecture arch of tb_ex01p03_singleDFlipFlop is

    component lc_ex01p03_singleDFlipFlop is
        port(
            D: in std_logic;
            Q: out std_logic;
            CLK: in std_logic
        );
    end component lc_ex01p03_singleDFlipFlop;

    signal d: std_logic;
    signal q: std_logic;
    signal clk: std_logic;

    begin
        uut: lc_ex01p03_singleDFlipFlop port map(
            D => d,
            Q => q,
            CLK => clk
        );

        simulate: process
            begin

                -- We should have an uncertainty on the output until the first rising edge of clk (no asserts on output)!
                d <= '1'; clk <= '0';
                wait for 10 ns;

                d <= '0'; clk <= '0';
                wait for 10 ns;

                -- Uncertainty should be gone!
                d <= '1'; clk <= '1';   -- q becomes high
                wait for 10 ns;
                assert((q = '1')) report "Test failed for d=1 and clk=1" severity error;

                d <= '0'; clk <= '0';   -- q stays high
                wait for 10 ns;
                assert((q = '1')) report "Test failed for d=0 and clk=0" severity error;

                d <= '0'; clk <= '1';   -- q becomes low
                wait for 10 ns;
                assert((q = '0')) report "Test failed for d=0 and clk=1" severity error;

                d <= '1'; clk <= '0';   -- q stays low
                wait for 10 ns;
                assert((q = '0')) report "Test failed for d=1 and clk=0" severity error;

                d <= '1'; clk <= '1';   -- q becomes high
                wait for 10 ns;
                assert((q = '1')) report "Test failed for d=1 and clk=1" severity error;

        end process simulate;

end architecture arch;
