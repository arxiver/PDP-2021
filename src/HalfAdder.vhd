LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

entity halfAdder is
port(A1,A2: in std_logic ; Sum,Carry: out std_logic);
end entity halfAdder;

architecture halfAdderArc of halfAdder is
begin
SUM <= A1 and A2 ;
Carry <= A1 xor A2 ;
end architecture halfAdderArc;
