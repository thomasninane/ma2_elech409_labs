library ieee;
use ieee.std_logic_1164.all;

entity lc_ex01_fullAdder is
    port(
        a: in std_logic;
        b: in std_logic;
        cIn: in std_logic;
        s: out std_logic;
        cOut: out std_logic
    );
end entity lc_ex01_fullAdder;

architecture arch of lc_ex01_fullAdder is
    begin
        s <= a xor b xor cIn;                       -- sum bit
        cOut <= (a and b) or ((a xor b) and cIn);   -- carry bit
end architecture arch;