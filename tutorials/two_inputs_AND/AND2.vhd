entity AND2 is
    port(
        x: in bit;
        y: in bit;
        z: out bit
    );
end entity AND2;

architecture Data of AND2 is
    begin
        z <= x and y;
end architecture Data;
