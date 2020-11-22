library ieee;
use ieee.std_logic_1164.all;

entity lc_ex05 is
    port(
        in1: in std_logic;
        in2: in std_logic;
        in3: in std_logic;
        out1: out std_logic;
        out2: out std_logic;
        out3: out std_logic
    );
end entity lc_ex05;

architecture arch of lc_ex05 is

    component lc_ex03 is
        port(
            in1: in std_logic;
            in2: in std_logic;
            in3: in std_logic;
            out1: out std_logic;
            out2: out std_logic;
            out3: out std_logic
        );
    end component lc_ex03;

    signal mid1, mid2, mid3: std_logic;

    begin
        i1: lc_ex03 port map(
            in1 => in1,
            in2 => in2,
            in3 => in3,
            out1 => mid1,
            out2 => mid2,
            out3 => mid3
        );

        i2: lc_ex03 port map(
            in1 => mid1,
            in2 => mid2,
            in3 => mid3,
            out1 => out1,
            out2 => out2,
            out3 => out3
        );

end architecture arch;