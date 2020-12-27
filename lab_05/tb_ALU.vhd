library ieee;
use ieee.std_logic_1164.all;

entity tb_ALU is
end entity tb_ALU;

architecture arch of tb_ALU is

    component lc_ALU is
        port(
            CLK: in std_logic;
            RESET: in std_logic;
            OPCODE: in std_logic_vector(4 downto 0);
            IN_1: in std_logic_vector(31 downto 0);
            IN_2: in std_logic_vector(31 downto 0);
            OUT_1: out std_logic_vector(31 downto 0);
            CARRY: out std_logic
        );
    end component lc_ALU;

    signal clk, reset: std_logic := '0';
    signal opcode: std_logic_vector(4 downto 0) := (others => '0');
    signal in_1, in_2: std_logic_vector(31 downto 0) := (others => '0');

    signal carry: std_logic;
    signal out_1: std_logic_vector(31 downto 0);
    

    begin
        uut: lc_ALU port map(
            CLK => clk,
            RESET => reset,
            OPCODE => opcode,
            IN_1 => in_1,
            IN_2 => in_2,
            OUT_1 => out_1,
            CARRY => carry
        );

        stim: process
            begin
                
                -- Asynchronous reset
                reset <= '1';
                wait for 10ns;
                assert carry = '0' and out_1 = "00000000000000000000000000000000" report "Test failed for RESET" severity error;

                reset <= '0';

                -- Test: ADDITION
                opcode <= "00001";
                in_1 <= "00000000000000000000000000000000";
                in_2 <= "00000000000000000000000000000001";
                clk <= '0';
                wait for 5ns;
                clk <= '1';
                wait for 5ns;
                assert carry = '0' and out_1 = "00000000000000000000000000000001" report "Test failed for ADDITION (1)" severity error;

                opcode <= "00001";
                in_1 <= "11111111111111111111111111111111";
                in_2 <= "00000000000000000000000000000001";
                clk <= '0';
                wait for 5ns;
                clk <= '1';
                wait for 5ns;
                assert carry = '1' and out_1 = "00000000000000000000000000000000" report "Test failed for ADDITION (2)" severity error;

                opcode <= "00001";
                in_1 <= "11111111111111111111111111111111";
                in_2 <= "11111111111111111111111111111111";
                clk <= '0';
                wait for 5ns;
                clk <= '1';
                wait for 5ns;
                assert carry = '1' and out_1 = "11111111111111111111111111111110" report "Test failed for ADDITION (3)" severity error;

                -- Test: SUBTRACTION
                opcode <= "00010";
                in_1 <= "11111111111111111111111111111111";
                in_2 <= "00000000000000000000000000000001";
                clk <= '0';
                wait for 5ns;
                clk <= '1';
                wait for 5ns;
                assert carry = '0' and out_1 = "11111111111111111111111111111110" report "Test failed for SUBTRACTION (1)" severity error;
                
                -- Test: AND
                opcode <= "00100";
                in_1 <= "10101010101010101010101010101010";
                in_2 <= "01010101010101010101010101010101";
                clk <= '0';
                wait for 5ns;
                clk <= '1';
                wait for 5ns;
                assert out_1 = "00000000000000000000000000000000" report "Test failed for AND (1)" severity error;

                opcode <= "00100";
                in_1 <= "11111111111111111111111111111111";
                in_2 <= "11111111111111111111111111111111";
                clk <= '0';
                wait for 5ns;
                clk <= '1';
                wait for 5ns;
                assert out_1 = "11111111111111111111111111111111" report "Test failed for AND (2)" severity error;

                opcode <= "00100";
                in_1 <= "10011001100110011001100110011001";
                in_2 <= "11001100110011001100110011001100";
                clk <= '0';
                wait for 5ns;
                clk <= '1';
                wait for 5ns;
                assert out_1 = "10001000100010001000100010001000" report "Test failed for AND (3)" severity error;

                -- Test: OR
                opcode <= "01000";
                in_1 <= "10101010101010101010101010101010";
                in_2 <= "01010101010101010101010101010101";
                clk <= '0';
                wait for 5ns;
                clk <= '1';
                wait for 5ns;
                assert out_1 = "11111111111111111111111111111111" report "Test failed for OR (1)" severity error;

                opcode <= "01000";
                in_1 <= "00001101000011010000110100001101";
                in_2 <= "00011001000110010001100100011001";
                clk <= '0';
                wait for 5ns;
                clk <= '1';
                wait for 5ns;
                assert out_1 = "00011101000111010001110100011101" report "Test failed for OR (2)" severity error;

                opcode <= "01000";
                in_1 <= "00000000000000000000000000000000";
                in_2 <= "00000000000000000000000000000000";
                clk <= '0';
                wait for 5ns;
                clk <= '1';
                wait for 5ns;
                assert out_1 = "00000000000000000000000000000000" report "Test failed for OR (2)" severity error;

                -- Test: NOT
                opcode <= "10000";
                in_1 <= "10101010101010101010101010101010";
                in_2 <= (others => '0');
                clk <= '0';
                wait for 5ns;
                clk <= '1';
                wait for 5ns;
                assert out_1 = "01010101010101010101010101010101" report "Test failed for NOT (1)" severity error;

                opcode <= "10000";
                in_1 <= "11111111111111111111111111111111";
                in_2 <= (others => '0');
                clk <= '0';
                wait for 5ns;
                clk <= '1';
                wait for 5ns;
                assert out_1 = "00000000000000000000000000000000" report "Test failed for NOT (2)" severity error;

                opcode <= "10000";
                in_1 <= "11110000111100001111000011110000";
                in_2 <= (others => '0');
                clk <= '0';
                wait for 5ns;
                clk <= '1';
                wait for 5ns;
                assert out_1 = "00001111000011110000111100001111" report "Test failed for NOT (3)" severity error;

                -- Test: ELSE
                opcode <= "11111";
                in_1 <= "00001101000011010000110100001101";
                in_2 <= "00011001000110010001100100011001";
                clk <= '0';
                wait for 5ns;
                clk <= '1';
                wait for 5ns;
                assert out_1 = "00000000000000000000000000000000" report "Test failed for ELSE" severity error;

                wait;

        end process stim;

end architecture arch;