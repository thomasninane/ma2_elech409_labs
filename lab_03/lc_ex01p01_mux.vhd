library ieee;
use ieee.std_logic_1164.all;

-- 4:1 MUX

entity lc_ex01p01_mux is
    port(
        SEL: in std_logic_vector(1 downto 0);
        D: in std_logic_vector(3 downto 0);
        Q: out std_logic        
    );
end entity lc_ex01p01_mux;

architecture arch of lc_ex01p01_mux is
    begin

        proc: process(D, SEL)
            -- Here, D must be part of the sensitivity list. This is not always the case (c.f. FFs).
            begin
                if (SEL(1)='0' and SEL(0)='0') then
                    -- sel = 00
                    Q <= D(0);

                elsif (SEL(1)='0' and SEL(0)='1') then
                    -- sel = 01
                    Q <= D(1);

                elsif (SEL(1)='1' and SEL(0)='0') then
                    -- sel = 10
                    Q <= D(2);

                else
                -- sel = 11
                    Q <= D(3);
                end if;
        end process proc;

end architecture arch;