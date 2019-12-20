
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PLA_Entity is     
port(IR: IN std_logic_vector(15 DOWNTO 0);
     F:OUT std_logic_vector(7 DOWNTO 0));
end entity PLA_Entity;

F <= "01000000" WHEN IR(15 down to 12) = '0000'                --no operand instruction
	    ELSE "00101000"  WHEN IR(15 down to 12)= '0010 '   --Branch instruction #050
	    ELSE "10000000"  WHEN IR(15 down to 12)= '0001 '   --1 operand instruction #200
 	    ELSE "01000000"  ;				       --2 operand instructin #100

architecture PLA_Arch of PLA_Entity is 

end PLA_Arch