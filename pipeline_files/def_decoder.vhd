library ieee;
use ieee.std_logic_1164.all;

entity Def_decoder is
	port(m7_out: in std_logic_vector(15 downto 0);
		  op_code_IF_ID : in std_logic_vector(3 downto 0);
		  Mem_W,Z_W,CY_W, Comp_E,Add_Cy: out std_logic;
		  ALU1_ctrl : out std_logic_vector(1 downto 0);
		  RF_A1_Mux_out,RF_A2_Mux_out,RF_A3_Mux_out: out std_logic_vector(2 downto 0);
		  Imm16_Mux_out : out std_logic_vector(15 downto 0);
		  LM_bit : out std_logic);
end entity;

architecture Struct of Def_decoder is
	component MUX_4_3 is
		port (I0,I1,I2,I3: in std_logic_vector (2 downto 0);
			S: in std_logic_vector(1 downto 0);
			Y: out std_logic_vector (2 downto 0));
	end component MUX_4_3;
	
	component MUX_2_3  is
	  port (IN_0, IN_1: in std_logic_vector(2 downto 0);
			S : in std_logic;
			Y: out std_logic_vector(2 downto 0));
	end component MUX_2_3;
	
	component MUX_4_16  is
	  port (I0,I1,I2,I3: in std_logic_vector (15 downto 0);
				S: in std_logic_vector(1 downto 0);
				Y: out std_logic_vector (15 downto 0));
	end component MUX_4_16;
	
	component SE6 is
		port(IMM6_in: in std_logic_vector(5 downto 0); SE6_out: out std_logic_vector(15 downto 0));
	end component SE6;
	
	component SE9 is
		port(IMM9_in: in std_logic_vector(8 downto 0); SE9_out: out std_logic_vector(15 downto 0));
	end component SE9;
	
	component LS is
		port (LS_in: in std_logic_vector(15 downto 0); LS_out : out std_logic_vector(15 downto 0));
	end component;
	
	component MZE is
		port(IMM9 : in std_logic_vector(8 downto 0); MZE_out : out std_logic_vector(15 downto 0));
	end component;
	
	signal opcode : std_logic_vector(3 downto 0);
	signal CZ,RF_Mux_A3_ctrl,IMM16_Mux_ctrl,RF_A3_Mux_Ctrl : std_logic_vector(1 downto 0);
	signal complement_bit,RF_A1_Mux_ctrl,RF_A2_Mux_ctrl : std_logic;
	Signal Imm6_16, Imm6_LS_16, Imm9_MZE_16, IMM9_16, IMM9_LS_16 : std_logic_vector(15 downto 0);
	
begin
	opcode <= m7_out(15 downto 12);
	
	CZ <= m7_out(1 downto 0);
	
	complement_bit <= m7_out(2);
	
	Comp_E <= ( (not(opcode(3)) and not(opcode(2)) and not(opcode(1)) and opcode(0)) or ( not(opcode(3)) and not(opcode(2)) and opcode(1) and not(opcode(0)) ) ) and complement_bit;
	
	Z_W <= ( not(opcode(3)) and not(opcode(2)) and not(opcode(1)) and opcode(0) ) or ( not(opcode(3)) and not(opcode(2)) and not(opcode(0)) );
	
	CY_w <= not(opcode(3)) and not(opcode(2)) and not(opcode(1));
	
	ALU1_ctrl(1) <= (not(opcode(3)) and not(opcode(2)) and opcode(1) and opcode(0)) or (opcode(3) and not(opcode(2))) or (opcode(3) and opcode(2) and opcode(1) and opcode(0));
	
	ALU1_ctrl(0) <= (not(opcode(3)) and not(opcode(2)) and opcode(1)) or (opcode(3) and opcode(1) and opcode(0));
	
	Mem_W <= not(opcode(3)) and opcode(2) and not(opcode(1)) and opcode(0);
	
	ADD_CY <= (not(opcode(3)) and not(opcode(2)) and not(opcode(1)) and opcode(0)) and CZ(1) and CZ(0);
	
	RF_A1_Mux_ctrl <= (not(opcode(3)) and opcode(2) and not(opcode(1))) or (opcode(3) and opcode(2) and not(opcode(1)) and opcode(0));  
	
	RF_A1_Mux : MUX_2_3 port map(m7_out(11 downto 9),m7_out(8 downto 6),RF_A1_Mux_ctrl,RF_A1_Mux_out);
	
	RF_A2_Mux_ctrl <= (not(opcode(3)) and not(opcode(2)) and opcode(1) and not(opcode(0))) or (opcode(3) and not(opcode(2))) or (not(opcode(3)) and not(opcode(2)) and not(opcode(1)) and opcode(0));
	
	RF_A2_Mux : MUX_2_3 port map(m7_out(11 downto 9),m7_out(8 downto 6),RF_A2_Mux_ctrl,RF_A2_Mux_out);
	
	RF_A3_Mux_ctrl(1) <= (not(opcode(3)) and not(opcode(2)) and opcode(1) and opcode(0)) or (not(opcode(3)) and opcode(2) and not(opcode(1)) and not(opcode(0))) or (opcode(3) and opcode(2) and not(opcode(1)));
	
	RF_A3_Mux_ctrl(0) <= (not(opcode(3)) and not(opcode(2)) and not(opcode(1)) and not(opcode(0)));
	
	RF_A3_Mux : MUX_4_3 port map(m7_out(5 downto 3), m7_out(8 downto 6), m7_out(11 downto 9), "000", RF_A3_Mux_ctrl, RF_A3_Mux_out);
	
	SE6_1 : SE6 port map(m7_out(5 downto 0),Imm6_16);
	
	LS_1 : LS port map(Imm6_16, IMM6_LS_16);
	
	MZE_1 : MZE port map(m7_out(8 downto 0), Imm9_MZE_16);
	
	SE9_1 : MZE port map(m7_out(8 downto 0), IMM9_16);
	
	LS_2 : LS port map(Imm9_16, IMM9_LS_16);
	
	IMM16_MUX_CTRL(1) <= (not(opcode(3)) and not(opcode(2)) and opcode(1) and opcode(0)) or (opcode(3) and opcode(2) and not(opcode(1)) and opcode(0)) or (opcode(3) and opcode(2) and opcode(1) and opcode(0));
	
	IMM16_MUX_CTRL(0) <= (opcode(3) and not(opcode(2))) or (opcode(3) and opcode(2) and not(opcode(1)) and not(opcode(0))) or (opcode(3) and opcode(2) and opcode(1) and opcode(0));
	
	IMM16_Mux : MUX_4_16 port map(IMM6_16, IMM6_LS_16, IMM9_MZE_16, IMM9_LS_16, IMM16_MUX_ctrl, IMM16_MUX_out);
	
	LM_bit <= (not op_code_IF_ID(3)) and (op_code_IF_ID(2)) and (op_code_IF_ID(1)) and (not op_code_IF_ID(0));
	
end Struct;