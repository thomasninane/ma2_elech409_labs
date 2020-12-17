library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity lc_ex03_counter is
    generic (N: integer := 4);
    port(
        UP: in std_logic;
        RST: in std_logic;
        CLK: in std_logic;
        Q: out std_logic_vector(N-1 downto 0)
    );
end entity lc_ex03_counter;

architecture arch of lc_ex03_counter is

    signal cnt: std_logic_vector(N-1 downto 0);

    begin

        proc: process(UP, RST, CLK)
            begin
                if (RST = '1' and UP = '1') then                    
                    for i in 0 to N-1 loop
                        cnt(i) <= '0';
                    end loop;

                elsif (RST = '1' and UP = '0') then                    
                    for i in 0 to N-1 loop
                        cnt(i) <= '1';
                    end loop;
                end if;

                if (rising_edge(Clk) and RST = '0' and UP = '1') then
                    cnt <= cnt + 1;
                
                elsif (rising_edge(Clk) and RST = '0' and UP = '0') then
                    cnt <= cnt - 1;
                end if;
        end process proc;
        
        Q <= cnt;

end architecture arch;
