library ieee;
use ieee.std_logic_1164.all;

entity lc_ex02_4bitRippleCarryAdder is
    port(
        a: in std_logic_vector(3 downto 0);
        b: in std_logic_vector(3 downto 0);
        s: out std_logic_vector(3 downto 0);
        cOut: out std_logic
    );
end entity lc_ex02_4bitRippleCarryAdder;

architecture arch of lc_ex02_4bitRippleCarryAdder is
    
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

    signal cIn1, cIn2, cIn3: std_logic;

    begin
        i0: lc_ex01_halfAdder port map(
            a => a(0),
            b => b(0),
            s => s(0),
            cOut => cIn1
        );

        i1: lc_ex01_fullAdder port map(
            a => a(1),
            b => b(1),
            cIn => cIn1,
            s => s(1),
            cOut => cIn2
        );

        i2: lc_ex01_fullAdder port map(
            a => a(2),
            b => b(2),
            cIn => cIn2,
            s => s(2),
            cOut => cIn3
        );

        i3: lc_ex01_fullAdder port map(
            a => a(3),
            b => b(3),
            cIn => cIn3,
            s => s(3),
            cOut => cOut
        );


end architecture arch;
