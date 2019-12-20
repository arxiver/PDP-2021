library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--Entity
---------------------------------------------------
entity PALU_PORTC_Entity is     
port(Y,FlagsIn: IN std_logic_vector(15 DOWNTO 0);
     Sel:IN std_logic_vector(2 downto 0);
     Carry,F8:in std_logic;
     F,FlagsOut:OUT std_logic_vector(15 DOWNTO 0));
end entity PALU_PORTC_Entity;
----------------------------------------------------

architecture PALU_PORTC_Arch of PALU_PORTC_Entity is 
begin

process(Y,FlagsIn,Sel,Carry,F8)
begin
FlagsOut(15 DOWNTO 0) <= FlagsIn (15 downto 0);

IF      Sel = "000" then		--shift Right
	F <= '0' & Y(15 downto 1);

	IF F8 = '1' then
		if '0' & Y(15 downto 1) = "0000000000000000" then 
		FlagsOut(2) <= '1';
		else
		FlagsOut(2) <= '0';
		end if;
	end if;

ELSIF   Sel = "001" then        	--shift left
	F <=  Y(14 downto 0) & '0';

	IF F8 = '1' then
		if  Y(14 downto 0) & '0' = "0000000000000000" then 
		FlagsOut(2) <= '1';
		else
		FlagsOut(2) <= '0';
		end if;
	end if;

ELSIF   Sel = "010" then     		--rotate right	  
	F(15)<=Y(0);	 	
	F(14 downto 0) <= Y(15 downto 1);
	
	IF F8 = '1' then
		if  Y(15 downto 0) = "0000000000000000" then 
		FlagsOut(2) <= '1';
		else
		FlagsOut(2) <= '0';
		end if;
	end if;

ELSIF   Sel = "011" then		--rotate right with carry
	F(15)<=Carry;	 	
	F(14 downto 0) <= Y(15 downto 1) ;
	
	IF F8 = '1' then
		if  Y(15 downto 1) & Carry = "0000000000000000" then 
		FlagsOut(2) <= '1';
		else
		FlagsOut(2) <= '0';
		end if;
	end if;

ELSIF   Sel = "100" then		--rotate left
	F(0)<=Y(15);	 	
	F(15 downto 1) <= Y(14 downto 0) ;

	IF F8 = '1' then
		if  Y = "0000000000000000" then 
		FlagsOut(2) <= '1';
		else
		FlagsOut(2) <= '0';
		end if;
	end if;

ELSIF   Sel = "101" then		--rotate left with carry
	F(0)<=Carry;	 	
	F(15 downto 1) <= Y(14 downto 0) ;	
	
	IF F8 = '1' then
		if  Carry & Y(14 downto 0) = "0000000000000000" then 
		FlagsOut(2) <= '1';
		else
		FlagsOut(2) <= '0';
		end if;
	end if;

ELSIF   Sel = "110" then		--arithmetic shift right
	F <= Y(15) & Y(15 downto 1);	
	
	IF F8 = '1' then
		if  Y(15) & Y(15 downto 1) = "0000000000000000" then 
		FlagsOut(2) <= '1';
		else
		FlagsOut(2) <= '0';
		end if;
	end if;
	 
END if;
end process;
end PALU_PORTC_Arch;
