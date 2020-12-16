library ieee;
use ieee.std_logic_1164.all;

-- 4:1 MUX with Truth Table
-- Lesson 2 Slide 21

entity lc_ex01p02_truthTable is
    port(
        D: in std_logic_vector(3 downto 0);
        Q: out std_logic;
        SEL: in std_logic_vector(1 downto 0)
    );
end entity lc_ex01p02_truthTable;

architecture arch of lc_ex01p02_truthTable is
    begin
        
        with SEL select
            Q <= 
            D(3) when "00",     -- SEL(0)=0, SEL(1)=0
            D(2) when "01",     -- SEL(0)=1, SEL(1)=0
            D(1) when "10",     -- SEL(0)=0, SEL(1)=1
            D(0) when others;   -- SEL(0)=1, SEL(1)=1

end architecture arch;
