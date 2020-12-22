library ieee;
use ieee.std_logic_1164.all;

entity lc_ex01p03_singleDFlipFlop is
    port(
        D: in std_logic;
        Q: out std_logic;
        CLK: in std_logic
    );
end entity lc_ex01p03_singleDFlipFlop;

architecture arch of lc_ex01p03_singleDFlipFlop is
    begin

        proc: process(CLK)
            begin
                if (rising_edge(CLK)) then
                    Q <= D;
                end if;
        end process proc;

end architecture arch;
