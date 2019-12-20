library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;


entity RamEnt is
    port(
            Initial,Clk : in std_logic;
            PC : in std_logic_vector(7 downto 0);
            DataOut : out std_logic_vector(15 downto 0)
        );
end entity;


architecture RamArch of RamEnt is
type RamType is array (50 downto 0) of std_logic_vector(15 downto 0);
signal Ram : RamType;
begin
    process(PC,Clk)
    FILE F : text;
    constant FileName : string :="IR.txt";
    VARIABLE L : line;
    variable Count : integer:=0;
    variable Instruction : std_logic_vector(15 downto 0);
    begin
        if Initial = '1' then
            File_Open (F,FileName, read_mode);	
            while ((not EndFile (F))) loop
                readline (F, L);
                read(L, Instruction);
                Ram(Count) <= Instruction;
                Count := Count + 1;
            end loop;
            File_Close (F);           
        else       
            if rising_edge(Clk) then 
                DataOut<=Ram(to_integer(unsigned((PC))));
            end if;
        end if;
    end process;
end RamArch;
