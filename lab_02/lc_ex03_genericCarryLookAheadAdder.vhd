library ieee;
use ieee.std_logic_1164.all;

entity lc_ex03_genericCarryLookAheadAdder is
    generic(N: integer := 4);
    port(
        IN_1: in std_logic_vector(N-1 downto 0);
        IN_2: in std_logic_vector(N-1 downto 0);
        C_IN: in std_logic;
        OUT_1: out std_logic_vector(N-1 downto 0);
        C_OUT: out std_logic
    );
end entity lc_ex03_genericCarryLookAheadAdder;

architecture beh of lc_ex03_genericCarryLookAheadAdder is

    component lc_ex03_partialFullAdder is
        port(
            -- input(s)
            a: in std_logic;
            b: in std_logic;
            cIn: in std_logic;
            -- output(s)
            s: out std_logic;
            G: out std_logic;
            P: out std_logic
        );
    end component lc_ex03_partialFullAdder;

    signal c, g, p: std_logic_vector(N-1 downto 0);

    begin
        c(0) <= C_IN;
        signal_assignments: for i in 1 to N-2 generate
            c(i) <= g(i-1) or ( p(i-1) and c(i-1) );
        end generate;

        start: lc_ex03_partialFullAdder port map(
            a => IN_1(0),
            b => IN_2(0),
            cIn => C_IN,
            s => OUT_1(0),
            G => g(0),
            P => p(0)
        );

        mid: for i in 1 to N-2 generate
            mid_i: lc_ex03_partialFullAdder port map(
                a => IN_1(i),
                b => IN_2(i),
                cIn => c(i),
                s => OUT_1(i),
                G => g(i),
                P => p(i)
            );
        end generate;

        end: lc_ex03_partialFullAdder port map(
            a => IN_1(0),
            b => IN_2(0),
            cIn => C_IN,
            s => OUT_1(0),
            G => g(0),
            P => p(0)
        );

end architecture beh;