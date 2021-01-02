library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CPU_Core is PORT (
    clk : IN std_logic
);
end CPU_Core;

architecture Behavioral of CPU_Core is

COMPONENT datapath PORT (
    clk_dp :       IN std_logic;
    RegDst_dp :    IN std_logic;
    Jump_dp :      IN std_logic;
    Branch_dp :    IN std_logic;
    MemRead_dp :   IN std_logic;
    MemToReg_dp :  IN std_logic;
    ALUCtrl_dp :   IN std_logic_vector(3 downto 0);
    MemWrite_dp :  IN std_logic;
    ALUSrc_dp :    IN std_logic;
    RegWrite_dp :  IN std_logic;
    
    OPCODE_dp :    OUT std_logic_vector(5 downto 0);
    FUNCT_dp :     OUT std_logic_vector(5 downto 0));
END COMPONENT;

COMPONENT Control_Unit PORT (
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
    ALUCtrl :   OUT std_logic_vector(3 downto 0));
END COMPONENT;

SIGNAL RegDst_core, Jump_core, Branch_core, MemRead_core, MemToReg_core, RegWrite_core, MemWrite_core, ALUSrc_core : std_logic;
SIGNAL ALUCtrl_core : std_logic_vector(3 downto 0);
SIGNAL OPCODE_core, FUNCT_core : std_logic_vector(5 downto 0);

begin
    DP : datapath PORT MAP (
        clk_dp => clk,   
        RegDst_dp => RegDst_core,   
        Jump_dp => Jump_core,     
        Branch_dp => Branch_core,    
        MemRead_dp => MemRead_core,   
        MemToReg_dp => MemToReg_core, 
        ALUCtrl_dp => ALUCtrl_core,    
        MemWrite_dp => MemWrite_core,
        ALUSrc_dp => ALUSrc_core,   
        RegWrite_dp => RegWrite_core,
        OPCODE_dp => OPCODE_core,
        FUNCT_dp => FUNCT_core);
        
    CTRL : Control_Unit PORT MAP (
        OPCODE => OPCODE_core,
        FUNCT => FUNCT_core,
        RegDst => RegDst_core,   
        Jump => Jump_core,     
        Branch => Branch_core,    
        MemRead => MemRead_core,   
        MemToReg => MemToReg_core, 
        ALUCtrl => ALUCtrl_core,    
        MemWrite => MemWrite_core,
        ALUSrc => ALUSrc_core,   
        RegWrite => RegWrite_core
    );
    

end Behavioral;
