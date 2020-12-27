library ieee;
use ieee.std_logic_1164.all;

entity lc_ex01 is
    port(
        CLK: in std_logic;
        RESET: in std_logic;
        SWITCH: in std_logic;
        OUT_1: out std_logic
    );
end entity lc_ex01;

architecture arch of lc_ex01 is

    type states is (inactive, active);
    signal current_state: states := inactive;
    signal next_state: states;

    begin

        compute_next_state: process(SWITCH, current_state)
            begin
                -- Assign output for current_case
                case current_state is
                    when inactive => OUT_1 <= '0';
                    when active => OUT_1 <= '1';
                end case;

                -- Assign next_state (note that it is immediately computed after the current_state is updated!)
                if (SWITCH = '1') then
                    case current_state is
                        when inactive => next_state <= active;
                        when active => next_state <= inactive;
                    end case;
                end if;
        end process compute_next_state;


        update_current_state: process(RESET, CLK)
            begin
                if (RESET = '1') then
                    -- asynchronous reset
                    current_state <= inactive;
                elsif rising_edge(CLK) then
                    current_state <= next_state;
                end if;
        end process update_current_state;

end architecture arch;