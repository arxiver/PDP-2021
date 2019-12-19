Library IEEE;
USE IEEE.std_logic_1164.all;
entity tristate is
generic ( n: integer:=16);
  Port(
  X : IN std_logic_vector(n-1 downto 0);
  F : OUT std_logic_vector(n-1 downto 0);
  EN : in std_logic);
end entity;

architecture tristatearc of tristate is 
begin

F <= X WHEN EN = '1'
ELSE (OTHERS => 'Z' );

end architecture;