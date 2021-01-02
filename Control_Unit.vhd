library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control_Unit is PORT (
    OPCODE : IN std_logic_vector(5 downto 0);
    FUNCT : IN std_logic_vector(5 downto 0);
    
    RegDst :    OUT std_logic;
    Jump :      OUT std_logic;
    Branch :    OUT std_logic;
    MemRead :   OUT std_logic;
    MemtoReg :  OUT std_logic;
    MemWrite :  OUT std_logic;
    ALUSrc :    OUT std_logic;
    RegWrite :  OUT std_logic;
    ALUCtrl :        OUT std_logic_vector(3 downto 0));
end Control_Unit;

architecture Behavioral of Control_Unit is
COMPONENT controller PORT (
    OPCODE_ctrl : IN std_logic_vector(31 downto 26);
    
    RegDst_ctrl :    OUT std_logic;
    Jump_ctrl :           OUT std_logic;
    Branch_ctrl :    OUT std_logic;
    MemRead_ctrl :   OUT std_logic;
    MemtoReg_ctrl :  OUT std_logic;
    ALUOp_ctrl :     OUT std_logic_vector(1 downto 0);
    MemWrite_ctrl :  OUT std_logic;
    ALUSrc_ctrl :    OUT std_logic;
    RegWrite_ctrl :  OUT std_logic);
END COMPONENT;

COMPONENT ALU_Controller PORT (
    ALUOp_aluctrl : IN std_logic_vector(1 downto 0);
    INSTR : IN std_logic_vector(5 downto 0);
    
    ALUCtrl_aluctrl : OUT std_logic_vector(3 downto 0));
END COMPONENT;

SIGNAL ALUOp_cu : std_logic_vector(1 downto 0);

begin
    CONTROL : controller PORT MAP (
        OPCODE_ctrl => OPCODE,
        RegDst_ctrl => RegDst,
        Jump_ctrl => Jump,
        Branch_ctrl => Branch,
        MemRead_ctrl => MemRead,
        MemtoReg_ctrl => MemtoReg,
        ALUOp_ctrl => ALUOp_cu,
        MemWrite_ctrl => MemWrite,
        ALUSrc_ctrl => ALUSrc,
        RegWrite_ctrl => RegWrite
    );
    
    ALU_CONTROL : ALU_CONTROLLER PORT MAP (
        ALUOp_aluctrl => ALUOp_cu,
        INSTR => Funct,
        ALUCtrl_aluctrl => ALUCtrl
    );


end Behavioral;
