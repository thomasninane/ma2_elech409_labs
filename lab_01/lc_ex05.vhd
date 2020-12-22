library ieee;
use ieee.std_logic_1164.all;

entity lc_ex05 is
    port(
        IN_1: in std_logic;
        IN_2: in std_logic;
        IN_3: in std_logic;
        OUT_1: out std_logic;
        OUT_2: out std_logic;
        OUT_3: out std_logic
    );
end entity lc_ex05;

architecture arch of lc_ex05 is

    component lc_ex03 is
        port(
            IN_1: in std_logic;
            IN_2: in std_logic;
            IN_3: in std_logic;
            OUT_1: out std_logic;
            OUT_2: out std_logic;
            OUT_3: out std_logic
        );
    end component lc_ex03;

    signal mid_1, mid_2, mid_3: std_logic;

    begin
        i1: lc_ex03 port map(
            IN_1 => IN_1,
            IN_2 => IN_2,
            IN_3 => IN_3,
            OUT_1 => mid_1,
            OUT_2 => mid_2,
            OUT_3 => mid_3
        );

        i2: lc_ex03 port map(
            IN_1 => mid_1,
            IN_2 => mid_2,
            IN_3 => mid_3,
            OUT_1 => OUT_1,
            OUT_2 => OUT_2,
            OUT_3 => OUT_3
        );

end architecture arch;