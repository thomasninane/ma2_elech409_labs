library ieee;
use ieee.std_logic_1164.all;
-- use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity lc_ALU is
    port(
        CLK: in std_logic;
        RESET: in std_logic;
        OPCODE: in std_logic_vector(4 downto 0);
        IN_1: in std_logic_vector(31 downto 0);
        IN_2: in std_logic_vector(31 downto 0);
        OUT_1: out std_logic_vector(31 downto 0);
        CARRY: out std_logic
    );
end entity lc_ALU;

architecture arch of lc_ALU is

    -- signal temp: std_logic_vector(32 downto 0);     -- 32 downto 0 and not 31 downto 0 (for overflow / carry)

    begin
        -- OUT_1 <= temp(31 downto 0);
        -- CARRY <= temp(32);

        proc: process(CLK, OPCODE, RESET)
            variable temp: std_logic_vector(32 downto 0);     -- 32 downto 0 and not 31 downto 0 (for overflow / carry)
            begin
                if RESET = '1' then
                    -- temp <= (others => '0');
                    OUT_1 <= (others => '0');
                    CARRY <= '0';

                elsif rising_edge(CLK) then

                    if OPCODE = "00001" then
                        -- ADDITION
                        -- temp <= std_logic_vector(unsigned(IN_1) + unsigned(IN_2));
                        temp := ('0' & IN_1) + ('0' & IN_2);
                        OUT_1 <= temp(31 downto 0);
                        CARRY <= temp(32);
                        
                        

                    elsif OPCODE = "00010" then
                        -- SUBTRACTION
                        -- temp <= std_logic_vector(unsigned(IN_1) + unsigned(IN_2));
                        temp := ('0' & IN_1) - ('0' & IN_2);
                        OUT_1 <= temp(31 downto 0);
                        CARRY <= temp(32);

                    elsif OPCODE = "00100" then
                        -- AND
                        -- temp <= '0' & (IN_1 AND IN_2);
                        OUT_1 <= IN_1 AND IN_2;
                        CARRY <= '0';

                    elsif OPCODE = "01000" then
                        -- OR
                        -- temp <= '0' & (IN_1 OR IN_2);
                        OUT_1 <= IN_1 OR IN_2;
                        CARRY <= '0';

                    elsif OPCODE = "10000" then
                        -- NOT
                        -- temp <= '0' & (NOT IN_1);
                        OUT_1 <= NOT IN_1;
                        CARRY <= '0';

                    else
                        -- temp <= (others => '0');
                        OUT_1 <= (others => '0');
                        CARRY <= '0';
                    end if;

                end if;
        end process proc;
            

end architecture arch;