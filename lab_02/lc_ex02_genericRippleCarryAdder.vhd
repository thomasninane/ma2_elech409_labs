library ieee;
use ieee.std_logic_1164.all;

entity lc_ex02_genericRippleCarryAdder is
    generic (N: integer := 4);
    port(
        a: in std_logic_vector(N-1 downto 0);
        b: in std_logic_vector(N-1 downto 0);
        s: out std_logic_vector(N-1 downto 0);
        cOut: out std_logic
    );
end entity lc_ex02_genericRippleCarryAdder;

architecture arch of lc_ex02_genericRippleCarryAdder is
    
    component lc_ex01_halfAdder is
        port(
            a: in std_logic;
            b: in std_logic;
            s: out std_logic;
            cOut: out std_logic
        );
    end component lc_ex01_halfAdder;

    component lc_ex01_fullAdder is
        port(
            a: in std_logic;
            b: in std_logic;
            cIn: in std_logic;
            s: out std_logic;
            cOut: out std_logic
        );
    end component lc_ex01_fullAdder;

    signal cIn: std_logic_vector(N-1 downto 1);

    begin
        start_component: lc_ex01_halfAdder port map(
            a => a(0),
            b => b(0),
            s => s(0),
            cOut => cIn(1)
        );

        mid_components: for i in 1 to N-2 generate
            component_i: lc_ex01_fullAdder port map(
                a => a(i),
                b => b(i),
                cIn => cIn(i),
                s => s(i),
                cOut => cIn(i+1)
            );
        end generate;

        end_component: lc_ex01_fullAdder port map(
            a => a(N-1),
            b => b(N-1),
            cIn => cIn(N-1),
            s => s(N-1),
            cOut => cOut
        );

end architecture arch;