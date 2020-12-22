library ieee;
use ieee.std_logic_1164.all;

entity lc_ex02 is
    port(
        IN_1: in std_logic;
        IN_2: in std_logic;
        IN_3: in std_logic;
        OUT_1: out std_logic
    );
end entity lc_ex02;

architecture arch of lc_ex02 is
    begin
        OUT_1 <= IN_1 and IN_2 and IN_3;
end architecture arch;