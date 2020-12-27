library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity lc_ex03_counter is
    generic (N: integer := 4);
    port(
        CLK: in std_logic;
        RESET: in std_logic;
        UP: in std_logic;
        Q: out std_logic_vector(N-1 downto 0)
    );
end entity lc_ex03_counter;

architecture arch of lc_ex03_counter is

    signal count: std_logic_vector(N-1 downto 0);

    begin

        Q <= count;

        proc: process(CLK, RESET, UP)
            begin
                if (RESET = '1') then
                    if (UP = '1') then
                        count <= (others => '0');
                    else
                        count <= (others => '1');
                    end if;

                elsif (rising_edge(CLK)) then
                    if (UP = '1') then
                        count <= count + 1;
                    else
                        count <= count - 1;
                    end if;
                end if;
        end process proc;

end architecture arch;
