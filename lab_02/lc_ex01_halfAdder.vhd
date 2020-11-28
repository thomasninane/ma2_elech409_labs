library ieee;
use ieee.std_logic_1164.all;

entity lc_ex01_halfAdder is
    port(
        a: in std_logic;
        b: in std_logic;
        s: out std_logic;
        cOut: out std_logic
    );
end entity lc_ex01_halfAdder;

architecture arch of lc_ex01_halfAdder is
    begin
        s <= a xor b;       -- sum bit
        cOut <= a and b;    -- carry bit
end architecture arch;
