# Simulate the testbench
vsim work.tb_ex01_halfAdder

# Configure the wave window
add wave a b s cOut

# Run simulation
run 80ns

# Control the wave view
wave zoom full


library ieee;
use ieee.std_logic_1164.all;

entity lc_ex01_halfAdder is
    port(
        a: in std_logic;
        b: in std_logic;
        s: out std_logic;
        cOut: out std_logic
    );
end entity lc_ex01_halfAdder;

architecture arch of lc_ex01_halfAdder is
    begin
        s <= a xor b;       -- sum bit
        cOut <= a and b;    -- carry bit
end architecture arch;


library ieee;
use ieee.std_logic_1164.all;

entity lc_ex01_fullAdder is
    port(
        a: in std_logic;
        b: in std_logic;
        cIn: in std_logic;
        s: out std_logic;
        cOut: out std_logic
    );
end entity lc_ex01_fullAdder;

architecture arch of lc_ex01_fullAdder is
    begin
        s <= a xor b xor cIn;                       -- sum bit
        cOut <= (a and b) or ((a xor b) and cIn);   -- carry bit
end architecture arch;
