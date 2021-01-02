library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Sign_Extend is PORT (
    Input : IN std_logic_vector(15 downto 0);
    Output : OUT std_logic_vector(31 downto 0));
end Sign_Extend;

architecture Behavioral of Sign_Extend is

begin
    sign_extend : PROCESS (Input) BEGIN
        IF Input(15) = '0' THEN
            Output <= x"FFFF" & Input;
        ELSE
            Output <= x"0000" & Input;
        END IF;
    END PROCESS;
end Behavioral;
