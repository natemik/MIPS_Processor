LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.all;

entity Instruction_Memory is PORT (
    PC : IN std_logic_vector(31 downto 0);
    
    INSTR : OUT std_logic_vector(31 downto 0));
end Instruction_Memory;

architecture Behavioral of Instruction_Memory is
    TYPE MEM_BLOCK IS ARRAY(0 TO 31) OF std_logic_vector(31 DOWNTO 0);
    CONSTANT IMEM_DATA : MEM_BLOCK := (
    "10001100000000000000000000000000",
    others => (others => '0'));
begin

    INSTR <= IMEM_DATA(conv_integer(PC(4 downto 0)));
    

end Behavioral;
