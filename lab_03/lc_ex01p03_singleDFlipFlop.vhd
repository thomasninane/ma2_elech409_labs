library ieee;
use ieee.std_logic_1164.all;

entity lc_ex01p03_singleDFlipFlop is
    port(
        D: in std_logic;
        Q: out std_logic;
        Clk: in std_logic
    );
end entity lc_ex01p03_singleDFlipFlop;

architecture arch of lc_ex01p03_singleDFlipFlop is
    begin

        proc: process(Clk)
            begin
                if (rising_edge(Clk)) then
                    Q <= D;
                end if;
        end process proc;

end architecture arch;
