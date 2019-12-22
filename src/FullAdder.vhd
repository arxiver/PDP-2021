LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

entity fullAdder is
port(A,B,Cin: in std_logic ; F,Cout: out std_logic);
end entity fullAdder;

architecture fullAdderArc of fullAdder is
component halfAdder is
port(A1,A2: in std_logic ; Sum,Carry: out std_logic);
end component halfAdder;
signal x1,x2,x3 : std_logic ;

begin
p1: halfAdder port map (A,B,x1,x2);
p2: halfAdder port map (x2,Cin,x3,F);
Cout <= x1 or x3 ;

end architecture fullAdderArc;