library ieee;
use ieee.std_logic_1164.all;

entity tb_ex01 is

end entity tb_ex01;

architecture arch of tb_ex01 is

    component lc_ex01 is
        port(
            RESET: in std_logic;
            CLK: in std_logic;
            SWITCH: in std_logic
        );
    end component lc_ex01;

    signal reset: std_logic;
    signal clk: std_logic;
    signal switch: std_logic;

    begin
        uut: lc_ex01 port map(
            RESET => reset,
            CLK => clk,
            SWITCH => switch
        );

        stimulus: process
            begin

                clk <= '0'; reset <= '1'; switch <= '0';
                wait for 10ns;
                clk <= '1'; reset <= '1'; switch <= '0';
                wait for 10ns;

                clk <= '0'; reset <= '0'; switch <= '0';
                wait for 10ns;
                clk <= '1'; reset <= '0'; switch <= '1';
                wait for 10ns;

        end process stimulus;

end architecture arch;
