LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.all;

ENTITY ALU IS PORT (
    INA : IN std_logic_vector(31 downto 0);
    INB : IN std_logic_vector(31 downto 0);
    ALUCtrl : IN std_logic_vector(3 downto 0);
    
    ALU_Result : OUT std_logic_vector(31 downto 0);
    zero : OUT std_logic);
END ALU;

architecture Behaviour of ALU is

CONSTANT AND_ctrl : std_logic_vector(3 downto 0) := "0000";
CONSTANT OR_ctrl : std_logic_vector(3 downto 0) := "0001";
CONSTANT ADD_ctrl : std_logic_vector(3 downto 0) := "0010";
CONSTANT SUB_ctrl : std_logic_vector(3 downto 0) := "0110";
CONSTANT SLT_ctrl : std_logic_vector(3 downto 0) := "0111";
CONSTANT NOR_ctrl : std_logic_vector(3 downto 0) := "1100";
SIGNAL result : std_logic_vector(31 downto 0);
BEGIN
    ALU : PROCESS(INA, INB, ALUCtrl)
    BEGIN
        CASE ALUCtrl IS
            WHEN AND_ctrl =>
                result <= INA AND INB;
            WHEN OR_ctrl =>
                result <= INA OR INB;
            WHEN ADD_ctrl =>
                result <= INA + INB;
            WHEN SUB_ctrl =>
                result <= INA - INB;
            WHEN SLT_ctrl =>
                IF(INA < INB) THEN
                    result <= x"00000001";
                ELSE
                    result <= x"00000000";
                END IF;
            WHEN NOR_ctrl =>
                result <= INA NOR INB;
        END CASE;
        
        IF result = x"00000000" THEN
            zero <= '1';
        ELSE
            zero <= '0';
        END IF;
        ALU_Result <= result;
            
    END PROCESS;
end architecture;