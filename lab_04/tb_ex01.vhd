library ieee;
use ieee.std_logic_1164.all;

entity tb_ex01 is
end entity tb_ex01;

architecture arch of tb_ex01 is

    component lc_ex01 is
        port(
            RESET: in std_logic;
            CLK: in std_logic;
            SWITCH: in std_logic;
            OUT_1: out std_logic
        );
    end component lc_ex01;

    signal reset: std_logic := '0';
    signal clk: std_logic := '0';
    signal switch: std_logic := '0';
    signal out_1: std_logic;

    begin
        uut: lc_ex01 port map(
            RESET => reset,
            CLK => clk,
            SWITCH => switch,
            OUT_1 => out_1
        );

        stimulus: process
            begin

                -- Reset (asynchronous)
                clk <= '0'; reset <= '1'; switch <= '0';
                wait for 10ns;
                assert ((out_1 = '0')) report "Test 1 failed!" severity error;

                clk <= '1'; reset <= '1'; switch <= '0';
                wait for 10ns;
                assert ((out_1 = '0')) report "Test 2 failed!" severity error;

                -- Check that the state is updated if SWITCH='1' (0 -> 1 -> 0)
                reset <= '0'; switch <= '1';

                -- current state: inactive --> next_state: active
                clk <= '0';
                wait for 5ns;
                clk <= '1';     -- next_state becomes current_state
                wait for 5ns;
                assert ((out_1 = '1')) report "Test 3 failed!" severity error;

                -- current state: active --> next_state: inactive
                clk <= '0';
                wait for 5ns;
                clk <= '1';     -- next_state becomes current_state
                wait for 5ns;
                assert ((out_1 = '0')) report "Test 4 failed!" severity error;

                -- Check that reset works when SWITCH='0' (0 -> 1 -> 0)
                -- current state: inactive --> next_state: active
                clk <= '0';
                wait for 5ns;
                clk <= '1';     -- next_state becomes current_state
                wait for 5ns;
                assert((out_1 = '1')) report "Test 5 failed!" severity error;

                reset <= '1'; switch <= '0';
                clk <= '0';
                wait for 5ns;
                clk <= '1';     -- synchronous reset --> rising edge of clk required!
                wait for 5ns;
                assert((out_1 = '0')) report "Test 6 failed!" severity error;

                -- Check that reset works when SWITCH='1' (0 -> 1 -> 0)
                -- current state: inactive --> next_state: active
                reset <= '0'; switch <= '1';
                clk <= '0';
                wait for 5ns;
                clk <= '1';     -- next_state becomes current_state
                wait for 5ns;
                assert((out_1 = '1')) report "Test 7 failed!" severity error;

                reset <= '1'; switch <= '1';
                clk <= '0';
                wait for 5ns;
                clk <= '1';     -- synchronous reset --> rising edge of clk required!
                wait for 5ns;
                assert((out_1 = '0')) report "Test 8 failed!" severity error;


        end process stimulus;

end architecture arch;
