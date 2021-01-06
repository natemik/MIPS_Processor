LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.all;

ENTITY Registers IS PORT (
    ReadReg1 : IN std_logic_vector(4 downto 0);
    ReadReg2 : IN std_logic_vector(4 downto 0);
    WriteReg : IN std_logic_vector(4 downto 0);
    WriteData : IN std_logic_vector(31 downto 0);
    RegWrite : IN std_logic;
    
    ReadData1 : OUT std_logic_vector(31 downto 0);
    ReadData2 : OUT std_logic_vector(31 downto 0));
END Registers;

architecture Behaviour of Registers is
    TYPE REG_BLOCK IS ARRAY(0 TO 31) OF std_logic_vector(31 DOWNTO 0);
BEGIN
    REGISTERS : PROCESS(ReadReg1, ReadReg2, WriteReg, WriteData, RegWrite)
    VARIABLE REG : REG_BLOCK;
    BEGIN
        ReadData1 <= REG(conv_integer(ReadReg1));
        ReadData2 <= REG(conv_integer(ReadReg2));
    
        IF RegWrite = '1' THEN
            REG(conv_integer(WriteReg)) := WriteData;
        END IF;
        
    END PROCESS;
end architecture;