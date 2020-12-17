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
                    Q <= D;
                end if;
        end process proc;

end architecture arch;

