LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

entity bit_oring is 
port (
oring_bits :in std_logic_vector(2 downto 0);
address_mod:in std_logic_vector(7 downto 0);
IR: in std_logic_vector(15 downto 0);
PLA_input: in std_logic_vector(7 downto 0);
m_micro_AR : out std_logic_vector(7 downto 0)
);
end entity;


architecture arch_bit_oring of bit_oring is
begin 

m_micro_AR <= address_mod when oring_bits ="000" --if no it oring is required put high impendence 
else PLA_input when oring_bits="101"  --if PLA needed 
else address_mod(7 downto 1) & (address_mod(0) or IR(5)) when oring_bits="011" --indirect distenation oring required
else address_mod(7 downto 1) & (address_mod(0) or IR(8)) when oring_bits="010" --indirect source oring required
--this for the distenation trasaction (maybe not the best way to do it but who gives a !@#@#)
else "10010001" when oring_bits="001" and IR(4 downto 3)="01" --auto increment 
else "10100001" when oring_bits="001" and IR(4 downto 3)="10" --autodecrement
else "10110001" when oring_bits="001" and IR(4 downto 3)="11" --indexed
else "10000001" when oring_bits="001" and IR(5 downto 3)="000" --register direct
else "10001001" when oring_bits="001" and IR(5 downto 3)="100" --registed indeirect
--end of this !@#123
else address_mod(7 downto 1) & (address_mod(0) or ((IR(5) nand IR(4))  nand IR(3))) when oring_bits="100";


end architecture;

