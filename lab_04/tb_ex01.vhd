library ieee;
use ieee.std_logic_1164.all;

entity tb_ex01 is
end entity tb_ex01;

architecture arch of tb_ex01 is

    component lc_ex01 is
        port(
            CLK: in std_logic;
            RESET: in std_logic;
            SWITCH: in std_logic;
            OUT_1: out std_logic
        );
    end component lc_ex01;

    signal clk, reset, switch, out_1: std_logic := '0';

    begin
        uut: lc_ex01 port map(
            CLK => clk,
            RESET => reset,
            SWITCH => switch,
            OUT_1 => out_1
        );

        stim: process
            begin

                -- Asynchronous reset with SWITCH = 0
                clk <= '0'; reset <= '1'; switch <= '0';
                wait for 5ns;
                assert out_1 = '0' report "Test 1.1 failed!" severity error;

                clk <= '1'; reset <= '1'; switch <= '0';
                wait for 5ns;
                assert out_1 = '0' report "Test 1.2 failed!" severity error;

                -- Normal operations (q: 0 -> 1 -> 0 -> 1)
                -- current state: inactive --> next_state: active
                clk <= '0'; reset <= '0'; switch <= '1';
                wait for 5ns;
                clk <= '1'; reset <= '0'; switch <= '1';     -- next_state becomes current_state
                wait for 5ns;
                assert out_1 = '1' report "Test 2 failed!" severity error;

                -- current state: active --> next_state: inactive
                clk <= '0'; reset <= '0'; switch <= '1';
                wait for 5ns;
                clk <= '1'; reset <= '0'; switch <= '1';     -- next_state becomes current_state
                wait for 5ns;
                assert out_1 = '0' report "Test 3 failed!" severity error;

                -- current state: inactive --> next_state: active
                clk <= '0'; reset <= '0'; switch <= '1';
                wait for 5ns;
                clk <= '1'; reset <= '0'; switch <= '0';     -- next_state becomes current_state. Compute of next_state is immediately performed.
                wait for 5ns;
                assert out_1 = '1' report "Test 4 failed!" severity error;

                -- Check that the state does not change if SWITCH = 0
                clk <= '0'; reset <= '0'; switch <= '0';
                wait for 5ns;
                clk <= '1'; reset <= '0'; switch <= '0';
                wait for 5ns;
                assert out_1 = '1' report "Test 5 failed!" severity error;

                -- Asynchronous reset with SWITCH = 1
                clk <= '0'; reset <= '1'; switch <= '1';
                wait for 5ns;
                assert out_1 = '0' report "Test 6.1 failed!" severity error;

                clk <= '1'; reset <= '1'; switch <= '1';
                wait for 5ns;
                assert out_1 = '0' report "Test 6.2 failed!" severity error;

                wait;

        end process stim;

end architecture arch;