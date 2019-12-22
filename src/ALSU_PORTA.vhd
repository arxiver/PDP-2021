LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

entity ALSU_PORTA_ENTITY is 
port(
BUS_DATA,Y: in std_logic_vector (15 downto 0) ; 
S: in std_logic_vector(2 downto 0);
F8 : in std_logic;
Flags:inout std_logic_vector(15 downto 0) := (OTHERS => '0');
F : out std_logic_vector(15 downto 0));

end entity ALSU_PORTA_ENTITY;

architecture ALSU_PORTA_ARCH of ALSU_PORTA_ENTITY is 

component my_nadder IS
PORT   (a, b : IN std_logic_vector(15 DOWNTO 0) ;
             cin : IN std_logic;
             s : OUT std_logic_vector(15 DOWNTO 0);
             cout : OUT std_logic);
end component my_nadder;

signal ADDop,ADCop,SUBop,SUBCop,INCBUSop,INCYop,DECBUSop,DECYop,Ybar,Bbar,Fbuffer : std_logic_vector(15 downto 0);
signal CoutADD,CoutADC,CoutSUB,CoutSUBC,CoutINCY,CoutINCB,CoutDECY,CoutDECB : std_logic ;
signal CINbar,CIN : std_logic ;
begin
----------------------------------------------------------------------------------
CIN <= Flags(0);
Ybar <= not Y;
Bbar <= not BUS_DATA;
CINbar <= not Cin;
-- ADDop = BUS + Y
ADDsig : my_nadder port map(BUS_DATA,Y,'0',ADDop,CoutADD);
-- ADCop = BUS + Y + Carry
ADCsig : my_nadder port map(BUS_DATA,Y,Cin,ADCop,CoutADC);
-- SUB = BUS - Y
SUBsig: my_nadder port map(Y,Bbar,'1',SUBop,CoutSUB);
-- SUBC = BUS - Y - C
SUBCsig: my_nadder port map(Y,Bbar,CINbar,SUBCop,CoutSUBC);
-- INCBUSop = BUS + 1
INCBUSsig : my_nadder port map(BUS_DATA,(others=>'0'),'1',INCBUSop,CoutINCB);
-- INCYop = Y + 1
INCYsig : my_nadder port map(Y,(others=>'0'),'1',INCYop,CoutINCY);

-- DECBUSop = BUS - 1
DECBUSsig: my_nadder port map(BUS_DATA,(others=>'1'),'0',DECBUSop,CoutDECB);

-- DECYop = Y - 1
DECYsig: my_nadder port map(Y,(others=>'1'),'0',DECYop,CoutDECY);
-------------------------------------------------------------------------------------

Fbuffer <= (ADDop)   When S = "000"  -- ADDop
    else ( ADCop)    when  S =  "001"   --ADCop
    else (SUBop) when  S =  "010"   -- SUB
    else (SUBCop)   when  S =  "011"   --SUBC
    else (INCBUSop) when  S =  "100"   -- INCBUSop
    else (INCYop)   when  S =  "101"   --INCYop
    else (DECBUSop)  when  S =  "110"   --DECBUSop
    else (DECYop)  when  S =  "111" ;  --DECYop
	
     

   
    Flags(0) <= CoutADD when  F8 = '1' and S="000" --ADD
    else CoutADC when  F8 = '1' and S = "001" --ADC 
    else CoutSUB when F8 = '1' and S = "010"    --SUB
    else CoutSUBC when   F8 = '1' and S = "011"  --SUBC
    else '0' when F8 = '1';	  

    F <= Fbuffer;

    Flags(2) <= '1' When F8 = '1' and Fbuffer="0000000000000000"
    else '0' when F8='1' ; -- Effect in IR-OPERATION ONLY


end architecture ALSU_PORTA_ARCH;