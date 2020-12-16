library ieee;
use ieee.std_logic_1164.all;

entity lc_ex02p02_parallelRegister is
    generic (N: integer := 4);
    port(
        D: in std_logic_vector(N-1 downto 0);
        LOAD: in std_logic;
        Q: out std_logic_vector(N-1 downto 0)
    );
end entity lc_ex02p02_parallelRegister;

architecture arch of lc_ex02p02_parallelRegister is

    signal parallel_register: std_logic_vector(N-1 downto 0);

    begin

        proc: process(LOAD)
            begin
                if (LOAD = '1') then

                    -- for i in 0 to N-1 loop
                    --     Q(i) <= parallel_register(i-1);
                    -- end loop;

                    -- for i in 0 to N-1 loop
                    --     parallel_register(i) <= D(i);
                    -- end loop;
                    
                    Q <= parallel_register;
                    parallel_register <= D;
                end if;
        end process proc;

end architecture arch;

