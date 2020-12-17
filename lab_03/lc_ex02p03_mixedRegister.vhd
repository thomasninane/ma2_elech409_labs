library ieee;
use ieee.std_logic_1164.all;

entity lc_ex02p03_mixedRegister is
    generic (N: integer := 4);
    port(
        D: in std_logic_vector(N-1 downto 0);
        LOAD: in std_logic;
        SERIAL: in std_logic;
        RST: in std_logic;
        Q: out std_logic_vector(N-1 downto 0)
    );
end entity lc_ex02p03_mixedRegister;

architecture arch of lc_ex02p03_mixedRegister is

    signal mixed_register: std_logic_vector(N-1 downto 0);

    begin

        proc: process(LOAD, SERIAL, RST)
            begin
                if (RST = '1') then                    
                    for i in 0 to N-1 loop
                        mixed_register(i) <= '0';
                    end loop;

                elsif (LOAD = '1' and SERIAL = '0') then
                    mixed_register <= D;

                elsif (LOAD = '1' and SERIAL = '1') then
                    -- Q(N-1 downto 1) <= Q(N-2 downto 0);  -- DOES NOT WORK! Output serves as input here...
                    for i in 1 to N-1 loop
                        mixed_register(i) <= mixed_register(i-1);
                    end loop;
                    mixed_register(0) <= D(0);
                end if;
        end process proc;
        
        Q <= mixed_register;

end architecture arch;


