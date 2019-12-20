
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


ENTITY mux_entity
IS
PORT ( s0,s1: IN STD_LOGIC ;
IN0,IN1,IN2,IN3 : IN std_logic_vector(15 downto 0);
F : OUT std_logic_vector(15 downto 0));
END ENTITY mux_entity;


ARCHITECTURE mux_arch OF mux_entity IS

BEGIN

f <= IN0 when s1 = '0' and s0 = '0'
ELSE IN1  WHEN s1 = '0' and s0 = '1'
ELSE IN2  WHEN s1 = '1' and s0 = '0'
ELSE IN3  WHEN s1 = '1' and s0 = '1';

END mux_arch;
