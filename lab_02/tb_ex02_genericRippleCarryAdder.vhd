library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;   -- to unsigned(integer_to_convert, length_of_vector)

-- Before launching the simulation:
-- change the number of bits: N_tb
-- change the filename where the results are written
-- change the simulation time (2^N * 2^N)*10 ns

entity tb_ex02_genericRippleCarryAdder is
    generic(N_tb: integer := 4);
end entity tb_ex02_genericRippleCarryAdder;

architecture arch of tb_ex02_genericRippleCarryAdder is

    component lc_ex02_genericRippleCarryAdder is
        generic(
            N: integer := 4
        );
        port(
            a: in std_logic_vector(N_tb-1 downto 0);
            b: in std_logic_vector(N_tb-1 downto 0);
            s: out std_logic_vector(N_tb-1 downto 0);
            cOut: out std_logic
        );
    end component lc_ex02_genericRippleCarryAdder;

    signal a, b, s: std_logic_vector(N_tb-1 downto 0);
    signal cOut: std_logic;
    
    begin
        uut: lc_ex02_genericRippleCarryAdder
        generic map(
            N => N_tb
        ) -- no ';' until the end of the component !
        port map(
            a => a,
            b => b,
            s => s,
            cOut => cOut
        );

        stim: process

            variable sum: integer := 0;
            variable sum_vec: std_logic_vector(N_tb downto 0) := (others => '0');  -- N_tb downto 0 and not N_tb-1 downto 0 (c.f. assertions)
            variable res_concat: std_logic_vector(N_tb downto 0) := (others => '0');

            begin

                for i in 0 to (2 ** N_tb)-1 loop
                    for j in 0 to (2 ** N_tb)-1 loop

                        a <= std_logic_vector(to_unsigned(i, a'length));
                        b <= std_logic_vector(to_unsigned(j, b'length));
                        wait for 10 ns;

                        sum := i + j;
                        sum_vec := std_logic_vector(to_unsigned(sum, sum_vec'length));

                        res_concat := cOut & s;
                        for k in N_tb downto 0 loop
                            assert sum_vec(k) = res_concat(k) report "Test failed for i, j, k = " & integer'image(i) & integer'image(j) &  integer'image(k) severity error;
                        end loop;

                    end loop;
                end loop;

            wait;

        end process stim;

end architecture arch;

