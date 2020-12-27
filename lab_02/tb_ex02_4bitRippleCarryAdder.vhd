library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;   -- to unsigned(integer_to_convert, length_of_vector)

entity tb_ex02_4bitRippleCarryAdder is
end entity tb_ex02_4bitRippleCarryAdder;

architecture arch of tb_ex02_4bitRippleCarryAdder is

    component lc_ex02_4bitRippleCarryAdder is
        port(
            a: in std_logic_vector(3 downto 0);
            b: in std_logic_vector(3 downto 0);
            s: out std_logic_vector(3 downto 0);
            cOut: out std_logic
        );
    end component lc_ex02_4bitRippleCarryAdder;

    signal a, b, s: std_logic_vector(3 downto 0);
    signal cOut: std_logic;
    
    begin
        uut: lc_ex02_4bitRippleCarryAdder port map(
            a => a,
            b => b,
            s => s,
            cOut => cOut
        );

        stim: process
        
            variable sum: integer := 0;
            variable sum_vec: std_logic_vector(4 downto 0) := (others => '0');  -- 4 downto 0 and not 3 downto 0 (c.f. assertions)

            begin

                for i in 0 to 15 loop
                    for j in 0 to 15 loop

                        a <= std_logic_vector(to_unsigned(i, a'length));
                        b <= std_logic_vector(to_unsigned(j, b'length));
                        wait for 10 ns;

                        sum := i + j;
                        sum_vec := std_logic_vector(to_unsigned(sum, sum_vec'length));
                        assert sum_vec(4) = cOut and sum_vec(3) = s(3) and sum_vec(2) = s(2) and sum_vec(1) = s(1) and sum_vec(0) = s(0)
                        report "Test failed for i = " & integer'image(i) & " and j = " & integer'image(j) severity error;

                    end loop;
                end loop;

            wait;

        end process stim;

end architecture arch;
