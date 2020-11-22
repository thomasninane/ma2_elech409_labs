library ieee;
use ieee.std_logic_1164.all;

entity lc_ex03 is
    port(
        in1: in std_logic;
        in2: in std_logic;
        in3: in std_logic;
        out1: out std_logic;
        out2: out std_logic;
        out3: out std_logic
    );
end entity lc_ex03;

architecture arch of lc_ex03 is
    begin
        out1 <= in1 and in2;
        --out2 <= o2 and in2 and in3;   -- This should give us an error !
        out2 <= in2 and in3;
        --out3 <= in1 and in2 and in3;
        out3 <= in1 or in2 or in3;
end architecture arch;