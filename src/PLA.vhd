
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PLA_Entity is     
port(IR: IN std_logic_vector(15 DOWNTO 0);
     F:OUT std_logic_vector(7 DOWNTO 0));
end entity PLA_Entity;

architecture PLA_Arch of PLA_Entity is 
begin
F <= "01000000" WHEN IR(15 downto 12) = "0000"               
	    ELSE "00101000"  WHEN IR(15 downto 12)= "0010"   
	    ELSE "10000000"  WHEN IR(15 downto 12)= "0001"   
 	    ELSE "01000000"  ;				      


end PLA_Arch;