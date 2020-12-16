library ieee;
use ieee.std_logic_1164.all;

entity lc_ex02p01_shiftRegister is
    generic (N: integer := 4);
    port(
        D: in std_logic;
        EN: in std_logic;
        Q: out std_logic
    );
end entity lc_ex02p01_shiftRegister;

architecture arch of lc_ex02p01_shiftRegister is

    signal shift_register: std_logic_vector(N-1 downto 0);

    begin

        proc: process(EN)
            begin
                if (EN = '1') then
                    Q <= shift_register(N-1);

                    -- for i in N-1 to 1 loop
                    --     shift_register(i) <= shift_register(i-1);
                    -- end loop;

                    for i in 1 to N-1 loop
                        shift_register(i) <= shift_register(i-1);
                    end loop;

                    shift_register(0) <= D;
                end if;
        end process proc;

end architecture arch;
