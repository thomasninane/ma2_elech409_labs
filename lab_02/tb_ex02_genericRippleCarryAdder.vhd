library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;   -- to unsigned(integer_to_convert, length_of_vector)

use std.textio.all;
use ieee.std_logic_textio.all;

-- Before launching the simulation:
-- change the number of bits: N_tb
-- change the filename where the results are written
-- change the simulation time (2^N * 2^N)*10 ns

entity tb_ex02_genericRippleCarryAdder is
    generic(N_tb: integer := 4);
end entity tb_ex02_genericRippleCarryAdder;

architecture arch of tb_ex02_genericRippleCarryAdder is

    file output_buf : text;  -- text is keyword

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

        simulate: process

            variable write_col_to_output_buf : line; -- line is keyword

            begin

                file_open(output_buf, "sim_results/tb_ex02_genericRippleCarryAdder_N4.txt",  write_mode);
                write(write_col_to_output_buf, string'("Start of simulation"));
                writeline(output_buf, write_col_to_output_buf);

                for i in 0 to (2 ** N_tb)-1 loop
                    for j in 0 to (2 ** N_tb)-1 loop

                        a <= std_logic_vector(to_unsigned(i, a'length));
                        b <= std_logic_vector(to_unsigned(j, b'length));
                        wait for 10 ns;

                        -- Write to file
                        write(write_col_to_output_buf, string'("a_vec="));
                        write(write_col_to_output_buf, a);
                        write(write_col_to_output_buf, string'(", b_vec="));
                        write(write_col_to_output_buf, b);
                        write(write_col_to_output_buf, string'(", s_vec="));
                        write(write_col_to_output_buf, s);
                        write(write_col_to_output_buf, string'(", cOut="));
                        write(write_col_to_output_buf, cOut);

                        write(write_col_to_output_buf, HT);
                        write(write_col_to_output_buf, string'("a_int="));
                        write(write_col_to_output_buf, i);
                        write(write_col_to_output_buf, string'(", b_int="));
                        write(write_col_to_output_buf, j);
                        write(write_col_to_output_buf, string'(", s_int="));
                        write(write_col_to_output_buf, to_integer(unsigned(s)));
                        write(write_col_to_output_buf, string'(", cOut="));
                        write(write_col_to_output_buf, cOut);

                        writeline(output_buf, write_col_to_output_buf);        

                    end loop;
                end loop;

                -- Close the file containing the results
                write(write_col_to_output_buf, string'("End of simulation"));
                writeline(output_buf, write_col_to_output_buf);
                wait for 100ns;
                file_close(output_buf);

        end process simulate;

end architecture arch;

