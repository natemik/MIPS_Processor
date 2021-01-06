LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY ALU_Controller IS PORT (
    ALUOp_aluctrl : IN std_logic_vector(1 downto 0);
    INSTR : IN std_logic_vector(5 downto 0);
    
    ALUCtrl_aluctrl : OUT std_logic_vector(3 downto 0));
END ALU_Controller;

architecture Behaviour of ALU_Controller is

CONSTANT SW_LW : std_logic_vector(1 downto 0) := "00";
CONSTANT RTYPE : std_logic_vector(1 downto 0) := "10";
CONSTANT BEQ : std_logic_vector(1 downto 0) := "01";

CONSTANT SLL_FUNCT : std_logic_vector(5 downto 0) := "000000"; --Shift Logical Left Funct
CONSTANT SRL_FUNCT : std_logic_vector(5 downto 0) := "000010"; --Shift Logical Right Funct
CONSTANT SRA_FUNCT : std_logic_vector(5 downto 0) := "000011"; --Shift Arithmetic Right Funct
CONSTANT ADD_FUNCT : std_logic_vector(5 downto 0) := "100000"; --Add
CONSTANT SUB_FUNCT : std_logic_vector(5 downto 0) := "100010"; --Subtract
CONSTANT AND_FUNCT : std_logic_vector(5 downto 0) := "100100"; --And
CONSTANT OR_FUNCT : std_logic_vector(5 downto 0) := "100101"; --Or
CONSTANT XOR_FUNCT : std_logic_vector(5 downto 0) := "100110"; --Xor
CONSTANT NOR_FUNCT : std_logic_vector(5 downto 0) := "100111"; --Nor
CONSTANT SLT_FUNCT : std_logic_vector(5 downto 0) := "101010"; --Set Less Than



BEGIN
    ALU_CONTROLLER : PROCESS(ALUOp_aluctrl) BEGIN
        CASE ALUOp_aluctrl IS                                      
            WHEN SW_LW => ALUCtrl_aluctrl <= "0010";
            WHEN BEQ => ALUCtrl_aluctrl <= "0110";
            WHEN RTYPE => CASE INSTR IS
                WHEN ADD_FUNCT => ALUCtrl_aluctrl <= "0010";
                WHEN SUB_FUNCT => ALUCtrl_aluctrl <= "0110";
                WHEN AND_FUNCT => ALUCtrl_aluctrl <= "0000";
                WHEN OR_FUNCT => ALUCtrl_aluctrl <= "0001";
                WHEN NOR_FUNCT => ALUCtrl_aluctrl <= "1100";
                WHEN SLT_FUNCT => ALUCtrl_aluctrl <= "0111";
                WHEN OTHERS => ALUCtrl_aluctrl <= "0000";
                END CASE;
            WHEN OTHERS => ALUCtrl_aluctrl <= "0000";
        END CASE;
    END PROCESS;
end architecture;