library ieee;
use ieee.std_logic_1164.all;

entity lc_ex02 is
    port(
        CLK: in std_logic;
        RESET: in std_logic;
        ENABLE: in std_logic;
        OUT_1: out std_logic_vector(1 downto 0)
    );
end entity lc_ex02;

architecture arch of lc_ex02 is

    type states is (state_zero, state_one, state_two, state_three);
    signal current_state, next_state: states;

    begin
        -- Output assignement
        with current_state select
            OUT_1 <=
            "00" when state_zero,
            "01" when state_one,
            "10" when state_two,
            "11" when state_three;
            -- "11" when others;

        compute_next_state: process(current_state)
        -- We want to assign the output as soon as the current_state changes.
        -- We want to calculate the next state as soon as the current_state changes.
            begin
                case current_state is
                    when state_zero => next_state <= state_one;
                    when state_one => next_state <= state_two;
                    when state_two => next_state <= state_three;
                    when state_three => next_state <= state_zero;
                end case;
        end process compute_next_state;

        update_current_state: process(CLK, RESET, ENABLE)
            begin
                if (rising_edge(CLK)) then
                    if (RESET = '1') then
                        -- synchronous reset
                        -- reset is more important than counting --> this condition must always be number 1
                        current_state <= state_zero;
                    elsif (ENABLE = '1') then
                        -- synchronous enable
                        -- we do not want the state to be updated if ENABLE=0
                        current_state <= next_state;
                    end if;
                end if;
        end process update_current_state;

end architecture arch;