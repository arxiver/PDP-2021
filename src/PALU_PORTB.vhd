library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PALU_PORTB_Entity is     
port(Y,B,FlagsIn: IN std_logic_vector(15 DOWNTO 0);
     Sel:IN std_logic_vector(2 downto 0);
     Carry,F8:in std_logic;
     F,FlagsOut:OUT std_logic_vector(15 DOWNTO 0));
end entity PALU_PORTB_Entity;


architecture PALU_PORTB_Arch of PALU_PORTB_Entity is 

   --adder component
--------------------------------------
COMPONENT my_nadder IS

GENERIC (n : integer := 16);

PORT(a,b : IN std_logic_vector(n-1 DOWNTO 0);
cin : IN std_logic;
s : OUT std_logic_vector(n-1
DOWNTO 0);
cout : OUT std_logic);
END COMPONENT;
---------------------------------------

SIGNAL SUB_YB,XOR_B  : std_logic_vector (15 downto 0);
SIGNAL Adder_Carry  : std_logic; --output

begin
--Getting Xor B to prepare for Y - B
gen: for i in 0 to 15 generate
        XOR_B(i) <= B(i) xor '1';
    end generate; 

F1: my_nadder GENERIC MAP (16) PORT MAP(Y,XOR_B,'1',SUB_YB,Adder_Carry); --Y-B

process(Y,B,FlagsIn,Sel,Carry,F8,SUB_YB,Adder_Carry)
begin
FlagsOut(15 DOWNTO 0) <= FlagsIn (15 downto 0);

IF      Sel = "000" then		--F = 0
	F <= "0000000000000000";

	IF F8 = '1' then
	FlagsOut(0) <= '0';
	FlagsOut(2) <= '1';
	end if;

ELSIF   Sel = "001" then        	--F = Y(CMP)
	F <=  Y;

	IF F8 = '1' then
		IF SUB_YB(15 downto 0) = "0000000000000000" then --Z Flag
		FlagsOut(2) <= '1';
		ELSE
		FlagsOut(2) <= '0';
		END IF;
	FlagsOut(0) <= NOT Adder_Carry;--C Flag
	END IF;
	

ELSIF   Sel = "010" then     		--F = BUS (MOV) 
	F <= B;

ELSIF   Sel = "011" then		--F = !Y
	F <= NOT Y;

	IF F8 = '1' then
	FlagsOut(0) <= '1';
		if NOT Y = "0000000000000000" then 
		FlagsOut(2) <= '1';
		ELSE
		FlagsOut(2) <= '0';
		end if;
	end if;
	
	

ELSIF   Sel = "100" then		--F = !BUS
	F <= NOT B;

	IF F8 = '1' then
	FlagsOut(0) <= '1';
		if NOT B = "0000000000000000" then 
		FlagsOut(2) <= '1';
		ELSE
		FlagsOut(2) <= '0';
		end if;
	end if;

ELSIF   Sel = "101" then		--F = BUS  AND Y
	F <= B AND Y;
	IF F8 = '1' then
		if (B AND Y) = "0000000000000000" then 
		FlagsOut(2) <= '1';
		ELSE
		FlagsOut(2) <= '0';
		end if;
	end if;

ELSIF   Sel = "110" then		--F = BUS  OR Y
	F <= B OR Y;
	IF F8 = '1' then
		if (B OR Y) = "0000000000000000" then 
		FlagsOut(2) <= '1';
		ELSE
		FlagsOut(2) <= '0';
		end if;
	end if;

ELSIF   Sel = "111" then		--F = BUS  XNOR Y
	F <= B XNOR Y;	
	IF F8 = '1' then
		if (B XNOR Y) = "0000000000000000" then 
		FlagsOut(2) <= '1';
		ELSE
		FlagsOut(2) <= '0';
		end if;
	end if;
	 
END if;
end process;
   end PALU_PORTB_Arch;
