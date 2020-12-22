library ieee;
use ieee.std_logic_1164.all;

entity tb_ex03 is
end entity tb_ex03;

architecture arch of tb_ex03 is

    component lc_ex03 is
        port(
            RESET: in std_logic;
            CLK: in std_logic;
            ENABLE: in std_logic;
            UP: in std_logic;
            OUT_1: out std_logic_vector(1 downto 0)
        );
    end component lc_ex03;

    signal reset: std_logic;
    signal clk: std_logic;
    signal enable: std_logic;
    signal up: std_logic := '1';
    signal out_1: std_logic_vector(1 downto 0);

    begin
        uut: lc_ex03 port map(
            RESET => reset,
            CLK => clk,
            ENABLE => enable,
            UP => up,
            OUT_1 => out_1
        );

        stimulus: process
            begin

                -- Reset
                reset <= '1'; enable <= '0';
                clk <= '0';
                wait for 5ns;
                clk <= '1';
                wait for 5ns;
                assert((out_1 = "00")) report "Test 1 failed!" severity error;

                -- UP = '1'
                up <= '1';

                -- Check that the state is not updated if ENABLE='0' (output must always be "00")
                reset <= '0'; enable <= '0';
                clk <= '0';
                wait for 5ns;
                clk <= '1';
                wait for 5ns;
                assert((out_1 = "00")) report "Test 2 failed!" severity error;

                clk <= '0';
                wait for 5ns;
                clk <= '1';
                wait for 5ns;
                assert((out_1 = "00")) report "Test 3 failed!" severity error;

                -- Check that the state is updated if ENABLE='1' (00 -> 01 -> 10 -> 11 -> 00)
                reset <= '0'; enable <= '1';

                -- current state: state_zero --> next_state: state_one
                clk <= '0';
                wait for 5ns;
                clk <= '1';     -- next_state becomes current_state
                wait for 5ns;
                assert((out_1 = "01")) report "Test 4 failed!" severity error;

                -- current state: state_one --> next_state: state_two
                clk <= '0';
                wait for 5ns;
                clk <= '1';     -- next_state becomes current_state
                wait for 5ns;
                assert((out_1 = "10")) report "Test 5 failed!" severity error;

                -- current state: state_two --> next_state: state_three
                clk <= '0';
                wait for 5ns;
                clk <= '1';     -- next_state becomes current_state
                wait for 5ns;
                assert((out_1 = "11")) report "Test 6 failed!" severity error;

                -- current state: state_three --> next_state: state_zero
                clk <= '0';
                wait for 5ns;
                clk <= '1';     -- next_state becomes current_state
                wait for 5ns;
                assert((out_1 = "00")) report "Test 7 failed!" severity error;

                -- Check that reset works when ENABLE='0' (00 -> 01 -> 00)
                -- current state: state_zero --> next_state: state_one
                clk <= '0';
                wait for 5ns;
                clk <= '1';     -- next_state becomes current_state
                wait for 5ns;
                assert((out_1 = "01")) report "Test 8 failed!" severity error;

                reset <= '1'; enable <= '0';
                clk <= '0';
                wait for 5ns;
                clk <= '1';     -- synchronous reset --> rising edge of clk required!
                wait for 5ns;
                assert((out_1 = "00")) report "Test 9 failed!" severity error;

                -- Check that reset works when ENABLE='1' (00 -> 01 -> 00)
                -- current state: state_zero --> next_state: state_one
                reset <= '0'; enable <= '1';
                clk <= '0';
                wait for 5ns;
                clk <= '1';     -- next_state becomes current_state
                wait for 5ns;
                assert((out_1 = "01")) report "Test 10 failed!" severity error;

                reset <= '1'; enable <= '1';
                clk <= '0';
                wait for 5ns;
                clk <= '1';     -- synchronous reset --> rising edge of clk required!
                wait for 5ns;
                assert((out_1 = "00")) report "Test 11 failed!" severity error;

                -- UP = '0'
                up <= '0';

                -- Check that the state is not updated if ENABLE='0' (output must always be "00")
                reset <= '0'; enable <= '0';
                clk <= '0';
                wait for 5ns;
                clk <= '1';
                wait for 5ns;
                assert((out_1 = "00")) report "Test 12 failed!" severity error;

                clk <= '0';
                wait for 5ns;
                clk <= '1';
                wait for 5ns;
                assert((out_1 = "00")) report "Test 13 failed!" severity error;

                -- Check that the state is updated if ENABLE='1' (00 -> 11 -> 10 -> 01 -> 00)
                reset <= '0'; enable <= '1';

                -- current state: state_zero --> next_state: state_three
                clk <= '0';
                wait for 5ns;
                clk <= '1';     -- next_state becomes current_state
                wait for 5ns;
                assert((out_1 = "11")) report "Test 14 failed!" severity error;

                -- current state: state_three --> next_state: state_two
                clk <= '0';
                wait for 5ns;
                clk <= '1';     -- next_state becomes current_state
                wait for 5ns;
                assert((out_1 = "10")) report "Test 15 failed!" severity error;

                -- current state: state_two --> next_state: state_one
                clk <= '0';
                wait for 5ns;
                clk <= '1';     -- next_state becomes current_state
                wait for 5ns;
                assert((out_1 = "01")) report "Test 16 failed!" severity error;

                -- current state: state_one --> next_state: state_zero
                clk <= '0';
                wait for 5ns;
                clk <= '1';     -- next_state becomes current_state
                wait for 5ns;
                assert((out_1 = "00")) report "Test 17 failed!" severity error;

                -- Check that reset works when ENABLE='0' (00 -> 11 -> 00)
                -- current state: state_zero --> next_state: state_three
                clk <= '0';
                wait for 5ns;
                clk <= '1';     -- next_state becomes current_state
                wait for 5ns;
                assert((out_1 = "11")) report "Test 18 failed!" severity error;

                reset <= '1'; enable <= '0';
                clk <= '0';
                wait for 5ns;
                clk <= '1';     -- synchronous reset --> rising edge of clk required!
                wait for 5ns;
                assert((out_1 = "00")) report "Test 19 failed!" severity error;

                -- Check that reset works when ENABLE='1' (00 -> 11 -> 00)
                -- current state: state_zero --> next_state: state_three
                reset <= '0'; enable <= '1';
                clk <= '0';
                wait for 5ns;
                clk <= '1';     -- next_state becomes current_state
                wait for 5ns;
                assert((out_1 = "11")) report "Test 20 failed!" severity error;

                reset <= '1'; enable <= '1';
                clk <= '0';
                wait for 5ns;
                clk <= '1';     -- synchronous reset --> rising edge of clk required!
                wait for 5ns;
                assert((out_1 = "00")) report "Test 21 failed!" severity error;

        end process stimulus;

end architecture arch;


