library ieee;
use ieee.std_logic_1164.all;

entity tb_ex02p01_shiftRegister is
    generic(N_tb: integer := 4);
end entity tb_ex02p01_shiftRegister;

architecture arch of tb_ex02p01_shiftRegister is

    component lc_ex02p01_shiftRegister is
        generic(
            N: integer := 4
        );
        port(
            D: in std_logic;
            EN: in std_logic;
            Q: out std_logic
        );
    end component lc_ex02p01_shiftRegister;

    signal d: std_logic;
    signal En: std_logic;
    signal q: std_logic;

    begin
        uut: lc_ex02p01_shiftRegister
        generic map(
            N => N_tb
        ) -- no ';' until the end of the component !
        port map(
            D => d,
            EN => En,
            Q => q
        );

        simulate: process
            begin

                -- Fill the bit number 1 (xxx1)
                d <= '1'; En <= '1';
                wait for 5 ns;
                d <= '0'; En <= '0';    -- En must go from 1 to 0 to 1 to reactivate the process of the logical component.
                wait for 5 ns;

                -- Fill the bit number 2 (xx10)
                d <= '0'; En <= '1';
                wait for 5 ns;
                d <= '0'; En <= '0';
                wait for 5 ns;

                -- Fill the bit number 3 (x101)
                d <= '1'; En <= '1';
                wait for 5 ns;
                d <= '0'; En <= '0';
                wait for 5 ns;

                -- Fill the bit number 4 (1010)
                d <= '0'; En <= '1';
                wait for 5 ns;
                d <= '0'; En <= '0';
                wait for 5 ns;

                -- What we have in the register so far: "1010". The register is full.

                -- Check the first output (1-0101)
                d <= '1'; En <= '1';
                wait for 5 ns;
                assert((q = '1')) report "Test failed for input number 1" severity error;
                d <= '0'; En <= '0';
                wait for 5 ns;

                -- Check the second output (0-1010)
                d <= '0'; En <= '1';
                wait for 5 ns;
                assert((q = '0')) report "Test failed for input number 2" severity error;
                d <= '0'; En <= '0';
                wait for 5 ns;

                -- Check the third output (1-0101)
                d <= '1'; En <= '1';
                wait for 5 ns;
                assert((q = '1')) report "Test failed for input number 3" severity error;
                d <= '0'; En <= '0';
                wait for 5 ns;

                -- Check the fourth output (0-1010)
                d <= '0'; En <= '1';
                wait for 5 ns;
                assert((q = '0')) report "Test failed for input number 4" severity error;
                d <= '0'; En <= '0';
                wait for 5 ns;


        end process simulate;

end architecture arch;