LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

entity alsu is
port(Y,B: IN std_logic_vector(15 downto 0);
S:IN std_logic_vector(4 downto 0);
F8 : in std_logic;
Flags :inout std_logic_vector (15 downto 0) := (OTHERS => '0');
F: OUT std_logic_vector(15 downto 0));
end entity alsu;

architecture alsuarch of alsu is


--PORT A COMPONENT
component ALSU_PORTA_ENTITY is 
port(
BUS_DATA,Y: in std_logic_vector (15 downto 0) ; 
S: in std_logic_vector(2 downto 0);
F8 : in std_logic;
Flags:inout std_logic_vector(15 downto 0) := (OTHERS => '0');
F : out std_logic_vector(15 downto 0));

end component ALSU_PORTA_ENTITY;

--PORT B COMPONENT
component ALSU_PORTB_ENTITY is 
port(
Y,B: in std_logic_vector (15 downto 0) ; 
Flags : inout std_logic_vector (15 downto 0) := (OTHERS => '0'); 
S: in std_logic_vector(2 downto 0);
F8 : in std_logic;
F : out std_logic_vector(15 downto 0));
end component ALSU_PORTB_ENTITY;

--PORT C COMPONENT
component ALSU_PORTC_ENTITY is 
port(
Y: in std_logic_vector (15 downto 0) ; 
Flags : inout std_logic_vector (15 downto 0) := (OTHERS => '0'); 
S: in std_logic_vector(2 downto 0);
F8 : in std_logic;
F : out std_logic_vector(15 downto 0));
end component ALSU_PORTC_ENTITY;

signal PAOUT,PBOUT,PCOUT  :std_logic_vector (15 downto 0);
signal  FA, FB, FC  :std_logic_vector (15 downto 0) := (Flags);

Begin
pa:ALSU_PORTA_ENTITY PORT MAP(B,Y,S(2 downto 0) , F8,FA,PAOUT) ;
pb:ALSU_PORTB_ENTITY PORT MAP(Y,B,FB,S(2 downto 0), F8,PBOUT) ;
pc:ALSU_PORTC_ENTITY PORT MAP(Y,FC,S(2 downto 0) , F8,PCOUT) ;


F <= PAOUT  WHEN S(4) ='0' and S(3) = '0'
ELSE PBOUT  WHEN S(4) ='0' and S(3) = '1'
ELSE PCOUT  WHEN S(4) ='1' and S(3) = '0';


Flags <= FA  WHEN S(4) ='0' and S(3) = '0'
ELSE FB  WHEN S(4) ='0' and S(3) = '1'
ELSE FC  WHEN S(4) ='1' and S(3) = '0';

end architecture;
