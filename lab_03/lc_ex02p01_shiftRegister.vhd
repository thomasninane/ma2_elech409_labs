library ieee;
use ieee.std_logic_1164.all;

entity lc_ex02p01_shiftRegister is
    generic (N: integer := 4);
    port(
        CLK: in std_logic;
        RESET: in std_logic;
        ENABLE: in std_logic;
        D: in std_logic;
        Q: out std_logic
    );
end entity lc_ex02p01_shiftRegister;

architecture arch of lc_ex02p01_shiftRegister is

    signal shift_register: std_logic_vector(N-1 downto 0);

    begin

        Q <= shift_register(N-1);

        proc: process(CLK, RESET, ENABLE)
            begin
                if (RESET = '1') then
                    shift_register <= (others => '0');

                elsif (rising_edge(CLK)) then
                    if (ENABLE = '1') then
                        
                        shift_register(0) <= D;
                        for i in 1 to N-1 loop
                            shift_register(i) <= shift_register(i-1);
                        end loop;

                    end if; 
                end if;
        end process proc;

end architecture arch;
