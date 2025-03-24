library ieee;
use ieee.std_logic_1164.all;

entity Pipeline_CPU is
	port(clk, reset: in std_logic);
end entity Pipeline_CPU;

architecture Struct of Pipeline_CPU is
	
	component RegisterFile is
		port(A1, A2, A3 : IN std_logic_vector(2 downto 0);
				D1, D2 : OUT std_logic_vector(15 downto 0);
				D3 : IN std_logic_vector(15 downto 0);
				IP_W : IN std_logic;
				PC_in : IN std_logic_vector(15 downto 0);
				PC_out : OUT std_logic_vector(15 downto 0);
		      RF_W, Clk, Reset : IN std_logic
--			  R0_out, R1_out, R2_out,R3_out,R4_out,R5_out,R6_out,R7_out : OUT std_logic_vector(15 downto 0)
		  );
	end component RegisterFile;
	
	component instr_memory is 
	port (clk : in std_logic;
			addr_in : in std_logic_vector (15 downto 0);
			data_out : out std_logic_vector (15 downto 0):="0000000000000000");
	end component instr_memory;
	
	component ALU is
	port(ALU_A, ALU_B: in std_logic_vector(15 downto 0);
			ALU_C: out std_logic_vector(15 downto 0));
	end component;
	
	component m1_IP_mux is
		port(op_IF_ID, op_ID_RR, op_RR_EX, OP_EX_Mem: in std_logic_vector(3 downto 0);
			ALU4_C, ALU5_C, RF_D1, ALU3_C, ALU2_C: in std_logic_vector(15 downto 0);
			ALU1_Z, ALU1_Cy: in std_logic;
			RF_W_dec_out: in std_logic;
			RF_A3_RR_EX, RF_A3_dec_out, RF_A3_EX_Mem: in std_logic_vector(2 downto 0);
			ALU1_C, Imm16_dec_out, Data_Mem_D_out: in std_logic_vector(15 downto 0);
			PC_in_R0: in std_logic_vector(15 downto 0);
			st_bit: in std_logic;
			IP_mux_out: out std_logic_vector(15 downto 0);
			rst_IF_ID, rst_ID_RR, rst_RR_EX, rst_EX_Mem, rst_Mem_WB: out std_logic;
			hx7, b_hazard_for_lm_sm: out std_logic);
	end component;
	
	component MUX_2_16  is
	port (IN_0, IN_1: in std_logic_vector(15 downto 0);
				S : in std_logic;
				Y: out std_logic_vector(15 downto 0));
	end component MUX_2_16;

	component IF_ID is
	port(instrn_in, PC_in : IN std_logic_vector(15 downto 0);
		Rst_IF_ID, Clk, En_IF_ID: IN std_logic;
		instrn_out, PC_out : OUT std_logic_vector(15 downto 0));
	end component IF_ID;
	
	component Def_decoder is
		port(m7_out: in std_logic_vector(15 downto 0);
		  op_code_IF_ID : in std_logic_vector(3 downto 0);
		  Mem_W,Z_W,CY_W, Comp_E,Add_Cy: out std_logic;
		  ALU1_ctrl : out std_logic_vector(1 downto 0);
		  RF_A1_Mux_out,RF_A2_Mux_out,RF_A3_Mux_out: out std_logic_vector(2 downto 0);
		  Imm16_Mux_out : out std_logic_vector(15 downto 0);
		  LM_bit : out std_logic);
	end component;
	
	component ID_RR is
	port(instrn_in, PC_in, Imm_in : IN std_logic_vector(15 downto 0);
	  RF_A1_in, RF_A2_in, RF_A3_in : IN std_logic_vector(2 downto 0);
	  ALU1_op_in : IN std_logic_vector(1 downto 0);
	  Mem_W_in, IP_W_in, Zf_W_in, Cy_W_in, comp_en_in, add_cy_in : IN std_logic;
	  Rst_ID_RR, Clk, En_ID_RR: IN std_logic;
	  instrn_out, PC_out, Imm_out: OUT std_logic_vector(15 downto 0);
	  RF_A1_out, RF_A2_out, RF_A3_out : OUT std_logic_vector(2 downto 0);
	  ALU1_op_out : OUT std_logic_vector(1 downto 0);
	  Mem_W_out, IP_W_out, Zf_W_out, Cy_W_out, comp_en_out, add_cy_out : OUT std_logic;
	  LM_bit_in : IN std_logic;
	  LM_bit_out : OUT std_logic);
	end component ID_RR;
	
	component mux_RF_D3 is 
		port (op_code : IN std_logic_vector(3 downto 0);
				alu1_C, mem_Dout, Imm: IN std_logic_vector(15 downto 0);
				mux_out : OUT std_logic_vector(15 downto 0)
				);
	end component mux_RF_D3;
	
	component RR_EX is
	port(instrn_in, PC_in, Imm_in, RF_D1_in, RF_D2_in : IN std_logic_vector(15 downto 0);
	  RF_A3_in : IN std_logic_vector(2 downto 0);
	  ALU1_op_in : IN std_logic_vector(1 downto 0);
	  Mem_W_in, IP_W_in, Zf_W_in, Cy_W_in, comp_en_in, add_cy_in : IN std_logic;
	  Rst_RR_EX, Clk, En_RR_EX: IN std_logic;
	  instrn_out, PC_out, Imm_out, RF_D1_out, RF_D2_out: OUT std_logic_vector(15 downto 0);
	  RF_A3_out : OUT std_logic_vector(2 downto 0);
	  ALU1_op_out : OUT std_logic_vector(1 downto 0);
	  Mem_W_out, IP_W_out, Zf_W_out, Cy_W_out, comp_en_out, add_cy_out : OUT std_logic;
	  LM_bit_in : IN std_logic;
	  LM_bit_out : OUT std_logic
	  );
	end component RR_EX;
	
	component ALU1_A_mux is
		port(ALU1_A: out std_logic_vector(15 downto 0);
				opcode_RR_EX: in std_logic_vector(3 downto 0);
				PC_RR_EX, RF_D1_RR_EX: in std_logic_vector(15 downto 0));
	end component;
	
	component ALU1_B_mux is
		port(ALU1_B: out std_logic_vector(15 downto 0);
				opcode_RR_EX: in std_logic_vector(3 downto 0);
				Imm_RR_EX, COMP_out: in std_logic_vector(15 downto 0));
	end component;
	
	component COMP is
		port(RF_D2_RR_EX: in std_logic_vector(15 downto 0); COMP_En: in std_logic; COMP_out: out std_logic_vector(15 downto 0));
	end component COMP;
	
	component ALU1 is
		port(ALU1_A, ALU1_B: in std_logic_vector(15 downto 0);
			ALU1_ctrl: in std_logic_vector(1 downto 0);
			Cy_in: in std_logic;
			Add_Cy: in std_logic;
			ALU1_C: out std_logic_vector(15 downto 0);
			ALU1_Cy, ALU1_Z: out std_logic);
	end component;
	
	component Cy_reg is
		port(Clk,Reset,Cy_W, Cy_in : in std_logic;
			  Cy_out : out std_logic);
	end component Cy_reg;
	
	component Zf_reg is
		port(Clk,Reset,Zf_W, Zf_in : in std_logic;
			  Zf_out : out std_logic);
	end component Zf_reg;
	
	component RF_W_decoder is 
		port (B0, B1, Cy, Zf : IN std_logic; --B0 = Instrn_RR/EX_bit1, B1 = Instrn_RR/EX_bit0
				op_code : IN std_logic_vector(3 downto 0);
				RF_W : OUT std_logic
				);
	end component RF_W_decoder;

	component EX_Mem is
	port(instrn_in, RF_D2_in, ALU1_C_in, Imm_in : IN std_logic_vector(15 downto 0);
	  RF_A3_in : IN std_logic_vector(2 downto 0);
	  Mem_W_in, IP_W_in, RF_W_in : IN std_logic;
	  Rst_EX_Mem, Clk, En_EX_Mem: IN std_logic;
	  instrn_out, RF_D2_out, ALU1_C_out, Imm_out: OUT std_logic_vector(15 downto 0);
	  RF_A3_out : OUT std_logic_vector(2 downto 0);
	  Mem_W_out, IP_W_out, RF_W_out : OUT std_logic;
	  LM_bit_in : IN std_logic;
	  LM_bit_out : OUT std_logic
	  );
	end component EX_Mem;
	
	component multiple_decoder is
		port(inst : in std_logic_vector(15 downto 0);
			clk : in std_logic;
			LW_SW : out std_logic_vector(15 downto 0);
			LM_SM_updated : out std_logic_vector(15 downto 0);
			mult_cntrl : out std_logic := '0';
			mult_cntrl_bar : out std_logic := '1';
			lm_or_sm : out std_logic := '0'
		);
	end component multiple_decoder;
	
	component data_memory is 
		port (clk : in std_logic;
				Mem_W : in std_logic;
				addr_in : in std_logic_vector (15 downto 0);
				data_in : in std_logic_vector (15 downto 0);
				data_out : out std_logic_vector (15 downto 0):="0000000000000000");
	end component data_memory;
	
	component Mem_WB is
	port(instrn_in, ALU1_C_in, Mem_Dout_in, Imm_in: IN std_logic_vector(15 downto 0);
		  RF_A3_in : IN std_logic_vector(2 downto 0);
		  IP_W_in, RF_W_in : IN std_logic;
		  Rst_Mem_WB, Clk, En_Mem_WB: IN std_logic;
		  instrn_out, ALU1_C_out, Mem_Dout_out, Imm_out: OUT std_logic_vector(15 downto 0);
		  RF_A3_out : OUT std_logic_vector(2 downto 0);
		  IP_W_out, RF_W_out : OUT std_logic
		  );
	end component Mem_WB;
	
	component pipeline_reg_rst_decoder is
		port (opcode_RR_EX, opcode_ID_RR, opcode_IF_ID : IN std_logic_vector(3 downto 0);
				ALU1_Cy, ALU1_Zf : IN std_logic;
				RST_IF_ID, RST_ID_RR, RST_RR_EX, RST_EX_Mem, RST_Mem_WB : OUT std_logic
				);
	end component pipeline_reg_rst_decoder;
	
	component hazard_detect_control_RF_A1 is
		port(op_ID_RR, op_RR_EX, op_EX_Mem, OP_Mem_WB: in std_logic_vector(3 downto 0);
			RF_D1, ALU1_C, ALU1_C_EX_Mem, ALU1_C_Mem_WB, Data_Mem_D_out, Data_Mem_D_out_Mem_WB, Imm_RR_EX, Imm_EX_Mem, Imm_Mem_WB: in std_logic_vector(15 downto 0);
			RF_A1_ID_RR, RF_A3_RR_EX, RF_A3_EX_Mem, RF_A3_Mem_WB: in std_logic_vector(2 downto 0);
			RF_D1_mux_out: out std_logic_vector(15 downto 0);
			reset_RR_EX_hz, En_IF_ID, En_ID_RR, PC_W_hz: out std_logic;
			RF_W, RF_W_EX_Mem, RF_W_Mem_WB: in std_logic;
			hz_global: in std_logic;
			LM_bit_ID_RR, LM_bit_RR_EX: in std_logic);
	end component;
	
	component hazard_detect_control_RF_A2 is
		port(op_ID_RR, op_RR_EX, op_EX_Mem, OP_Mem_WB: in std_logic_vector(3 downto 0);
			RF_D2, ALU1_C, ALU1_C_EX_Mem, ALU1_C_Mem_WB, Data_Mem_D_out, Data_Mem_D_out_Mem_WB, Imm_RR_EX, Imm_EX_Mem, Imm_Mem_WB: in std_logic_vector(15 downto 0);
			RF_A2_ID_RR, RF_A3_RR_EX, RF_A3_EX_Mem, RF_A3_Mem_WB: in std_logic_vector(2 downto 0);
			RF_D2_mux_out: out std_logic_vector(15 downto 0);
			reset_RR_EX_hz, En_IF_ID, En_ID_RR, PC_W_hz: out std_logic;
			RF_W, RF_W_EX_Mem, RF_W_Mem_WB: in std_logic;
			hz_global: in std_logic);
	end component;
	
	component RF_D1_D2_mux_for_R0 is
		port(RF_A1_ID_RR, RF_A2_ID_RR: in std_logic_vector(2 downto 0);
				op_ID_RR: in std_logic_vector(3 downto 0);
				RF_D1_in, RF_D2_in, PC_ID_RR_in: in std_logic_vector(15 downto 0);
				RF_D1_out, RF_D2_out: out std_logic_vector(15 downto 0));
	end component;
	
	component hopefully_last_hazard is
	port (RF_D1 : IN std_logic_vector(15 downto 0);
			LM_bit_ID_RR, LM_bit_RR_Ex, clk, reset : IN std_logic;
			RF_D1_RR_EX_in : OUT std_logic_vector(15 downto 0)
			);
	end component hopefully_last_hazard;
	
	signal ALU1_ctrl, ALU1_ctrl_ID_RR, ALU1_ctrl_RR_Ex: std_logic_vector(1 downto 0);
	signal RF_A1_mux_out, RF_A2_mux_out, RF_A3_mux_out, RF_A1_ID_RR, RF_A2_ID_RR, RF_A3_ID_RR, RF_A3_RR_Ex, RF_A3_Mem_WB, RF_A3_EX_Mem: std_logic_vector(2 downto 0);
	signal RF_D1, RF_D2, RF_D3_mux_out, PC_mux_out, PC, imem_out, ALU2_C, ALU4_C, LM_SM_updated, M6_out, M5_out, M7_out, INST_IF_ID, PC_IF_ID, LM_decoder_inst_out, IMM16_mux_out, INST_ID_RR, PC_ID_RR, Imm16_ID_RR : std_logic_vector(15 downto 0);
   signal INST_RR_EX, PC_RR_EX, ALU5_C,IMM16_RR_EX, RF_D1_RR_EX, RF_D2_RR_EX, ALU1_C: std_logic_vector(15 downto 0);
	signal Comp_out, ALU1_A_mux_out, ALU1_B_mux_out, ALU3_C: std_logic_vector(15 downto 0);
	signal Inst_EX_MEM, RF_D2_EX_MEM, ALU1_C_EX_Mem, Data_Mem_D_out: std_logic_vector(15 downto 0);
	signal ALU1_CY, ALU1_Z, CY, Zf, RF_W_dec_out, Mem_W_EX_Mem, PC_W_Ex_Mem, RF_W_Ex_Mem, RST_EX_Mem, En_EX_Mem: std_logic;
	signal PC_W_Mem_WB, RF_W_Mem_WB, RST_Mem_WB, En_Mem_WB, Program_Counter_W : std_logic;
	signal INST_Mem_WB, ALU1_C_Mem_WB, Data_Mem_D_out_Mem_WB, IMM16_Mem_WB, IMM16_Ex_Mem : std_logic_vector(15 downto 0);
	signal RF_D1_mux_in, RF_D2_mux_in, RF_D1_mux1_in, RF_D2_mux1_in: std_logic_vector(15 downto 0);
	signal IP_W, RF_W, mult_cntrl, mult_cntrl_bar, RST_IF_ID, En_IF_ID, lm_or_sm, Mem_W, Z_W, CY_W, Comp_E, Add_CY, RST_ID_RR, En_ID_RR, Mem_W_ID_RR, PC_W_ID_RR, Z_W_ID_RR, CY_W_ID_RR, Comp_E_ID_RR, Add_CY_ID_RR: std_logic;
	signal RST_RR_Ex, En_RR_Ex, Mem_W_RR_EX, PC_W_RR_Ex, Z_W_RR_Ex, CY_W_RR_Ex, Comp_E_RR_Ex, ADD_CY_RR_EX, RST_IF_IDs, RST_ID_RRs, RST_RR_EXs, RST_EX_Mems, RST_Mem_WBs : std_logic;
	signal data_mem_add: std_logic_vector(15 downto 0);
	signal op :std_logic_vector(3 downto 0);
	signal reset_RR_EX_hz_a1, EN_IF_ID_hz_a1, En_ID_RR_hz_a1, PC_W_hz_a1, reset_RR_EX_hz_a2, EN_IF_ID_hz_a2, En_ID_RR_hz_a2, PC_W_hz_a2: std_logic;
	signal rst_IF_ID_imh, rst_ID_RR_imh, rst_RR_EX_imh, rst_EX_mem_imh, rst_Mem_WB_imh: std_logic;
	signal hz_global, b_hazard_for_lm_sm: std_logic;
	signal lm_bit_dec_out, LM_bit_ID_RR, LM_bit_RR_EX, LM_bit_EX_Mem: std_logic;
	signal RF_D1_mux_out: std_logic_vector(15 downto 0);
begin
	
	rst_decoder: pipeline_reg_rst_decoder port map(INST_RR_EX(15 downto 12), INST_ID_RR(15 downto 12), INST_IF_ID(15 downto 12), ALU1_Cy, ALU1_z, RST_IF_IDs, RST_ID_RRs, RST_RR_EXs, RST_EX_Mems, RST_Mem_WBs);
	
	RST_IF_ID<=RST_IF_IDs or reset or rst_IF_ID_imh;
	RST_ID_RR<=RST_ID_RRs or reset or rst_ID_RR_imh;
	RST_RR_EX<=RST_RR_EXs or reset or reset_RR_EX_hz_a1 or reset_RR_EX_hz_a2 or rst_RR_EX_imh;
	RST_EX_Mem<=RST_EX_Mems or reset or rst_EX_mem_imh;
	RST_Mem_WB<=RST_Mem_WBs or reset or rst_Mem_WB_imh;

	En_IF_ID<='1' and En_IF_ID_hz_a1 and En_IF_ID_hz_a2;
	En_ID_RR<='1' and En_ID_RR_hz_a1 and En_ID_RR_hz_a2;
	En_RR_EX<='1';
	En_EX_Mem<='1';
	En_Mem_WB<='1';
	
	op<= INST_EX_MEM(15 downto 12);
	
	n1: for i in 0 to 15 generate
		data_mem_add(i)<= ALU1_C_Ex_Mem(i) and (not(op(3)) and op(2) and not(op(1)));
	end generate;
	
	Program_counter_W <= (mult_cntrl_bar or (not(mult_cntrl_bar) and b_hazard_for_lm_sm)) and PC_W_hz_a1 and PC_W_hz_a2;
	
	RF: RegisterFile port map(RF_A1_ID_RR, RF_A2_ID_RR, RF_A3_Mem_WB, RF_D1_mux1_in, RF_D2_mux1_in, RF_D3_mux_out, Program_counter_W, PC_mux_out, PC, RF_W_Mem_WB, clk, reset);
	
	imem: instr_memory port map(clk, PC, imem_out);
	
	ALU2: ALU port map(PC, "0000000000000010", ALU2_C);
	
	M6 : MUX_2_16 port map(PC, PC_IF_ID, mult_cntrl, M6_out);
	
	M5 : MUX_2_16 port map(imem_out,LM_SM_updated,mult_cntrl, M5_out);
	
	IF_ID_reg: IF_ID port map(M5_out, M6_out, RST_IF_ID, Clk, En_IF_ID, INST_IF_ID, PC_IF_ID);
	
	LM_Decoder : multiple_decoder port map(INST_IF_ID, clk, LM_decoder_inst_out, LM_SM_updated, mult_cntrl, mult_cntrl_bar, lm_or_sm);
	
	M7 : MUX_2_16 port map(INST_IF_ID, LM_decoder_inst_out, lm_or_sm, M7_out);
	
	default_decoder : def_decoder port map(M7_out, INST_IF_ID(15 downto 12), Mem_W, Z_W, CY_W, Comp_E, Add_CY, ALU1_ctrl, RF_A1_mux_out, RF_A2_mux_out, RF_A3_mux_out, Imm16_mux_out, lm_bit_dec_out);
	
	ALU4 : ALU port map(Imm16_mux_out, PC_IF_ID, ALU4_C);
	
	ID_RR_reg : ID_RR port map(M7_out, PC_IF_ID, Imm16_mux_out, RF_A1_mux_out, RF_A2_mux_out,RF_A3_mux_out, ALU1_ctrl, Mem_W, '0', Z_W, CY_W,Comp_E, Add_CY, RST_ID_RR, Clk, En_ID_RR, INST_ID_RR, PC_ID_RR, Imm16_ID_RR, RF_A1_ID_RR, RF_A2_ID_RR, RF_A3_ID_RR, ALU1_ctrl_ID_RR, Mem_W_ID_RR, PC_W_ID_RR, Z_W_ID_RR, CY_W_ID_RR, Comp_E_ID_RR, Add_CY_ID_RR, lm_bit_dec_out, LM_bit_ID_RR);
		
	RR_EX_reg : RR_EX port map(INST_ID_RR, PC_ID_RR, IMM16_ID_RR, RF_D1_mux_out, RF_D2, RF_A3_ID_RR, ALU1_ctrl_ID_RR, Mem_W_ID_RR, PC_W_ID_RR, Z_W_ID_RR, CY_W_ID_RR, Comp_E_ID_RR, Add_CY_ID_RR, RST_RR_EX, Clk, EN_RR_EX, INST_RR_EX, PC_RR_EX, IMM16_RR_EX, RF_D1_RR_EX, RF_D2_RR_EX, RF_A3_RR_EX, ALU1_ctrl_RR_EX, Mem_W_RR_EX, PC_W_RR_Ex, Z_W_RR_Ex, CY_W_RR_Ex, Comp_E_RR_Ex, ADD_CY_RR_EX, LM_bit_ID_RR, LM_bit_RR_EX);
	
	ALU5 : ALU port map(RF_D1, IMM16_ID_RR, ALU5_C);
	
	M3 : ALU1_A_mux port map(ALU1_A_mux_out, INST_RR_EX(15 downto 12), PC_RR_EX, RF_D1_RR_EX);
	
	M4 : ALU1_B_mux port map(ALU1_B_mux_out, INST_RR_EX(15 downto 12), IMM16_RR_EX, Comp_out);
	
	Comp_Block : COMP port map(RF_D2_RR_EX, Comp_E_RR_EX, Comp_out);
	
	ALU3 : ALU port map(IMM16_RR_EX, PC_RR_EX, ALU3_C);
	
	Zf_register : Zf_reg port map(Clk, reset, Z_W_RR_EX, ALU1_Z, Zf);
	
	CY_register : CY_reg port map(Clk, reset, CY_W_RR_EX, ALU1_CY, CY);
	
	ALU1_instance : ALU1 port map(ALU1_A_Mux_out, ALU1_B_mux_out, ALU1_ctrl_RR_EX, CY, Add_Cy_RR_EX, ALU1_C, ALU1_CY, ALU1_Z);
	
	RF_W_dec : RF_W_decoder port map(Inst_RR_EX(0), Inst_RR_EX(1), CY, Zf, Inst_RR_EX(15 downto 12), RF_W_dec_out);
	
	M1 : M1_IP_Mux port map(INST_IF_ID(15 downto 12), INST_ID_RR(15 downto 12), INST_RR_EX(15 downto 12), INST_EX_Mem(15 downto 12), ALU4_C, ALU5_C, RF_D1, ALU3_C, ALU2_C, ALU1_Z, ALU1_Cy, RF_W_dec_out, RF_A3_RR_EX, RF_A3_mux_out, RF_A3_EX_Mem, ALU1_C, Imm16_mux_out, Data_Mem_D_out, PC, st_bit, PC_mux_out, rst_IF_ID_imh, rst_ID_RR_imh, rst_RR_EX_imh, rst_EX_mem_imh, rst_Mem_WB_imh, hz_global, b_hazard_for_lm_sm);
	
	EX_Mem_reg : EX_MEM port map(INST_RR_EX, RF_D2_RR_EX, ALU1_C, IMM16_RR_Ex, RF_A3_RR_EX, Mem_W_RR_EX, PC_W_RR_EX, RF_W_dec_out, RST_EX_Mem, Clk, En_EX_Mem, Inst_EX_MEM, RF_D2_EX_MEM, ALU1_C_EX_Mem, IMM16_EX_Mem, RF_A3_EX_Mem, Mem_W_EX_Mem, PC_W_Ex_Mem, RF_W_Ex_Mem, LM_bit_RR_EX, LM_bit_EX_Mem);
	
	Data_Mem : Data_Memory port map(Clk, Mem_W_Ex_Mem, data_mem_add, RF_D2_EX_Mem, Data_Mem_D_out); 
	
	Mem_WB_reg : MEM_WB port map(INST_EX_Mem, ALU1_C_Ex_Mem, Data_Mem_D_out, IMM16_EX_MEM, RF_A3_Ex_Mem, PC_W_Ex_MEM, RF_W_EX_Mem, RST_Mem_WB, Clk, En_Mem_WB, INST_Mem_WB, ALU1_C_Mem_WB, Data_Mem_D_out_Mem_WB, IMM16_MEM_WB, RF_A3_Mem_WB, PC_W_Mem_WB, RF_W_Mem_WB);
	
	M2 : Mux_RF_D3 port map(INST_Mem_WB(15 downto 12), ALU1_C_Mem_WB, Data_mem_D_out_Mem_WB, IMM16_Mem_WB, RF_D3_Mux_out);
	
	rf_a1_haz: hazard_detect_control_RF_A1 port map(INST_ID_RR(15 downto 12), INST_RR_EX(15 downto 12), INST_EX_Mem(15 downto 12), INST_Mem_WB(15 downto 12), RF_D1_mux_in, ALU1_C, ALU1_C_EX_Mem, ALU1_C_Mem_WB, Data_Mem_D_out, Data_Mem_D_out_Mem_WB, Imm16_RR_EX, Imm16_EX_Mem, Imm16_Mem_WB, RF_A1_ID_RR, RF_A3_RR_EX, RF_A3_EX_Mem, RF_A3_Mem_WB, RF_D1, reset_RR_EX_hz_a1, EN_IF_ID_hz_a1, En_ID_RR_hz_a1, PC_W_hz_a1, RF_W_dec_out, RF_W_EX_Mem, RF_W_Mem_WB, hz_global, LM_bit_ID_RR, LM_bit_RR_EX);
	
	rf_a2_haz: hazard_detect_control_RF_A2 port map(INST_ID_RR(15 downto 12), INST_RR_EX(15 downto 12), INST_EX_Mem(15 downto 12), INST_Mem_WB(15 downto 12), RF_D2_mux_in, ALU1_C, ALU1_C_EX_Mem, ALU1_C_Mem_WB, Data_Mem_D_out, Data_Mem_D_out_Mem_WB, Imm16_RR_EX, Imm16_EX_Mem, Imm16_Mem_WB, RF_A2_ID_RR, RF_A3_RR_EX, RF_A3_EX_Mem, RF_A3_Mem_WB, RF_D2, reset_RR_EX_hz_a2, EN_IF_ID_hz_a2, En_ID_RR_hz_a2, PC_W_hz_a2, RF_W_dec_out, RF_W_EX_Mem, RF_W_Mem_WB, hz_global);
	
	R0_mux: RF_D1_D2_mux_for_R0 port map(RF_A1_ID_RR, RF_A2_ID_RR, INST_ID_RR(15 downto 12), RF_D1_mux1_in, RF_D2_mux1_in, PC_ID_RR, RF_D1_mux_in, RF_D2_mux_in);
	
	hlh: hopefully_last_hazard port map(RF_D1, LM_bit_ID_RR, LM_bit_RR_Ex, clk, reset, RF_D1_mux_out);
	
end Struct;