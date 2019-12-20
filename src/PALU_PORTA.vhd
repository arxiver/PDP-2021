library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PALU_PORTA_Entity is     
port(Y,B,FlagsIn: IN std_logic_vector(15 DOWNTO 0);
     Sel:IN std_logic_vector(2 downto 0);
     Carry,F8:in std_logic;
     F,FlagsOut:OUT std_logic_vector(15 DOWNTO 0));
end entity PALU_PORTA_Entity;


architecture PALU_PORTA_Arch of PALU_PORTA_Entity is 
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

--these signals are used as  outputs and inputs to the adder component used
---------------------------------------------------------------------
SIGNAL OUT_SUM_BY,OUT_SUM_BYC,OUT_SUB_YB,OUT_SUB_YBC,OUT_SUM_B1,OUT_SUM_Y1,OUT_SUB_B1,OUT_SUB_Y1 --outputs
	,XOR_B ,XOR_Carry ,NEG_1,Zeros : std_logic_vector (15 downto 0);  --inputs
SIGNAL OUT_SUM_BY_Carry,OUT_SUM_BYC_Carry,OUT_SUB_YB_Carry,OUT_SUB_YBC_Carry,Temp1  : std_logic; --output
----------------------------------------------------------------------

BEGIN

--Getting Xor Y to prepare for B - Y
gen: for i in 0 to 15 generate
        XOR_B(i) <= B(i) xor '1';
    end generate; 

--Getting XOR Carry to prepare for B - Y - Carry
XOR_Carry <= "111111111111111" & (Carry Xor '1'); 

--used as inputs to adder
NEG_1 <= "1111111111111110";
Zeros <= "0000000000000000";



F0: my_nadder GENERIC MAP (16) PORT MAP(B,Y,'0',OUT_SUM_BY,OUT_SUM_BY_Carry); --B+Y
F1: my_nadder GENERIC MAP (16) PORT MAP(B,Y,Carry,OUT_SUM_BYC,OUT_SUM_BYC_Carry); --B+Y+Carry
F2: my_nadder GENERIC MAP (16) PORT MAP(Y,XOR_B,'1',OUT_SUB_YB,OUT_SUB_YB_Carry); --Y-B         --??? last parameter
F3: my_nadder GENERIC MAP (16) PORT MAP(OUT_SUB_YB,XOR_Carry,'1',OUT_SUB_YBC,OUT_SUB_YBC_Carry); --Y-B-Carry    --??? last parameter

F4: my_nadder GENERIC MAP (16) PORT MAP(B,Zeros,'1',OUT_SUM_B1 ,Temp1); --B+1
F5: my_nadder GENERIC MAP (16) PORT MAP(Y,Zeros,'1',OUT_SUM_Y1 ,Temp1);--Y+1
F6: my_nadder GENERIC MAP (16) PORT MAP(B,NEG_1,'1',OUT_SUB_B1 ,Temp1); --B-1
F7: my_nadder GENERIC MAP (16) PORT MAP(Y,NEG_1,'1',OUT_SUB_Y1 ,Temp1);--Y-1


process(Y,B,FlagsIn,Sel,Carry,F8,OUT_SUM_BY,OUT_SUM_BYC,OUT_SUB_YB,OUT_SUB_YBC,OUT_SUM_B1,OUT_SUM_Y1,OUT_SUB_B1,OUT_SUB_Y1
	,OUT_SUM_BY_Carry,OUT_SUM_BYC_Carry,OUT_SUB_YB_Carry,OUT_SUB_YBC_Carry
	,XOR_B ,XOR_Carry ,NEG_1,Zeros)
begin
FlagsOut(15 DOWNTO 0) <= FlagsIn (15 downto 0);

IF      Sel = "000" then		--F = B + Y
	F <= OUT_SUM_BY;
	IF F8 = '1' then
		IF OUT_SUM_BY(15 downto 0) = "0000000000000000" then --Z Flag
		FlagsOut(2) <= '1';
		ELSE
		FlagsOut(2) <= '0';
		END IF;

		FlagsOut(0) <= OUT_SUM_BY_Carry;
		
	END IF;

ELSIF   Sel = "001" then        	--F = B + Y + C
	F <=  OUT_SUM_BYC;
	IF F8 = '1' then
		IF OUT_SUM_BYC(15 downto 0) = "0000000000000000" then --Z Flag
		FlagsOut(2) <= '1';
		ELSE
		FlagsOut(2) <= '0';
		END IF;
	FlagsOut(0) <= OUT_SUM_BYC_Carry;--C Flag
	END IF;

ELSIF   Sel = "010" then     		--F = B - Y  
	F <= OUT_SUB_YB;
	IF F8 = '1' then
		IF OUT_SUB_YB(15 downto 0) = "0000000000000000" then --Z Flag
		FlagsOut(2) <= '1';
		ELSE
		FlagsOut(2) <= '0';
		END IF;
	FlagsOut(0) <= NOT OUT_SUB_YB_Carry;--C Flag
	END IF;

ELSIF   Sel = "011" then		--F = B - Y - C
	F <= OUT_SUB_YBC;
	IF F8 = '1' then
		IF OUT_SUB_YBC(15 downto 0) = "0000000000000000" then --Z Flag
		FlagsOut(2) <= '1';
		ELSE
		FlagsOut(2) <= '0';
		END IF;
	
	FlagsOut(0) <= NOT OUT_SUB_YBC_Carry;--C Flag
	END IF;

ELSIF   Sel = "100" then		--F = B + 1
	F <= OUT_SUM_B1;
	IF F8 = '1' then
		IF OUT_SUM_B1(15 downto 0) = "0000000000000000" then --Z Flag
		FlagsOut(2) <= '1';
		ELSE
		FlagsOut(2) <= '0';
		END IF;
	END IF;

ELSIF   Sel = "101" then		--F = Y + 1
	F <= OUT_SUM_Y1 ;
	IF F8 = '1' then
		IF OUT_SUM_Y1(15 downto 0) = "0000000000000000" then --Z Flag
		FlagsOut(2) <= '1';
		ELSE
		FlagsOut(2) <= '0';
		END IF;
	END IF;

ELSIF   Sel = "110" then		--F = B - 1 
	F <= OUT_SUB_B1;
	IF F8 = '1' then
		IF OUT_SUB_B1(15 downto 0) = "0000000000000000" then --Z Flag
		FlagsOut(2) <= '1';
		ELSE
		FlagsOut(2) <= '0';
		END IF;
	END IF;

ELSIF   Sel = "111" then		--F = Y - 1
	F <= OUT_SUB_Y1 ;
	 IF F8 = '1' then
		IF OUT_SUB_Y1(15 downto 0) = "0000000000000000" then --Z Flag
		FlagsOut(2) <= '1';
		ELSE
		FlagsOut(2) <= '0';
		END IF;
	END IF;

END if;
end process;


  end PALU_PORTA_Arch;
