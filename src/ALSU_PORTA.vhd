LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

entity partA is 
port(
BUS_DATA,Y: in std_logic_vector (15 downto 0) ; 
S: in std_logic_vector(1 downto 0);
Cin: in std_logic ;
F : out std_logic_vector(15 downto 0);
Cout: out std_logic );

end entity partA;

architecture partAarc of partA is 

component my_nadder IS
PORT   (a, b : IN std_logic_vector(15 DOWNTO 0) ;
             cin : IN std_logic;
             s : OUT std_logic_vector(15 DOWNTO 0);
             cout : OUT std_logic);
end component my_nadder;

signal ADDop,ADCop,SUBop,SUBCop,INCBUSop,INCYop,DECBUSop,DECYop,Ybar : std_logic_vector(15 downto 0);
signal CINbar : std_logic ;
begin
Ybar <= not Y;
CINbar <= not Cin;
-- ADDop = BUS + Y
ADDsig : my_nadder port map(BUS_DATA,Y,'0',ADDop,Cout);
-- ADCop = BUS + Y + Carry
ADCsig : my_nadder port map(BUS_DATA,Y,Cin,ADCop,Cout);
-- SUB = BUS - Y
SUBsig: my_nadder port map(BUS_DATA,Ybar,'1',SUBop,Cout);
-- SUBC = BUS - Y - C
SUBCsig: my_nadder port map(BUS_DATA,Ybar,CINbar,SUBCop,Cout);
-- INCBUSop = BUS + 1
INCBUSsig : my_nadder port map(BUS_DATA,(others=>'0'),'1',INCBUSop,Cout);
-- INCYop = Y + 1
INCYsig : my_nadder port map(Y,(others=>'0'),'1',INCYop,Cout);

-- DECBUSop = BUS - 1
DECBUSsig: my_nadder port map(BUS_DATA,(others=>'1'),'0',DECBUSop,Cout);

-- DECYop = Y - 1
DECYsig: my_nadder port map(Y,(others=>'1'),'0',DECYop,Cout);


end architecture partAarc;
