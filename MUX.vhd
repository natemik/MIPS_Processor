library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX is PORT (
    IN0 : IN std_logic_vector(31 downto 0);
    IN1 : IN std_logic_vector(31 downto 0);
    MUX_Sel : IN std_logic;
    
    MUX_Out : OUT std_logic_vector(31 downto 0));
end MUX;

architecture Behavioral of MUX is

begin
    MUX : PROCESS(IN0, IN1, MUX_Sel) BEGIN
        IF MUX_Sel = '0' THEN
            MUX_Out <= IN0;
        ELSE
            MUX_Out <= IN1;
        END IF;
    END PROCESS;
end Behavioral;
