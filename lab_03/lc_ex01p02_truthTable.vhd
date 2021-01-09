library ieee;
use ieee.std_logic_1164.all;

-- 4:1 MUX with Truth Table
-- Lecture 2 Slide 21

entity lc_ex01p02_truthTable is
    port(
        SEL: in std_logic_vector(1 downto 0);
        D: in std_logic_vector(3 downto 0);
        Q: out std_logic        
    );
end entity lc_ex01p02_truthTable;

architecture arch of lc_ex01p02_truthTable is
    begin
        
        with SEL select
            Q <= 
            D(0) when "00",     -- sel = 00
            D(1) when "01",     -- sel = 01
            D(2) when "10",     -- sel = 10
            D(3) when others;   -- sel = 11

end architecture arch;