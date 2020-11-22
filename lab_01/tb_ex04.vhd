library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;   -- to unsigned(integer_to_convert, length_of_vector)

entity tb_ex04 is
end entity tb_ex04;

architecture arch of tb_ex04 is

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
            variable inputs: std_logic_vector(2 downto 0);
            begin
                for i in 0 to 7 loop
                    inputs := std_logic_vector(to_unsigned(i, inputs'length));

                    a <= inputs(0);
                    b <= inputs(1);
                    c <= inputs(2);
                    wait for 10 ns;
                end loop;        
        end process simulate;

end architecture arch;
