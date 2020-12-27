library ieee;
use ieee.std_logic_1164.all;

entity tb_ex03 is
end entity tb_ex03;

architecture arch of tb_ex03 is

    component lc_ex03 is
        port(
            CLK: in std_logic;
            RESET: in std_logic;
            ENABLE: in std_logic;
            UP: in std_logic;
            OUT_1: out std_logic_vector(1 downto 0)
        );
    end component lc_ex03;

    signal clk, reset, enable, up: std_logic;
    signal out_1: std_logic_vector(1 downto 0);

    begin
        uut: lc_ex03 port map(
            CLK => clk,
            RESET => reset,
            ENABLE => enable,
            UP => up,
            OUT_1 => out_1
        );

        stim: process
            begin

                -- Synchronous reset with ENABLE = 0
                clk <= '0'; reset <= '1'; enable <= '0'; up <= '1';                
                wait for 5ns;
                clk <= '1'; reset <= '1'; enable <= '0'; up <= '1';
                wait for 5ns;
                assert out_1 = "00" report "Test 1 failed!" severity error;

                -- Normal operations with UP = 1 (q: 00 -> 01 -> 10 -> 11 -> 00)
                -- current state: state_zero --> next_state: state_one
                clk <= '0'; reset <= '0'; enable <= '1'; up <= '1';                
                wait for 5ns;
                clk <= '1'; reset <= '0'; enable <= '1'; up <= '1';     -- next_state becomes current_state
                wait for 5ns;
                assert out_1 = "01" report "Test 2 failed!" severity error;

                -- current state: state_one --> next_state: state_two
                clk <= '0'; reset <= '0'; enable <= '1'; up <= '1';                
                wait for 5ns;
                clk <= '1'; reset <= '0'; enable <= '1'; up <= '1';     -- next_state becomes current_state
                wait for 5ns;
                assert out_1 = "10" report "Test 3 failed!" severity error;

                -- current state: state_two --> next_state: state_three
                clk <= '0'; reset <= '0'; enable <= '1'; up <= '1';                
                wait for 5ns;
                clk <= '1'; reset <= '0'; enable <= '1'; up <= '1';     -- next_state becomes current_state
                wait for 5ns;
                assert out_1 = "11" report "Test 4 failed!" severity error;

                -- current state: state_three --> next_state: state_zero
                clk <= '0'; reset <= '0'; enable <= '1'; up <= '1';                
                wait for 5ns;
                clk <= '1'; reset <= '0'; enable <= '1'; up <= '1';     -- next_state becomes current_state
                wait for 5ns;
                assert out_1 = "00" report "Test 5 failed!" severity error;

                -- Synchronous reset with ENABLE = 1
                clk <= '0'; reset <= '1'; enable <= '1'; up <= '0';                
                wait for 5ns;
                clk <= '1'; reset <= '1'; enable <= '1'; up <= '0';
                wait for 5ns;
                assert out_1 = "00" report "Test 6 failed!" severity error;

                -- Normal operations with UP = 0 (q: 00 -> 11 -> 10 -> 01 -> 00)
                -- current state: state_zero --> next_state: state_three
                clk <= '0'; reset <= '0'; enable <= '1'; up <= '0';                
                wait for 5ns;
                clk <= '1'; reset <= '0'; enable <= '1'; up <= '0';     -- next_state becomes current_state
                wait for 5ns;
                assert out_1 = "11" report "Test 7 failed!" severity error;

                -- current state: state_three --> next_state: state_two
                clk <= '0'; reset <= '0'; enable <= '1'; up <= '0';                
                wait for 5ns;
                clk <= '1'; reset <= '0'; enable <= '1'; up <= '0';     -- next_state becomes current_state
                wait for 5ns;
                assert out_1 = "10" report "Test 8 failed!" severity error;

                -- current state: state_two --> next_state: state_one
                clk <= '0'; reset <= '0'; enable <= '1'; up <= '0';                
                wait for 5ns;
                clk <= '1'; reset <= '0'; enable <= '1'; up <= '0';     -- next_state becomes current_state
                wait for 5ns;
                assert out_1 = "01" report "Test 9 failed!" severity error;

                -- current state: state_one --> next_state: state_zero
                clk <= '0'; reset <= '0'; enable <= '1'; up <= '0';                
                wait for 5ns;
                clk <= '1'; reset <= '0'; enable <= '1'; up <= '0';     -- next_state becomes current_state
                wait for 5ns;
                assert out_1 = "00" report "Test 10 failed!" severity error;

                -- Check that the state is not updated if ENABLE = 0 (output must be the previous one)
                clk <= '0'; reset <= '0'; enable <= '0'; up <= '0';                
                wait for 5ns;
                clk <= '1'; reset <= '0'; enable <= '0'; up <= '0';
                wait for 5ns;
                assert out_1 = "00" report "Test 11 failed!" severity error;

                wait;

        end process stim;

end architecture arch;