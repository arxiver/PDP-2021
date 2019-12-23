
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PLA_Entity is     
port(IR: IN std_logic_vector(15 DOWNTO 0);
     F:OUT std_logic_vector(7 DOWNTO 0));
end entity PLA_Entity;


architecture PLA_Arch of PLA_Entity is 
begin
PLAPROCESS: process (IR)
begin
if (IR = "0000000000000001") then F <= "00000000" ; --no operand instruction
elsif (IR = "0000000000000000") then F <= "00001010"; --HLT
elsif (IR(15 downto 12)= "0010") then F <= "00101000"; --Branch instruction #050
--one operand instruction
elsif (IR(15 downto 12)= "0001" and IR(4 downto 3)="01")  then F <= "10010001";
elsif (IR(15 downto 12)= "0001" and IR(4 downto 3)="10")  then F <= "10100001";
elsif (IR(15 downto 12)= "0001" and IR(4 downto 3)="11")  then F <= "10110001";
elsif (IR(15 downto 12)= "0001" and IR(5 downto 3)="000")  then F <= "10000001";
elsif (IR(15 downto 12)= "0001" and IR(5 downto 3)="100")  then F <= "10001001";
--two operand instruction
elsif (IR(10 downto 9)="01")  then F <= "01010001";
elsif (IR(10 downto 9)="10")  then F <= "01100001";
elsif  (IR(10 downto 9)="11")  then F <= "01110001";
elsif (IR(11 downto 9)="000")  then F <= "01000001";
elsif (IR(11 downto 9)="100")  then F <= "01001001";
end if;
end process;

end architecture;

