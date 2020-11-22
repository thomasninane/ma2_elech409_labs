library ieee;
use ieee.std_logic_1164.all;

entity lc_ex02 is
    port(
        in1: in std_logic;
        in2: in std_logic;
        in3: in std_logic;
        out1: out std_logic
    );
end entity lc_ex02;

architecture arch of lc_ex02 is
    begin
        out1 <= in1 and in2 and in3;
end architecture arch;