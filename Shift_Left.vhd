library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Shift_Left is PORT (
        Input : IN std_logic_vector(31 downto 0);
        
        Output : OUT std_logic_vector(31 downto 0));
end Shift_Left;

architecture Behavioral of Shift_Left is

begin
    
    Output <= Input(29 downto 0) & "00";

end Behavioral;
