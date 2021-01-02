LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.all;

entity datapath is PORT (
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
end datapath;

architecture Behavioral of datapath is

COMPONENT MUX port (
    IN0 : IN std_logic_vector(31 downto 0);
    IN1 : IN std_logic_vector(31 downto 0);
    MUX_Sel : IN std_logic;
    
    MUX_Out : OUT std_logic_vector(31 downto 0));
END COMPONENT;

COMPONENT ALU port (
    INA : IN std_logic_vector(31 downto 0);
    INB : IN std_logic_vector(31 downto 0);
    ALUCtrl : IN std_logic_vector(3 downto 0);
    
    ALU_Result : OUT std_logic_vector(31 downto 0);
    zero : OUT std_logic);
END COMPONENT;

COMPONENT REGISTERS port (
    ReadReg1 : IN std_logic_vector(4 downto 1);
    ReadReg2 : IN std_logic_vector(4 downto 1);
    WriteReg : IN std_logic_vector(4 downto 1);
    WriteData : IN std_logic_vector(31 downto 0);
    RegWrite : IN std_logic;
    
    ReadData1 : OUT std_logic_vector(31 downto 0);
    ReadData2 : OUT std_logic_vector(31 downto 0));
END COMPONENT;

COMPONENT DATA_MEMORY port (
    Address : IN std_logic_vector(255 downto 0);
    WriteData : IN std_logic_vector(31 downto 0);
    MemWrite : IN std_logic;
    MemRead : IN std_logic;
    
    ReadData : OUT std_logic_vector(31 downto 0));
END COMPONENT;

COMPONENT Sign_Extend PORT (
    Input : IN std_logic_vector(15 downto 0);
    
    Output : OUT std_logic_vector(31 downto 0));
END COMPONENT;

COMPONENT Instruction_Memory PORT (
    PC : IN std_logic_vector(31 downto 0);
    
    INSTR : OUT std_logic_vector(31 downto 0));
END COMPONENT;

SIGNAL PC_dp : std_logic_vector(31 downto 0);
SIGNAL PC_PLUS4_dp : std_logic_vector(31 downto 0);
SIGNAL PC_new_dp : std_logic_vector(31 downto 0);
SIGNAL PCMux : std_logic_vector(31 downto 0);
SIGNAL INSTR_dp : std_logic_vector(31 downto 0);
SIGNAL INSTR_SL2_dp : std_logic_vector(31 downto 0); 
SIGNAL Instr25To21_dp : std_logic_vector(4 downto 0) := INSTR_dp(25 downto 21);
SIGNAL Instr20To16_dp : std_logic_vector(4 downto 0) := INSTR_dp(20 downto 16);
SIGNAL Instr15To11_dp : std_logic_vector(4 downto 0) := INSTR_dp(15 downto 11);
SIGNAL Instr15To0_dp : std_logic_vector(15 downto 0) := INSTR_dp(15 downto 0);
SIGNAL Instr15To0_SE_dp : std_logic_vector(31 downto 0);
SIGNAL Instr15To0_SE_SL2_dp : std_logic_vector(31 downto 0);
SIGNAL Instr25To0_dp : std_logic_vector(25 downto 0) := INSTR_dp(25 downto 0);
SIGNAL RegMux_dp : std_logic_vector(31 downto 0);
SIGNAL RegToALU : std_logic_vector(31 downto 0);
SIGNAL RegToALUMUX : std_logic_vector(31 downto 0);
SIGNAL ALUMUXOutput_dp : std_logic_vector(31 downto 0);
SIGNAL ALU_Result_dp : std_logic_vector(31 downto 0);
SIGNAL zero_dp : std_logic;
SIGNAL ReadDataMem_dp : std_logic_vector(31 downto 0);
SIGNAL WriteDataReg_dp : std_logic_vector(31 downto 0);
SIGNAL BranchAddr_dp : std_logic_vector(31 downto 0);
SIGNAL JumpAddr_dp : std_logic_vector(31 downto 0);
SIGNAL BranchCond : std_logic;

begin
    ProgCount : PROCESS(clk_dp) BEGIN
        IF rising_edge(clk_dp) THEN
            PC_dp <= PC_new_dp;
        END IF;
    END PROCESS;

    PC_PLUS4_dp <= PC_dp + 4;
    JumpAddr_dp <= PC_PLUS4_dp(31 downto 28)& (Instr25To0_dp & "00");
    Instr15To0_SE_SL2_dp <= Instr15To0_SE_dp(29 downto 0) & "00";
    BranchAddr_dp <= PC_PLUS4_dp + Instr15To0_SE_SL2_dp;
    BranchCond <= Branch_dp AND zero_dp;
    
    PCMUX1 : MUX PORT MAP (
        IN0 => PC_PLUS4_dp(31 downto 0),
        IN1 => BranchAddr_dp,
        Mux_Sel => BranchCond,
        Mux_Out => PCMux);
    
    PCMUX2 : MUX PORT MAP (
        IN0 => PCMux,
        IN1 => JumpAddr_dp,
        Mux_Sel => Jump_dp,
        Mux_Out => PC_new_dp);
    
    IMEM : Instruction_Memory PORT MAP (
        PC => PC_dp,
        INSTR => INSTR_dp);
    
    REG_MUX : MUX PORT MAP (
        IN0 => Instr20To16_dp,
        IN1 => Instr15To11_dp,
        MUX_Sel => RegDst_dp,
        MUX_Out => RegMux_dp);

    REG : Registers PORT MAP (
        ReadReg1 => Instr25To21_dp,
        ReadReg2 => Instr20To16_dp,
        WriteReg => RegMux_dp,
        WriteData => WriteDataReg_dp,
        RegWrite => RegWrite_dp,
        ReadData1 => RegToALU,
        ReadData2 => RegToALUMUX);
                              
    SIGN_EXTEND_16 :  Sign_Extend PORT MAP (
        Input => Instr15To0_dp,
        Output => Instr15To0_SE_dp);
                              
    ALU_MUX : MUX PORT MAP (
        IN0 => RegToALUMUX,
        IN1 => Instr15To0_SE_dp,
        MUX_Sel => ALUSrc_dp,
        MUX_Out => ALUMUXOutput_dp);
                              
    MAIN_ALU : ALU PORT MAP (
        INA => RegToALU,
        INB => ALUMUXOutput_dp,
        ALUCtrl => ALUCtrl_dp,
        ALU_Result => ALU_Result_dp,
        zero => zero_dp);
                        
    DATA_MEM : Data_Memory PORT MAP (
        Address => ALU_Result_dp,
        WriteData => RegToALUMUX,
        MemWrite => MemWrite_dp,
        MemRead => MemRead_dp,
        ReadData => ReadDataMem_dp);
                                     
    DMEM_MUX : MUX PORT MAP (
        IN0 => ReadDataMem_dp,
        IN1 => ALU_Result_dp,
        MUX_Sel => MemToReg_dp,
        MUX_Out => WriteDataReg_dp);
                                     
                     
    

end Behavioral;
