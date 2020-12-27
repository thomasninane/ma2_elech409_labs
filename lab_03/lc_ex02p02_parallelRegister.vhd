library ieee;
use ieee.std_logic_1164.all;

entity lc_ex02p02_parallelRegister is
    generic (N: integer := 4);
    port(
        CLK: in std_logic;
        RESET: in std_logic;
        LOAD: in std_logic;
        D: in std_logic_vector(N-1 downto 0);
        Q: out std_logic_vector(N-1 downto 0)
    );
end entity lc_ex02p02_parallelRegister;

architecture arch of lc_ex02p02_parallelRegister is

    begin

        proc: process(CLK, RESET, LOAD)
            begin
                if (RESET = '1') then
                    Q <= (others => '0');

                elsif (rising_edge(CLK)) then
                    if (LOAD = '1') then
                        Q <= D;
                    end if;
                end if;
        end process proc;

end architecture arch;

