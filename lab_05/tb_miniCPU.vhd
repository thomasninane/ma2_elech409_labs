library ieee;
use ieee.std_logic_1164.all;

entity tb_miniCPU is
    generic (clk_periodd_tb: time := 10 ns);
end entity tb_miniCPU;

architecture arch of tb_miniCPU is

    component lc_miniCPU is
        generic (clk_period: time := 10 ns);
        port(
            RESET: std_logic;
            IN_1: in std_logic_vector(31 downto 0);
            OUT_1: out std_logic_vector(31 downto 0);
            OUT_CLK: out std_logic;
            ALU_OPCODE: in std_logic_vector(4 downto 0);
            RF_OPCODE: in std_logic_vector(1 downto 0);
            REG_SEL: in std_logic_vector(2 downto 0);
            RF_ENABLE: in std_logic;
            RF_IN_SEL: in std_logic
            -- RF_OUT_SEL: in std_logic
        );
    end component lc_miniCPU;

    signal reset, rf_enable, rf_in_sel: std_logic := '0';
    signal in_1: std_logic_vector(31 downto 0) := (others => '0');
    signal alu_opcode: std_logic_vector(4 downto 0) := (others => '0');
    signal rf_opcode: std_logic_vector(1 downto 0) := (others => '0');
    signal reg_sel: std_logic_vector(2 downto 0) := (others => '0');

    signal out_1: std_logic_vector(31 downto 0);
    signal out_clk: std_logic;

    begin
        uut: lc_miniCPU
        generic map(
            clk_period => clk_periodd_tb
        )
        port map(
            RESET => reset,
            IN_1 => in_1,
            OUT_1 => out_1,
            OUT_CLK => out_clk,
            ALU_OPCODE => alu_opcode,
            RF_OPCODE => rf_opcode,
            REG_SEL => reg_sel,
            RF_ENABLE => rf_enable,
            RF_IN_SEL => rf_in_sel
        );

        proc: process

            begin

                -- Reset
                reset <= '1';
                rf_opcode <= "00"; reg_sel <= "000"; rf_enable <= '1'; rf_in_sel <= '0';
                wait for clk_periodd_tb;
                assert out_1 = "00000000000000000000000000000000" report "Test failed for RESET" severity error;

                -- Write data to registers (RF0 and RF1)
                reset <= '0';
                
                rf_opcode <= "11"; reg_sel <= "000"; rf_enable <= '1'; rf_in_sel <= '1'; in_1 <= "00000000000000000000000000000001";
                wait for clk_periodd_tb;

                rf_opcode <= "11"; reg_sel <= "001"; rf_enable <= '1'; rf_in_sel <= '1'; in_1 <= "00000000000000000000000000000011";
                wait for clk_periodd_tb;

                -- Read RF0 and RF1
                rf_opcode <= "00"; reg_sel <= "000"; rf_enable <= '1'; rf_in_sel <= '0'; in_1 <= "00000000000000000000000000000000";
                wait for clk_periodd_tb;
                assert out_1 = "00000000000000000000000000000001" report "Test failed for READ reg_0" severity error;

                rf_opcode <= "00"; reg_sel <= "001"; rf_enable <= '1'; rf_in_sel <= '0'; in_1 <= "00000000000000000000000000000000";
                wait for clk_periodd_tb;
                assert out_1 = "00000000000000000000000000000011" report "Test failed for READ reg_1" severity error;

                -- RF2 = RF0 + RF1 (MAKE SURE RF1 and RF2 do not overflow!)
                -- Place RF0 on ALU_in_1
                rf_opcode <= "00"; reg_sel <= "000"; rf_enable <= '1'; rf_in_sel <= '0';
                wait for clk_periodd_tb;
                -- Place RF1 on ALU_in_2
                rf_opcode <= "01"; reg_sel <= "001"; rf_enable <= '1'; rf_in_sel <= '0';
                wait for clk_periodd_tb;
                -- Make addition of RF0 and RF1
                alu_opcode <= "00001";
                wait for clk_periodd_tb;
                -- Save addition result to RF2
                rf_opcode <= "11"; reg_sel <= "010"; rf_enable <= '1'; rf_in_sel <= '0';
                wait for clk_periodd_tb;
                -- Check RF2
                rf_opcode <= "00"; reg_sel <= "010"; rf_enable <= '1'; rf_in_sel <= '0';
                wait for clk_periodd_tb;
                assert out_1 = "00000000000000000000000000000100" report "Test failed for READ reg_2" severity error;

                -- RF4 = RF0 OR RF2
                -- Place RF0 on ALU_in_1
                rf_opcode <= "00"; reg_sel <= "000"; rf_enable <= '1'; rf_in_sel <= '0';
                wait for clk_periodd_tb;
                -- Place RF2 on ALU_in_2
                rf_opcode <= "01"; reg_sel <= "010"; rf_enable <= '1'; rf_in_sel <= '0';
                wait for clk_periodd_tb;
                -- Make bit-wise OR of RF0 and RF2
                alu_opcode <= "01000";
                wait for clk_periodd_tb;
                -- Save addition result to RF4
                rf_opcode <= "11"; reg_sel <= "100"; rf_enable <= '1'; rf_in_sel <= '0';
                wait for clk_periodd_tb;
                -- Check RF4
                rf_opcode <= "00"; reg_sel <= "100"; rf_enable <= '1'; rf_in_sel <= '0';
                wait for clk_periodd_tb;
                assert out_1 = "00000000000000000000000000000101" report "Test failed for READ reg_4" severity error;

                -- RF3 = NOT RF4
                -- Place RF4 on ALU_in_1 (NOT operation of the ALU uses IN_1 and not IN_2)
                rf_opcode <= "00"; reg_sel <= "100"; rf_enable <= '1'; rf_in_sel <= '0';
                wait for clk_periodd_tb;
                -- Make bit-wise NOT of RF4
                alu_opcode <= "10000";
                wait for clk_periodd_tb;
                -- Save addition result to RF3
                rf_opcode <= "11"; reg_sel <= "011"; rf_enable <= '1'; rf_in_sel <= '0';
                wait for clk_periodd_tb;
                -- Check RF4
                rf_opcode <= "00"; reg_sel <= "011"; rf_enable <= '1'; rf_in_sel <= '0';
                wait for clk_periodd_tb;
                assert out_1 = "11111111111111111111111111111010" report "Test failed for READ reg_3" severity error;
                
                wait;
        end process proc;

end architecture arch;