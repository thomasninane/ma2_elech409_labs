library ieee;
use ieee.std_logic_1164.all;

entity tb_registerFile is
end entity tb_registerFile;

architecture arch of tb_registerFile is

    component lc_registerFile is
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
    end component lc_registerFile;

    signal clk, reset, rf_enable: std_logic := '0';
    signal opcode: std_logic_vector(1 downto 0) := (others => '0');
    signal sel: std_logic_vector(2 downto 0) := (others => '0');
    signal in_1: std_logic_vector(31 downto 0) := (others => '0');

    signal out_1, out_2: std_logic_vector(31 downto 0);

    begin
        uut: lc_registerFile port map(
            CLK => clk,
            RESET => reset,
            RF_ENABLE => rf_enable,
            SEL => sel,
            OPCODE => opcode,
            IN_1 => in_1,
            OUT_1 => out_1,
            OUT_2 => out_2
        );

        stim: process
            begin
                -- Asynchronous reset
                reset <= '1';
                wait for 10ns;
                assert out_1 = "00000000000000000000000000000000" report "Test failed for RESET (out_1)" severity error;
                assert out_2 = "00000000000000000000000000000000" report "Test failed for RESET (out_2)" severity error;

                -- Check that reset has worked on all registers
                clk <= '0'; reset <= '0'; rf_enable <= '1'; sel <= "000"; opcode <= "00"; in_1 <= "00000000000000000000000000000000";
                wait for 5ns;
                clk <= '1';
                wait for 5ns;
                assert out_1 = "00000000000000000000000000000000" report "Test failed for RESET (reg_0)" severity error;

                -- Write data to all registers
                clk <= '0'; reset <= '0'; rf_enable <= '1'; sel <= "000"; opcode <= "11"; in_1 <= "10000000000000000000000000000000";
                wait for 5ns;
                clk <= '1';
                wait for 5ns;

                clk <= '0'; reset <= '0'; rf_enable <= '1'; sel <= "001"; opcode <= "11"; in_1 <= "11000000000000000000000000000000";
                wait for 5ns;
                clk <= '1';
                wait for 5ns;

                clk <= '0'; reset <= '0'; rf_enable <= '1'; sel <= "010"; opcode <= "11"; in_1 <= "11100000000000000000000000000000";
                wait for 5ns;
                clk <= '1';
                wait for 5ns;

                clk <= '0'; reset <= '0'; rf_enable <= '1'; sel <= "011"; opcode <= "11"; in_1 <= "11110000000000000000000000000000";
                wait for 5ns;
                clk <= '1';
                wait for 5ns;

                clk <= '0'; reset <= '0'; rf_enable <= '1'; sel <= "100"; opcode <= "11"; in_1 <= "11111000000000000000000000000000";
                wait for 5ns;
                clk <= '1';
                wait for 5ns;

                clk <= '0'; reset <= '0'; rf_enable <= '1'; sel <= "101"; opcode <= "11"; in_1 <= "11111100000000000000000000000000";
                wait for 5ns;
                clk <= '1';
                wait for 5ns;

                clk <= '0'; reset <= '0'; rf_enable <= '1'; sel <= "110"; opcode <= "11"; in_1 <= "11111110000000000000000000000000";
                wait for 5ns;
                clk <= '1';
                wait for 5ns;

                clk <= '0'; reset <= '0'; rf_enable <= '1'; sel <= "111"; opcode <= "11"; in_1 <= "11111111000000000000000000000000";
                wait for 5ns;
                clk <= '1';
                wait for 5ns;

                -- Read data from all registers on out_1
                clk <= '0'; reset <= '0'; rf_enable <= '1'; sel <= "000"; opcode <= "00"; in_1 <= "10000000000000000000000000000000";
                wait for 5ns;
                clk <= '1';
                wait for 5ns;
                assert out_1 = "10000000000000000000000000000000" report "Test failed for READ on OUT_1 (reg_0)" severity error;

                clk <= '0'; reset <= '0'; rf_enable <= '1'; sel <= "001"; opcode <= "00"; in_1 <= "11000000000000000000000000000000";
                wait for 5ns;
                clk <= '1';
                wait for 5ns;
                assert out_1 = "11000000000000000000000000000000" report "Test failed for READ on OUT_1 (reg_1)" severity error;

                clk <= '0'; reset <= '0'; rf_enable <= '1'; sel <= "010"; opcode <= "00"; in_1 <= "11100000000000000000000000000000";
                wait for 5ns;
                clk <= '1';
                wait for 5ns;
                assert out_1 = "11100000000000000000000000000000" report "Test failed for READ on OUT_1 (reg_2)" severity error;

                clk <= '0'; reset <= '0'; rf_enable <= '1'; sel <= "011"; opcode <= "00"; in_1 <= "11110000000000000000000000000000";
                wait for 5ns;
                clk <= '1';
                wait for 5ns;
                assert out_1 = "11110000000000000000000000000000" report "Test failed for READ on OUT_1 (reg_3)" severity error;

                clk <= '0'; reset <= '0'; rf_enable <= '1'; sel <= "100"; opcode <= "00"; in_1 <= "11111000000000000000000000000000";
                wait for 5ns;
                clk <= '1';
                wait for 5ns;
                assert out_1 = "11111000000000000000000000000000" report "Test failed for READ on OUT_1 (reg_4)" severity error;

                clk <= '0'; reset <= '0'; rf_enable <= '1'; sel <= "101"; opcode <= "00"; in_1 <= "11111100000000000000000000000000";
                wait for 5ns;
                clk <= '1';
                wait for 5ns;
                assert out_1 = "11111100000000000000000000000000" report "Test failed for READ on OUT_1 (reg_5)" severity error;

                clk <= '0'; reset <= '0'; rf_enable <= '1'; sel <= "110"; opcode <= "00"; in_1 <= "11111110000000000000000000000000";
                wait for 5ns;
                clk <= '1';
                wait for 5ns;
                assert out_1 = "11111110000000000000000000000000" report "Test failed for READ on OUT_1 (reg_6)" severity error;

                clk <= '0'; reset <= '0'; rf_enable <= '1'; sel <= "111"; opcode <= "00"; in_1 <= "11111111000000000000000000000000";
                wait for 5ns;
                clk <= '1';
                wait for 5ns;
                assert out_1 = "11111111000000000000000000000000" report "Test failed for READ on OUT_1 (reg_7)" severity error;

                -- Read data from all registers on out_2
                clk <= '0'; reset <= '0'; rf_enable <= '1'; sel <= "000"; opcode <= "01"; in_1 <= "10000000000000000000000000000000";
                wait for 5ns;
                clk <= '1';
                wait for 5ns;
                assert out_2 = "10000000000000000000000000000000" report "Test failed for READ on OUT_2 (reg_0)" severity error;

                clk <= '0'; reset <= '0'; rf_enable <= '1'; sel <= "001"; opcode <= "01"; in_1 <= "11000000000000000000000000000000";
                wait for 5ns;
                clk <= '1';
                wait for 5ns;
                assert out_2 = "11000000000000000000000000000000" report "Test failed for READ on OUT_2 (reg_1)" severity error;

                clk <= '0'; reset <= '0'; rf_enable <= '1'; sel <= "010"; opcode <= "01"; in_1 <= "11100000000000000000000000000000";
                wait for 5ns;
                clk <= '1';
                wait for 5ns;
                assert out_2 = "11100000000000000000000000000000" report "Test failed for READ on OUT_2 (reg_2)" severity error;

                clk <= '0'; reset <= '0'; rf_enable <= '1'; sel <= "011"; opcode <= "01"; in_1 <= "11110000000000000000000000000000";
                wait for 5ns;
                clk <= '1';
                wait for 5ns;
                assert out_2 = "11110000000000000000000000000000" report "Test failed for READ on OUT_2 (reg_3)" severity error;

                clk <= '0'; reset <= '0'; rf_enable <= '1'; sel <= "100"; opcode <= "01"; in_1 <= "11111000000000000000000000000000";
                wait for 5ns;
                clk <= '1';
                wait for 5ns;
                assert out_2 = "11111000000000000000000000000000" report "Test failed for READ on OUT_2 (reg_4)" severity error;

                clk <= '0'; reset <= '0'; rf_enable <= '1'; sel <= "101"; opcode <= "01"; in_1 <= "11111100000000000000000000000000";
                wait for 5ns;
                clk <= '1';
                wait for 5ns;
                assert out_2 = "11111100000000000000000000000000" report "Test failed for READ on OUT_2 (reg_5)" severity error;

                clk <= '0'; reset <= '0'; rf_enable <= '1'; sel <= "110"; opcode <= "01"; in_1 <= "11111110000000000000000000000000";
                wait for 5ns;
                clk <= '1';
                wait for 5ns;
                assert out_2 = "11111110000000000000000000000000" report "Test failed for READ on OUT_2 (reg_6)" severity error;

                clk <= '0'; reset <= '0'; rf_enable <= '1'; sel <= "111"; opcode <= "01"; in_1 <= "11111111000000000000000000000000";
                wait for 5ns;
                clk <= '1';
                wait for 5ns;
                assert out_2 = "11111111000000000000000000000000" report "Test failed for READ on OUT_2 (reg_7)" severity error;

                -- Check that we can't read the registers if RF_ENABLE = 0
                -- Try to read reg_0 but out_2 should stay the same as above (reg_7)
                clk <= '0'; reset <= '0'; rf_enable <= '0'; sel <= "000"; opcode <= "01"; in_1 <= "11111111000000000000000000000000";
                wait for 5ns;
                clk <= '1';
                wait for 5ns;
                assert out_2 = "11111111000000000000000000000000" report "Test failed for READ on OUT_2 (reg_7) when RF_ENABLE = 0" severity error;

                -- Check that we can't write the registers if RF_ENABLE = 0
                -- Try to write to reg_0 and then, read reg_0 (should get old value of reg_0)
                clk <= '0'; reset <= '0'; rf_enable <= '0'; sel <= "000"; opcode <= "11"; in_1 <= "11111111111111111111111111111111";
                wait for 5ns;
                clk <= '1';
                wait for 5ns;

                clk <= '0'; reset <= '0'; rf_enable <= '1'; sel <= "000"; opcode <= "01"; in_1 <= "10000000000000000000000000000000";
                wait for 5ns;
                clk <= '1';
                wait for 5ns;
                assert out_2 = "10000000000000000000000000000000" report "Test failed for READ on OUT_2 (reg_0)" severity error;
                
                wait;

        end process stim;

end architecture arch;
