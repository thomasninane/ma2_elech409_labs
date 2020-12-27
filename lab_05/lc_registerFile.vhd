library ieee;
use ieee.std_logic_1164.all;

entity lc_registerFile is
    port(
        CLK: in std_logic;
        RESET: in std_logic;
        RF_ENABLE: in std_logic;
        SEL: in std_logic_vector(2 downto 0);
        OPCODE: in std_logic_vector(1 downto 0);
        IN_1: in std_logic_vector(31 downto 0);
        OUT_1: out std_logic_vector(31 downto 0);
        OUT_2: out std_logic_vector(31 downto 0)
    );
end entity lc_registerFile;

architecture arch of lc_registerFile is

    -- type reg_store is array (0 to 7) of std_logic_vector(31 downto 0);
    -- signal registers: reg_store
    signal reg_0, reg_1, reg_2, reg_3, reg_4, reg_5, reg_6, reg_7: std_logic_vector(31 downto 0);

    begin
        proc: process(CLK, RESET, RF_ENABLE, OPCODE, SEL)
            begin
                if RESET = '1' then
                    reg_0 <= (others => '0');
                    reg_1 <= (others => '0');
                    reg_2 <= (others => '0');
                    reg_3 <= (others => '0');
                    reg_4 <= (others => '0');
                    reg_5 <= (others => '0');
                    reg_6 <= (others => '0');
                    reg_7 <= (others => '0');
                    OUT_1 <= (others => '0');
                    OUT_2 <= (others => '0');

                elsif rising_edge(CLK) then
                    if RF_ENABLE = '1' then
                        if OPCODE = "00" then
                            -- read register selected by SEL on OUT_1
                            case SEL is
                                when "000" => OUT_1 <= reg_0;
                                when "001" => OUT_1 <= reg_1;
                                when "010" => OUT_1 <= reg_2;
                                when "011" => OUT_1 <= reg_3;
                                when "100" => OUT_1 <= reg_4;
                                when "101" => OUT_1 <= reg_5;
                                when "110" => OUT_1 <= reg_6;
                                when others => OUT_1 <= reg_7;
                            end case;

                        elsif OPCODE = "01" then
                            -- read register selected by SEL on OUT_2
                            case SEL is
                                when "000" => OUT_2 <= reg_0;
                                when "001" => OUT_2 <= reg_1;
                                when "010" => OUT_2 <= reg_2;
                                when "011" => OUT_2 <= reg_3;
                                when "100" => OUT_2 <= reg_4;
                                when "101" => OUT_2 <= reg_5;
                                when "110" => OUT_2 <= reg_6;
                                when others => OUT_2 <= reg_7;
                            end case;

                        else
                            -- write
                            case SEL is
                                when "000" => reg_0 <= IN_1;
                                when "001" => reg_1 <= IN_1;
                                when "010" => reg_2 <= IN_1;
                                when "011" => reg_3 <= IN_1;
                                when "100" => reg_4 <= IN_1;
                                when "101" => reg_5 <= IN_1;
                                when "110" => reg_6 <= IN_1;
                                when others => reg_7 <= IN_1;
                            end case;

                        end if;
                    end if;
                end if;
        end process proc;
        
            

end architecture arch;
