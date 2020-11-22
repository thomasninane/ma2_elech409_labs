library ieee;
use ieee.std_logic_1164.all;

entity tb_ex03 is
end entity tb_ex03;

architecture arch of tb_ex03 is

    component lc_ex03 is
        port(
            in1: in std_logic;
            in2: in std_logic;
            in3: in std_logic;
            out1: out std_logic;
            out2: out std_logic;
            out3: out std_logic
        );
    end component lc_ex03;

    signal a, b, c, o1, o2, o3: std_logic;

    begin
        uut: lc_ex03 port map(
            in1 => a,
            in2 => b,
            in3 => c,
            out1 => o1,
            out2 => o2,
            out3 => o3
        );

        simulate: process
            begin
                a <= '0'; b <= '0'; c <= '0';
                wait for 10 ns;

                a <= '0'; b <= '0'; c <= '1';
                wait for 10 ns;

                a <= '0'; b <= '1'; c <= '0';
                wait for 10 ns;

                a <= '0'; b <= '1'; c <= '1';
                wait for 10 ns;

                a <= '1'; b <= '0'; c <= '0';
                wait for 10 ns;

                a <= '1'; b <= '0'; c <= '1';
                wait for 10 ns;

                a <= '1'; b <= '1'; c <= '0';
                wait for 10 ns;

                a <= '1'; b <= '1'; c <= '1';
                wait for 10 ns;
        end process simulate;

end architecture arch;