library ieee;
use ieee.std_logic_1164.all;

entity tb_ex02p01_shiftRegister is
    generic(N_tb: integer := 4);
end entity tb_ex02p01_shiftRegister;

architecture arch of tb_ex02p01_shiftRegister is

    component lc_ex02p01_shiftRegister is
        generic(
            N: integer := 4
        );
        port(
            CLK: in std_logic;
            RESET: in std_logic;
            ENABLE: in std_logic;
            D: in std_logic;
            Q: out std_logic
        );
    end component lc_ex02p01_shiftRegister;

    signal clk, reset, enable, d, q: std_logic := '0';

    begin
        uut: lc_ex02p01_shiftRegister
        generic map(
            N => N_tb
        ) -- no ';' until the end of the component !
        port map(
            CLK => clk,
            RESET => reset,
            ENABLE => enable,
            D => d,
            Q => q
        );

        stim: process
            begin

                -- Fill the bit number 1 (xxx1)
                clk <= '0'; reset <= '0'; enable <= '1'; d <= '1';
                wait for 5 ns;
                clk <= '1'; reset <= '0'; enable <= '1'; d <= '1';
                wait for 5 ns;

                -- Fill the bit number 2 (xx10)
                clk <= '0'; reset <= '0'; enable <= '1'; d <= '0';
                wait for 5 ns;
                clk <= '1'; reset <= '0'; enable <= '1'; d <= '0';
                wait for 5 ns;

                -- Fill the bit number 3 (x101)
                clk <= '0'; reset <= '0'; enable <= '1'; d <= '1';
                wait for 5 ns;
                clk <= '1'; reset <= '0'; enable <= '1'; d <= '1';
                wait for 5 ns;

                -- Fill the bit number 4 (1010)
                clk <= '0'; reset <= '0'; enable <= '1'; d <= '0';
                wait for 5 ns;
                clk <= '1'; reset <= '0'; enable <= '1'; d <= '0';
                wait for 5 ns;

                -- What we have in the register so far: "1010".
                -- The register is full.
                -- Now, the uncertainty on the error should be gone (could have started by performing a reset...)

                -- Check the first output (1-0101)
                clk <= '0'; reset <= '0'; enable <= '1'; d <= '1';
                wait for 5 ns;
                clk <= '1'; reset <= '0'; enable <= '1'; d <= '1';
                wait for 5 ns;
                assert q = '1' report "Test 1 failed" severity error;

                -- Check the second output (0-1010)
                clk <= '0'; reset <= '0'; enable <= '1'; d <= '0';
                wait for 5 ns;
                clk <= '1'; reset <= '0'; enable <= '1'; d <= '0';
                wait for 5 ns;
                assert q = '0' report "Test 2 failed" severity error;

                -- Check the third output (1-0101)
                clk <= '0'; reset <= '0'; enable <= '1'; d <= '1';
                wait for 5 ns;
                clk <= '1'; reset <= '0'; enable <= '1'; d <= '1';
                wait for 5 ns;
                assert q = '1' report "Test 3 failed" severity error;

                -- Check the fourth output (0-1010)
                clk <= '0'; reset <= '0'; enable <= '1'; d <= '0';
                wait for 5 ns;
                clk <= '1'; reset <= '0'; enable <= '1'; d <= '0';
                wait for 5 ns;
                assert q = '0' report "Test 4 failed" severity error;

                -- Check that nothing happens when enable = 0 (shoud have the same output as above)
                clk <= '0'; reset <= '0'; enable <= '0'; d <= '1';
                wait for 5 ns;
                clk <= '1'; reset <= '0'; enable <= '0'; d <= '1';
                wait for 5 ns;
                assert q = '0' report "Test 5 failed" severity error;

                -- Check Reset
                -- Perform one extra normal operation to check that q goes from 1 to 0 when reset
                clk <= '0'; reset <= '0'; enable <= '1'; d <= '1';
                wait for 5 ns;
                clk <= '1'; reset <= '0'; enable <= '1'; d <= '1';
                wait for 5 ns;
                assert q = '1' report "Test 6 failed" severity error;

                -- Reset the register (q = 0 and register=0000)
                clk <= '0'; reset <= '1'; enable <= '1'; d <= '1';
                wait for 5 ns;
                clk <= '1'; reset <= '1'; enable <= '1'; d <= '1';
                wait for 5 ns;
                assert q = '0' report "Test 7 failed" severity error;   

                -- Check register(3)=0
                clk <= '0'; reset <= '0'; enable <= '1'; d <= '1';
                wait for 5 ns;
                clk <= '1'; reset <= '0'; enable <= '1'; d <= '1';
                wait for 5 ns;
                assert q = '0' report "Test 8 failed" severity error;

                -- Check register(2)=0
                clk <= '0'; reset <= '0'; enable <= '1'; d <= '1';
                wait for 5 ns;
                clk <= '1'; reset <= '0'; enable <= '1'; d <= '1';
                wait for 5 ns;
                assert q = '0' report "Test 9 failed" severity error;

                -- Check register(1)=0
                clk <= '0'; reset <= '0'; enable <= '1'; d <= '1';
                wait for 5 ns;
                clk <= '1'; reset <= '0'; enable <= '1'; d <= '1';
                wait for 5 ns;
                assert q = '0' report "Test 10 failed" severity error;

                -- Check register(0)=0
                clk <= '0'; reset <= '0'; enable <= '1'; d <= '1';
                wait for 5 ns;
                clk <= '1'; reset <= '0'; enable <= '1'; d <= '1';
                wait for 5 ns;
                assert q = '0' report "Test 11 failed" severity error;

                wait;
        end process stim;

end architecture arch;