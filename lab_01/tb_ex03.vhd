library ieee;
use ieee.std_logic_1164.all;

entity tb_ex03 is
end entity tb_ex03;

architecture arch of tb_ex03 is

    component lc_ex03 is
        port(
            IN_1: in std_logic;
            IN_2: in std_logic;
            IN_3: in std_logic;
            OUT_1: out std_logic;
            OUT_2: out std_logic;
            OUT_3: out std_logic
        );
    end component lc_ex03;

    signal in_1, in_2, in_3, out_1, out_2, out_3: std_logic;

    begin
        uut: lc_ex03 port map(
            IN_1 => in_1,
            IN_2 => in_2,
            IN_3 => in_3,
            OUT_1 => out_1,
            OUT_2 => out_2,
            OUT_3 => out_3
        );

        simulate: process
            begin
                in_1 <= '0'; in_2 <= '0'; in_3 <= '0';
                wait for 10 ns;

                in_1 <= '0'; in_2 <= '0'; in_3 <= '1';
                wait for 10 ns;

                in_1 <= '0'; in_2 <= '1'; in_3 <= '0';
                wait for 10 ns;

                in_1 <= '0'; in_2 <= '1'; in_3 <= '1';
                wait for 10 ns;

                in_1 <= '1'; in_2 <= '0'; in_3 <= '0';
                wait for 10 ns;

                in_1 <= '1'; in_2 <= '0'; in_3 <= '1';
                wait for 10 ns;

                in_1 <= '1'; in_2 <= '1'; in_3 <= '0';
                wait for 10 ns;

                in_1 <= '1'; in_2 <= '1'; in_3 <= '1';
                wait for 10 ns;
        end process simulate;

end architecture arch;