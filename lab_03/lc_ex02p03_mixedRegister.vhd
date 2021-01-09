library ieee;
use ieee.std_logic_1164.all;

entity lc_ex02p03_mixedRegister is
    generic (N: integer := 4);
    port(
        CLK: in std_logic;
        RESET: in std_logic;
        LOAD: in std_logic;
        SERIAL: in std_logic;
        D: in std_logic_vector(N-1 downto 0);
        Q: out std_logic_vector(N-1 downto 0)
    );
end entity lc_ex02p03_mixedRegister;

architecture arch of lc_ex02p03_mixedRegister is

    signal mixed_register: std_logic_vector(N-1 downto 0);

    begin
        Q <= mixed_register;

        proc: process(CLK, RESET, LOAD, SERIAL)
            begin
                if (RESET = '1') then
                    mixed_register <= (others => '0');

                elsif (rising_edge(CLK)) then
                    if (LOAD = '1') then
                        if (SERIAL = '0') then
                            mixed_register <= D;

                        elsif (SERIAL = '1') then
                            mixed_register(0) <= D(0);
                            for i in 1 to N-1 loop
                                mixed_register(i) <= mixed_register(i-1);
                            end loop;
                        end if;
                    end if;
                end if;
        end process proc;

end architecture arch;