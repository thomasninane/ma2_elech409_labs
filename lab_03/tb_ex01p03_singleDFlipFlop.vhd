library ieee;
use ieee.std_logic_1164.all;

entity tb_ex01p03_singleDFlipFlop is
end entity tb_ex01p03_singleDFlipFlop;

architecture arch of tb_ex01p03_singleDFlipFlop is

    component lc_ex01p03_singleDFlipFlop is
        port(
            CLK: in std_logic;
            RESET: in std_logic;
            ENABLE: in std_logic;
            D: in std_logic;
            Q: out std_logic
        );
    end component lc_ex01p03_singleDFlipFlop;

    signal clk: std_logic := '0';
    signal reset: std_logic := '0';
    signal enable: std_logic := '0';
    signal d: std_logic := '0';
    signal q: std_logic := '0';

    begin
        uut: lc_ex01p03_singleDFlipFlop port map(
            CLK => clk,
            RESET => reset,
            D => d,
            ENABLE => enable,
            Q => q
        );

        stim: process
            begin

                -- Asynchronous reset
                clk <= '0'; reset <= '1'; enable <= '0'; d <= '1';
                wait for 5ns;
                assert q = '0' report "Test failed for reset (1)" severity error;

                clk <= '1'; reset <= '1'; enable <= '0'; d <= '1';
                wait for 5ns;
                assert q = '0' report "Test failed for reset (2)" severity error;
                
                -- Check that nothing happens if enable = 0
                clk <= '0'; reset <= '0'; enable <= '0'; d <= '1';
                wait for 5ns;
                assert q = '0' report "Test failed for enable = 0 (1)" severity error;

                clk <= '1'; reset <= '0'; enable <= '0'; d <= '1';
                wait for 5ns;
                assert q = '0' report "Test failed for enable = 0 (2)" severity error;

                -- Check normal operation (d=1)
                clk <= '0'; reset <= '0'; enable <= '1'; d <= '1';
                wait for 5ns;
                assert q = '0' report "Test 1 failed" severity error;

                clk <= '1'; reset <= '0'; enable <= '1'; d <= '1';
                wait for 5ns;
                assert q = '1' report "Test 2 failed" severity error;

                -- Check normal operation (d=0)
                clk <= '0'; reset <= '0'; enable <= '1'; d <= '0';
                wait for 5ns;
                assert q = '1' report "Test 3 failed" severity error;

                clk <= '1'; reset <= '0'; enable <= '1'; d <= '0';
                wait for 5ns;
                assert q = '0' report "Test 4 failed" severity error;

                -- Check normal operation (d=1)
                clk <= '0'; reset <= '0'; enable <= '1'; d <= '1';
                wait for 5ns;
                assert q = '0' report "Test 5 failed" severity error;

                clk <= '1'; reset <= '0'; enable <= '1'; d <= '1';
                wait for 5ns;
                assert q = '1' report "Test 6 failed" severity error;

                -- Check that nothing happens if enable = 0
                clk <= '0'; reset <= '0'; enable <= '0'; d <= '0';
                wait for 5ns;
                assert q = '1' report "Test failed for enable = 0 (3)" severity error;

                clk <= '1'; reset <= '0'; enable <= '0'; d <= '0';
                wait for 5ns;
                assert q = '1' report "Test failed for enable = 0 (4)" severity error;

                -- Asynchronous reset
                clk <= '0'; reset <= '1'; enable <= '0'; d <= '1';
                wait for 5ns;
                assert q = '0' report "Test failed for reset (3)" severity error;

                clk <= '1'; reset <= '1'; enable <= '0'; d <= '1';
                wait for 5ns;
                assert q = '0' report "Test failed for reset (4)" severity error;

                wait;

        end process stim;

end architecture arch;
