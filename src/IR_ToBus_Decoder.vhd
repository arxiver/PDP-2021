
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


ENTITY IR_ToBus_Decoder_Entity 
IS
PORT ( IR,Flags: IN STD_LOGIC_VECTOR(15 downto 0);
Offset : OUT STD_LOGIC_VECTOR(15 downto 0));
END ENTITY IR_ToBus_Decoder_Entity;


ARCHITECTURE IR_ToBus_Decoder_Arch OF IR_ToBus_Decoder_Entity IS

BEGIN

Offset <= "000000000" & IR(6 downto 0) WHEN (IR(11 downto 9) = "000")  	--BR
					OR (IR(11 downto 9) = "001" and  Flags(2) = '1') --BEQ
					OR (IR(11 downto 9) = "010" and  Flags(2) = '0') --BNE
					OR (IR(11 downto 9) = "011" and  Flags(0) = '0') --BLO
					OR (IR(11 downto 9) = "100" and  (Flags(0) = '0' OR Flags(2) = '1'))   --BLS
					OR (IR(11 downto 9) = "101" and  Flags(0) = '1')   --BHI
					OR (IR(11 downto 9) = "110" and  (Flags(0) = '1' OR Flags(2) = '1'))   --BHS
	     	                        ELSE "0000000000000000"; 	 
	      
END architecture;
