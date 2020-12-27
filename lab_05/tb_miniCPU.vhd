library ieee;
use ieee.std_logic_1164.all;

entity tb_miniCPU is
end entity tb_miniCPU;

architecture arch of tb_miniCPU is

    component lc_miniCPU is
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
        uut: lc_miniCPU port map(
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
                reset <= '1'; rf_opcode <= "00"; reg_sel <= "000"; rf_enable <= '1';
                wait for 10ns;
                assert out_1 = "00000000000000000000000000000000" report "Test failed for reset" severity error;
                
                wait;
        end process proc;

end architecture arch;