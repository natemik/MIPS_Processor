LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY controller IS PORT (
    OPCODE_ctrl : IN std_logic_vector(31 downto 26);
    
    RegDst_ctrl :    OUT std_logic;
    Jump_ctrl :      OUT std_logic;
    Branch_ctrl :    OUT std_logic;
    MemRead_ctrl :   OUT std_logic;
    MemtoReg_ctrl :  OUT std_logic;
    ALUOp_ctrl :     OUT std_logic_vector(1 downto 0);
    MemWrite_ctrl :  OUT std_logic;
    ALUSrc_ctrl :    OUT std_logic;
    RegWrite_ctrl :  OUT std_logic);
END controller;

architecture Behaviour of controller is
-- Instruction Types and their opcodes (pre-decided)
CONSTANT LW : std_logic_vector(5 downto 0) := "100011"; --Load Word
CONSTANT SW : std_logic_vector(5 downto 0) := "101011"; --Store Word
CONSTANT RTYPE : std_logic_vector(5 downto 0) := "000000"; --R-Type Instruction
CONSTANT BEQ : std_logic_vector(5 downto 0) := "000100"; --Branch On Equal

--CONSTANT SLL_FUNCT : std_logic_vector(5 downto 0) := "000000"; --Shift Logical Left Funct
--CONSTANT SRL_FUNCT : std_logic_vector(5 downto 0) := "000010"; --Shift Logical Right Funct
--CONSTANT SRA_FUNCT : std_logic_vector(5 downto 0) := "000011"; --Shift Arithmetic Right Funct
--CONSTANT ADD_FUNCT : std_logic_vector(5 downto 0) := "100000"; --Add
--CONSTANT SUB_FUNCT : std_logic_vector(5 downto 0) := "100010"; --Subtract
--CONSTANT AND_FUNCT : std_logic_vector(5 downto 0) := "100100"; --And
--CONSTANT OR_FUNCT : std_logic_vector(5 downto 0) := "100101"; --Or
--CONSTANT XOR_FUNCT : std_logic_vector(5 downto 0) := "100110"; --Xor
--CONSTANT NOR_FUNCT : std_logic_vector(5 downto 0) := "100111"; --Nor
--CONSTANT SLT_FUNCT : std_logic_vector(5 downto 0) := "101010"; --Set Less Than

--CONSTANT ADDIU : std_logic_vector(5 downto 0) := "001001"; --Add Immediate Unsigned
--CONSTANT SLTI : std_logic_vector(5 downto 0) := "001010"; --Set Less Than Immediate
--CONSTANT SLTIU : std_logic_vector(5 downto 0) := "001011"; --Set Less Than Immediate Unsigned
--CONSTANT ANDI : std_logic_vector(5 downto 0) := "001100"; --And Immediate
--CONSTANT ORI : std_logic_vector(5 downto 0) := "001101"; --Or Immediate
--CONSTANT XORI : std_logic_vector(5 downto 0) := "001110"; --Xor Immediate
--CONSTANT LUI : std_logic_vector(5 downto 0) := "001111"; --Load Upper Immediate

--CONSTANT J : std_logic_vector(5 downto 0) := "000010"; --Jump
--CONSTANT JAL : std_logic_vector(5 downto 0) := "000011"; --Jump and Link
--CONSTANT BNE : std_logic_vector(5 downto 0) := "000101"; --Branch On Not Equal
--CONSTANT BLEZ : std_logic_vector(5 downto 0) := "000110"; --Branch On LT or Equal To Zero
--CONSTANT BGTZ : std_logic_vector(5 downto 0) := "000111"; --Branch On Greater Than Zero
--CONSTANT BLTZ : std_logic_vector(5 downto 0) := "000001"; --Branch On Less Than Zero
--CONSTANT BGEZ : std_logic_vector(5 downto 0) := "001010"; --Branch On GT or Equal to Zero

BEGIN
    CONTROLLER : PROCESS(OPCODE_ctrl) BEGIN
        CASE OPCODE_ctrl IS                                      
            WHEN LW =>
                RegDst_ctrl <= '0';
                Jump_ctrl <= '0';
                Branch_ctrl <= '0';
                MemRead_ctrl <= '1';
                MemtoReg_ctrl <= '1';
                ALUOp_ctrl <= "00";
                MemWrite_ctrl <= '0';
                ALUSrc_ctrl <= '1';
                RegWrite_ctrl <= '1';
            WHEN SW =>
                RegDst_ctrl <= '0';
                Jump_ctrl <= '0';
                Branch_ctrl <= '0';
                MemRead_ctrl <= '0';
                MemtoReg_ctrl <= '0';
                ALUOp_ctrl <= "00";
                MemWrite_ctrl <= '1';
                ALUSrc_ctrl <= '0';
                RegWrite_ctrl <= '1';
            WHEN RTYPE =>
                RegDst_ctrl <= '1';
                Jump_ctrl <= '0';
                Branch_ctrl <= '0';
                MemRead_ctrl <= '0';
                MemtoReg_ctrl <= '0';
                ALUOp_ctrl <= "10";
                MemWrite_ctrl <= '0';
                ALUSrc_ctrl <= '0';
                RegWrite_ctrl <= '1';
            WHEN BEQ =>
                RegDst_ctrl <= '0';
                Jump_ctrl <= '0';
                Branch_ctrl <= '1';
                MemRead_ctrl <= '0';
                MemtoReg_ctrl <= '0';
                ALUOp_ctrl <= "01";
                MemWrite_ctrl <= '0';
                ALUSrc_ctrl <= '0';
                RegWrite_ctrl <= '0';
            WHEN others => 
                RegDst_ctrl <= '0';
                Jump_ctrl <= '0';
                Branch_ctrl <= '0';
                MemRead_ctrl <= '0';
                MemtoReg_ctrl <= '0';
                ALUOp_ctrl <= "00";
                MemWrite_ctrl <= '0';
                ALUSrc_ctrl <= '0';
                RegWrite_ctrl <= '0';
        END CASE;
    END PROCESS;                                      
            
end architecture;