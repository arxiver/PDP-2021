LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY ram IS
	PORT(
		clk : IN std_logic;
		WRen  : IN std_logic;
		RDen : IN std_logic;
		address : IN  std_logic_vector(7 DOWNTO 0);
		datain  : IN  std_logic_vector(15 DOWNTO 0);
		dataout : OUT std_logic_vector(15 DOWNTO 0));
END ENTITY ram;

ARCHITECTURE syncrama OF ram IS

	TYPE ram_type IS ARRAY(0 TO 63) OF std_logic_vector(15 DOWNTO 0);
	SIGNAL ram : ram_type := (
	  OTHERS => "0000000000000000"
	);

	
	BEGIN
		PROCESS(clk) IS
			BEGIN
				IF rising_edge(clk) THEN  
					IF WRen = '1' and RDen = '0' THEN
						ram(to_integer(unsigned(address))) <= datain;
					END IF;
				END IF;
		END PROCESS;
		dataout <= ram(to_integer(unsigned(address))) WHEN WRen = '0' and RDen = '1' ;
END syncrama;
