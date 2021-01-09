library ieee;
use ieee.std_logic_1164.all;

entity lc_ex03_partialFullAdder is
    port(
        -- input(s)
        a: in std_logic;
        b: in std_logic;
        cIn: in std_logic;
        -- output(s)
        -- No need for cOut!
        s: out std_logic;
        G: out std_logic;
        P: out std_logic
    );
end entity lc_ex03_partialFullAdder;

architecture arch of lc_ex03_partialFullAdder is
    begin
        s <= a xor b xor cIn;
        G <= a and b;
        P <= a xor b;

end architecture arch;