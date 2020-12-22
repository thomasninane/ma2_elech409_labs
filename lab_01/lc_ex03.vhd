library ieee;
use ieee.std_logic_1164.all;

entity lc_ex03 is
    port(
        IN_1: in std_logic;
        IN_2: in std_logic;
        IN_3: in std_logic;
        OUT_1: out std_logic;
        OUT_2: out std_logic;
        OUT_3: out std_logic
    );
end entity lc_ex03;

architecture arch of lc_ex03 is
    begin
        OUT_1 <= IN_1 and IN_2;
        -- OUT_2 <= OUT_2 and IN_2 and IN_3;   -- This should give us an error !
        OUT_2 <= IN_2 and IN_3;
        OUT_3 <= IN_1 or IN_2 or IN_3;
        -- OUT_3 <= IN_1 and IN_2 and IN_3;    -- We get an X value for OUT_3
end architecture arch;