library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;   -- to unsigned(integer_to_convert, length_of_vector)

entity tb_ex04 is
end entity tb_ex04;

architecture arch of tb_ex04 is

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

        stim: process
            variable inputs: std_logic_vector(2 downto 0);
            variable assert_out_1, assert_out_2, assert_out_3: std_logic :='0';
            begin
                for i in 0 to 7 loop
                    inputs := std_logic_vector(to_unsigned(i, inputs'length));

                    in_1 <= inputs(0);
                    in_2 <= inputs(1);
                    in_3 <= inputs(2);
                    wait for 10 ns;

                    assert_out_1 := in_1 and in_2;
                    assert_out_2 := in_2 and in_3;
                    assert_out_3 := in_1 or in_2 or in_3;
                    assert out_1 = assert_out_1 and out_2 = assert_out_2 and out_3 = assert_out_3
                    report "Test failed for input combination " & std_logic'image(in_1) & std_logic'image(in_2) & std_logic'image(in_3) severity error;

                end loop;
                
                wait;
        end process stim;

end architecture arch;