library ieee;
use ieee.std_logic_1164.all;

-- 4:1 MUX

entity lc_ex01p01_mux is
    port(
        D: in std_logic_vector(3 downto 0);
        Q: out std_logic;
        SEL: in std_logic_vector(1 downto 0)
    );
end entity lc_ex01p01_mux;

architecture arch of lc_ex01p01_mux is
    begin

        proc: process(D, SEL)
            begin
                if (SEL(0)='0' and SEL(1)='0') then
                    Q <= D(3);
                elsif (SEL(0)='1' and SEL(1)='0') then
                    Q <= D(2);
                elsif (SEL(0)='0' and SEL(1)='1') then
                    Q <= D(1);
                else
                    Q <= D(0);
                end if;
        end process proc;

end architecture arch;