
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


ENTITY PALU_Decoder_Entity 
IS
PORT ( IR: IN STD_LOGIC_VECTOR(15 downto 0) ;
F5: IN STD_LOGIC_VECTOR(1 downto 0);
OP : OUT STD_LOGIC_VECTOR(4 downto 0));
END ENTITY PALU_Decoder_Entity;


ARCHITECTURE PALU_Decoder_Arch OF PALU_Decoder_Entity IS

BEGIN

OP <= "00000" WHEN F5 = "00"  			  --ADD operation
	      ELSE "00100"  WHEN F5 = "01"   	  --INC Bus
	      ELSE "00110" WHEN F5 = "10"	  --DEC Bus
	      --1 operand ops
 	      ELSE "00101" WHEN F5 = "11"  AND IR(15 downto 12) = "0001" and IR(11 downto 8) = "0000"  --INC Y
	      ELSE "00111" WHEN F5 = "11"  AND IR(15 downto 12) = "0001" and IR(11 downto 8) = "0001"  --DEC Y
	      ELSE "01000" WHEN F5 = "11"  AND IR(15 downto 12) = "0001" and IR(11 downto 8) = "0010"	--CLR - 
	      ELSE "01011" WHEN F5 = "11"  AND IR(15 downto 12) = "0001" and IR(11 downto 8) = "0011"  --!Y
	      ELSE "10000" WHEN F5 = "11"  AND IR(15 downto 12) = "0001" and IR(11 downto 8) = "0100"  --Shift right Y
	      ELSE "10010" WHEN F5 = "11"  AND IR(15 downto 12) = "0001" and IR(11 downto 8) = "0101"	--Rotate right Y
	      ELSE "10011" WHEN F5 = "11"  AND IR(15 downto 12) = "0001" and IR(11 downto 8) = "0110"  --Rotate right Y with carry
	      ELSE "10110" WHEN F5 = "11"  AND IR(15 downto 12) = "0001" and IR(11 downto 8) = "0111"  -- Arithmitic shift right Y
	      ELSE "10001" WHEN F5 = "11"  AND IR(15 downto 12) = "0001" and IR(11 downto 8) = "1000"  --Shift Left Y
	      ELSE "10100" WHEN F5 = "11"  AND IR(15 downto 12) = "0001" and IR(11 downto 8) = "1001"	--Rotate left Y
	      ELSE "10011" WHEN F5 = "11"  AND IR(15 downto 12) = "0001" and IR(11 downto 8) = "1010"  --Rotate Left Y with carry
	      --2 operand ops
 	      ELSE "01010" WHEN F5 = "11"  AND IR(15 downto 12) = "0100"	--MOV
 	      ELSE "00000" WHEN F5 = "11"  AND IR(15 downto 12) = "0101"	--ADD
 	      ELSE "00001" WHEN F5 = "11"  AND IR(15 downto 12) = "0110"	--ADC
 	      ELSE "00010" WHEN F5 = "11"  AND IR(15 downto 12) = "0111"	--SUB
 	      ELSE "00011" WHEN F5 = "11"  AND IR(15 downto 12) = "1000"	--SBC
 	      ELSE "01101" WHEN F5 = "11"  AND IR(15 downto 12) = "1001"	--AND
 	      ELSE "01110" WHEN F5 = "11"  AND IR(15 downto 12) = "1010"	--OR
 	      ELSE "01111" WHEN F5 = "11"  AND IR(15 downto 12) = "1011"	--XNOR
 	      ELSE "01001" WHEN F5 = "11"  AND IR(15 downto 12) = "1100";	--CMP
END architecture;
