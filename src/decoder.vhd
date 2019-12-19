Library IEEE;
USE IEEE.std_logic_1164.all;
entity decoder24 is
port (S : in std_logic_vector (2 downto 0) ; 
EN : in std_logic;
F :out std_logic_vector( 5 downto 0 ));
end entity;

architecture decoderarc of decoder24 is
begin
f <= "000001" when s="000" and EN = '1'
else "000010" when s="001" and EN = '1'
else "000100" when s="010" and EN = '1'
else "001000" when s="011" and EN = '1'
else "010000" when s="100" and EN = '1'
else "100000" when s="101" and EN = '1'
else "000000" ;
end architecture;