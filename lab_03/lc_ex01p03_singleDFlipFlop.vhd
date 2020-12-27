library ieee;
use ieee.std_logic_1164.all;

entity lc_ex01p03_singleDFlipFlop is
    port(
        CLK: in std_logic;
        RESET: in std_logic;
        ENABLE: in std_logic;
        D: in std_logic;
        Q: out std_logic
    );
end entity lc_ex01p03_singleDFlipFlop;

architecture arch of lc_ex01p03_singleDFlipFlop is
    begin

        proc: process(CLK, RESET, ENABLE)
            begin
                if (RESET = '1') then
                    Q <= '0';

                elsif (rising_edge(CLK)) then
                    if (ENABLE = '1') then
                        Q <= D;
                    end if;
                end if;
        end process proc;

end architecture arch;
