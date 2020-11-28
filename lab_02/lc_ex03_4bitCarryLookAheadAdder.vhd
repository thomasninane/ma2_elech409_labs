library ieee;
use ieee.std_logic_1164.all;

entity lc_ex03_4bitCarryLookAheadAdder is
    port(
        -- input(s)
        a: in std_logic_vector(3 downto 0);
        b: in std_logic_vector(3 downto 0);
        cIn: in std_logic;
        -- output(s)
        s: out std_logic_vector(3 downto 0);
        cOut: out std_logic
    );
end entity lc_ex03_4bitCarryLookAheadAdder;

architecture arch of lc_ex03_4bitCarryLookAheadAdder is

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
    
    signal c1, c2, c3: std_logic;
    signal G, P: std_logic_vector(3 downto 0);

    begin
        PFA0: component lc_ex03_partialFullAdder port map(
            -- input(s)
            a => a(0),
            b => b(0),
            cIn => cIn,
            -- output(s)
            s => s(0),
            G => G(0),
            P => P(0)
        );

        PFA1: component lc_ex03_partialFullAdder port map(
            -- input(s)
            a => a(1),
            b => b(1),
            cIn => c1,  -- c1 is declared under
            -- output(s)
            s => s(1),
            G => G(1),
            P => P(1)
        );

        PFA2: component lc_ex03_partialFullAdder port map(
            -- input(s)
            a => a(2),
            b => b(2),
            cIn => c2,  -- c2 is declared under
            -- output(s)
            s => s(2),
            G => G(2),
            P => P(2)
        );

        PFA3: component lc_ex03_partialFullAdder port map(
            -- input(s)
            a => a(3),
            b => b(3),
            cIn => c3,  -- c3 is declared under
            -- output(s)
            s => s(3),
            G => G(3),
            P => P(3)
        );

        c1 <= G(0) or ( P(0) and cIn );
        c2 <= G(1) or ( P(1) and G(0) ) or ( P(1) and P(0) and cIn );
        c3 <= G(2) or ( P(2) and G(1) ) or ( P(2) and P(1) and G(0) ) or ( P(2) and P(1) and P(0) and cIn );
        cOut <= G(3) or ( P(3) and G(2) ) or ( P(3) and P(2) and G(1) ) or ( P(3) and P(2) and P(1) and G(0) ) or ( P(3) and P(2) and P(1) and P(0) and cIn );

end architecture arch;