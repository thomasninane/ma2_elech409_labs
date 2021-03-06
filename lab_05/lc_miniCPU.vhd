library ieee;
use ieee.std_logic_1164.all;

entity lc_miniCPU is
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
end entity lc_miniCPU;

architecture arch of lc_miniCPU is

    signal clk: std_logic;
    signal rf2alu_1, rf2alu_2: std_logic_vector(31 downto 0);
    signal alu_out, rf_in: std_logic_vector(31 downto 0);

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

    begin

        OUT_1 <= rf2alu_1;
        OUT_CLK <= clk;

        alu: lc_ALU port map(
            CLK => clk,
            RESET => RESET,
            OPCODE => ALU_OPCODE,
            IN_1 => rf2alu_1,
            IN_2 => rf2alu_2,
            OUT_1 => alu_out,
            CARRY => open
        );

        rf: lc_registerFile port map(
            CLK => clk,
            RESET => RESET,
            RF_ENABLE => RF_ENABLE,
            SEL => REG_SEL,
            OPCODE => RF_OPCODE,
            IN_1 => rf_in,
            OUT_1 => rf2alu_1,
            OUT_2 => rf2alu_2
        );

        clock: process
            begin
                clk <= '0';
                wait for clk_period/2;
                clk <= '1';
                wait for clk_period/2;
        end process clock;

        with RF_IN_SEL select
        -- Changes the input of RF (when 0, input comes from the ALU output and when 1, input comes from the top level pin)
            rf_in <=
            IN_1 when '1',
            alu_out when others;

end architecture arch;