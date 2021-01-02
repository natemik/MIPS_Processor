library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Memory is PORT (
    Address : IN std_logic_vector(255 downto 0);
    WriteData : IN std_logic_vector(31 downto 0);
    MemWrite : IN std_logic;
    MemRead : IN std_logic;
    
    ReadData : OUT std_logic_vecotr(31 downto 0);
);
end Memory;

architecture Behavioral of Memory is

begin


end Behavioral;
