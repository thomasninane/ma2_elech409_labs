library ieee;
use ieee.std_logic_1164.all;

entity lc_ex03 is
    port(
        RESET: in std_logic;
        CLK: in std_logic;
        ENABLE: in std_logic;
        UP: in std_logic;
        O: out std_logic_vector(1 downto 0)
    );
end entity lc_ex03;

architecture arch of lc_ex03 is

    -- 00 ->  01 -> 10 -> 11 -> 00

    type states is (state_zero, state_one, state_two, state_three);
    signal current_state: states := state_zero;
    signal next_state: states;

    begin

        compute_next_state: process(current_state, UP)
        -- We want to calculate the next state as soon as the current_state changes.
        -- If the signal UP changes, we want to recalculate the next state!
            begin
                if UP = '1' then
                    case current_state is
                        when state_zero =>
                            O <= "00";
                            next_state <= state_one;
                        when state_one =>
                            O <= "01";
                            next_state <= state_two;
                        when state_two =>
                            O <= "10";
                            next_state <= state_three;
                        when state_three =>
                            O <= "11";
                            next_state <= state_zero;
                    end case;
                elsif UP = '0' then
                    case current_state is
                        when state_zero =>
                            O <= "00";
                            next_state <= state_three;
                        when state_one =>
                            O <= "01";
                            next_state <= state_zero;
                        when state_two =>
                            O <= "10";
                            next_state <= state_one;
                        when state_three =>
                            O <= "11";
                            next_state <= state_two;
                    end case;
                end if;
        end process compute_next_state;


        update_current_state: process(RESET, CLK, ENABLE)
            begin
                if (rising_edge(CLK) and (RESET = '1')) then
                    -- synchronous reset
                    -- reset is more important than counting --> this condition must always be number 1
                    current_state <= state_zero;
                elsif (rising_edge(CLK) and (ENABLE = '1')) then
                    -- synchronous enable
                    -- we do not want the state to be updated if ENABLE=0
                    current_state <= next_state;
                end if;
        end process update_current_state;

end architecture arch;

