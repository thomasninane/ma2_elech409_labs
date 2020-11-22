library ieee;
use ieee.std_logic_1164.all;

entity nand_gate is
    port(
        x: in std_logic;
        y: in std_logic;
        z: out std_logic
    );
end entity nand_gate;

architecture nand_gate_arch of nand_gate is
    begin
        z <= x nand y;
end architecture nand_gate_arch;