LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.all;

entity Data_Memory is PORT (
    Address : IN std_logic_vector(31 downto 0);
    WriteData : IN std_logic_vector(31 downto 0);
    MemWrite : IN std_logic;
    MemRead : IN std_logic;
    
    ReadData : OUT std_logic_vector(31 downto 0));
end Data_Memory;

architecture Behavioral of Data_Memory is
    TYPE MEM_BLOCK IS ARRAY(0 TO 31) OF std_logic_vector(31 DOWNTO 0);
    signal mem : mem_block := (0 => x"00000000",
                               1 => x"00000001",
                               2 => x"00000002",
                               others => (others => '0'));
begin

    MEM_WRITE : PROCESS (Address, MemWrite, WriteData)
    BEGIN
        IF MemWrite = '1' THEN
            MEM(conv_integer(Address)) <= WriteData;
        END IF;
    END PROCESS;
    
    MEM_READ : PROCESS (Address, MemRead)
    BEGIN
        IF MemRead = '1' THEN
            ReadData <= MEM(conv_integer(Address));
        ELSE
            ReadData <= x"00000000";
        END IF;
    END PROCESS;
    

end Behavioral;
