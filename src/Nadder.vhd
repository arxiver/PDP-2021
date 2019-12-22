Library ieee;
use ieee.std_logic_1164.all;

ENTITY my_nadder IS
PORT   (a, b : IN std_logic_vector(15 DOWNTO 0) ;
             cin : IN std_logic;
             s : OUT std_logic_vector(15 DOWNTO 0);
             cout : OUT std_logic);
END my_nadder;


ARCHITECTURE a_my_nadder OF my_nadder IS
component fullAdder is
port(A,B,Cin: in std_logic ; F,Cout: out std_logic);
end component fullAdder;

SIGNAL temp : std_logic_vector(15 DOWNTO 0);
BEGIN

f0: fullAdder PORT MAP(a(0),b(0),cin,s(0),temp(0));
loop1: FOR i IN 1 TO 15 GENERATE
        fx: fullAdder PORT MAP(a(i),b(i),temp(i-1),s(i),temp(i));
END GENERATE;
Cout <= temp(15-1);
END a_my_nadder;


