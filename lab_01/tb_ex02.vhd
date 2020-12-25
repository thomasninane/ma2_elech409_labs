library ieee;
use ieee.std_logic_1164.all;

entity tb_ex02 is
end entity tb_ex02;

architecture arch of tb_ex02 is
    
    component lc_ex02 is
        port(
            IN_1: in std_logic;
            IN_2: in std_logic;
            IN_3: in std_logic;
            OUT_1: out std_logic
        );
    end component lc_ex02;

    signal in_1, in_2, in_3, out_1: std_logic;

    begin
        uut: lc_ex02 port map(
            IN_1 => in_1,
            IN_2 => in_2,
            IN_3 => in_3,
            OUT_1 => out_1
        );

        stim: process
            begin
                in_1 <= '0'; in_2 <= '0'; in_3 <= '0';
                wait for 10 ns;
                assert out_1 = '0' report "Test failed for input combination 000" severity error;

                in_1 <= '1'; in_2 <= '1'; in_3 <= '1';
                wait for 10 ns;
                assert out_1 = '1' report "Test failed for input combination 111" severity error;

                in_1 <= '0'; in_2 <= '1'; in_3 <= '0';
                wait for 10 ns;
                assert out_1 = '0' report "Test failed for input combination 010" severity error;

                wait;
        end process stim;

end architecture arch;