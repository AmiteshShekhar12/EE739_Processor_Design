library ieee;
use ieee.std_logic_1164.all;

entity hazard_detect_control_RF_A1 is
	port(op_ID_RR, op_RR_EX, op_EX_Mem, OP_Mem_WB: in std_logic_vector(3 downto 0);
			RF_D1, ALU1_C, ALU1_C_EX_Mem, ALU1_C_Mem_WB, Data_Mem_D_out, Data_Mem_D_out_Mem_WB, Imm_RR_EX, Imm_EX_Mem, Imm_Mem_WB: in std_logic_vector(15 downto 0);
			RF_A1_ID_RR, RF_A3_RR_EX, RF_A3_EX_Mem, RF_A3_Mem_WB: in std_logic_vector(2 downto 0);
			RF_D1_mux_out: out std_logic_vector(15 downto 0);
			reset_RR_EX_hz, En_IF_ID, En_ID_RR, PC_W_hz: out std_logic;
			RF_W, RF_W_EX_Mem, RF_W_Mem_WB: in std_logic;
			hz_global: in std_logic;
			LM_bit_ID_RR, LM_bit_RR_EX: in std_logic);
end entity;


architecture struct of hazard_detect_control_RF_A1 is

	signal h1, h2, h3, h4, h5, h6, h7, h8, h9, h10, h11, h12: std_logic;
	signal x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12: std_logic;
	signal c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12 : std_logic;
	signal s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12 : std_logic;
	signal l1,l2: std_logic;
	signal RF_A1_op: std_logic;
	signal op: std_logic_vector(3 downto 0);
	

begin
	c1<= (not(op_RR_EX(3)) and not(op_RR_Ex(2)) and not(op_RR_Ex(1))) or (not(op_RR_Ex(3)) and not(op_RR_Ex(2)) and op_RR_Ex(1) and not(op_RR_Ex(0)));
	c2<= (not(op_EX_Mem(3)) and not(op_Ex_Mem(2)) and not(op_Ex_Mem(1))) or (not(op_Ex_Mem(3)) and not(op_Ex_Mem(2)) and op_Ex_Mem(1) and not(op_Ex_Mem(0)));
	c3<= (not(op_Mem_WB(3)) and not(op_Mem_WB(2)) and not(op_Mem_WB(1))) or (not(op_Mem_WB(3)) and not(op_Mem_WB(2)) and op_Mem_WB(1) and not(op_Mem_WB(0)));
	s1<= (RF_A3_RR_EX(2) xnor RF_A1_ID_RR(2)) and (RF_A3_RR_EX(1) xnor RF_A1_ID_RR(1)) and (RF_A3_RR_EX(0) xnor RF_A1_ID_RR(0));
	s2<= (RF_A3_EX_Mem(2) xnor RF_A1_ID_RR(2)) and (RF_A3_EX_Mem(1) xnor RF_A1_ID_RR(1)) and (RF_A3_EX_Mem(0) xnor RF_A1_ID_RR(0));
	s3<= (RF_A3_Mem_WB(2) xnor RF_A1_ID_RR(2)) and (RF_A3_Mem_WB(1) xnor RF_A1_ID_RR(1)) and (RF_A3_Mem_WB(0) xnor RF_A1_ID_RR(0));
	h1<= c1 and s1 and RF_A1_op and RF_W;
	h2<= c2 and s2 and RF_A1_op and RF_W_EX_Mem;
	h3<= c3 and s3 and RF_A1_op and RF_W_Mem_WB;
	
	c4<= (not(op_RR_EX(3)) and op_RR_Ex(2) and not(op_RR_Ex(1)) and not(op_RR_Ex(0)));
	c5<= (not(op_Ex_Mem(3)) and op_Ex_Mem(2) and not(op_Ex_Mem(1)) and not(op_Ex_Mem(0)));
	c6<= (not(op_Mem_WB(3)) and op_Mem_WB(2) and not(op_Mem_WB(1)) and not(op_Mem_WB(0)));
	s4<= s1;
	s5<= s2;
	s6<= s3;
	h4<= c4 and s4 and RF_A1_op and not(hz_global) and not(LM_bit_ID_RR and LM_bit_RR_EX);
	h5<= c5 and s5 and RF_A1_op;
	h6<= c6 and s6 and RF_A1_op;
	
	c7<= (not(op_RR_EX(3)) and not(op_RR_Ex(2)) and op_RR_Ex(1) and op_RR_Ex(0));
	c8<= (not(op_Ex_Mem(3)) and not(op_Ex_Mem(2)) and op_Ex_Mem(1) and op_Ex_Mem(0));
	c9<= (not(op_Mem_WB(3)) and not(op_Mem_WB(2)) and op_Mem_WB(1) and op_Mem_WB(0));
	s7<= s1;
	s8<= s2;
	s9<= s3;
	h7<= c7 and s7 and RF_A1_op;
	h8<= c8 and s8 and RF_A1_op;
	h9<= c9 and s9 and RF_A1_op;
	
	c10<= (op_Ex_Mem(3) and op_Ex_Mem(2) and not(op_Ex_Mem(1)) and not(op_Ex_Mem(0)));
	c11<= (op_Mem_WB(3) and op_Mem_WB(2) and not(op_Mem_WB(1)) and not(op_Mem_WB(0)));
	c12<= (op_Mem_WB(3) and op_Mem_WB(2) and not(op_Mem_WB(1)) and op_Mem_WB(0));
	s10<= s2;
	s11<= s3;
	s12<= s3;
	h10<= c10 and s10 and RF_A1_op;
	h11<= c11 and s11 and RF_A1_op;
	h12<= c12 and s12 and RF_A1_op;
	
	op<= op_ID_RR;
					
   rf_a1_op<= (not(op(3)) and not(op(1))) or (not(op(2)) and op(1) and not(op(0))) 
					or (op(3) and op(2) and op(0)) or (op(3) and not(op(2)) and not(op(1)));

					
	l1<= h1 or h4 or h7;
	l2<= h2 or h5 or h8 or h10;
	
	x3<= h3 and not(l2) and not(l1);
	x6<= h6 and not(l2) and not(l1);
	x9<= h9 and not(l2) and not(l1);
	x11<= h11 and not(l2) and not(l1);
	x12<= h12 and not(l2) and not(l1);
	
	x2<= h2 and not(l1);
	x5<= h5 and not(l1);
	x8<= h8 and not(l1);
	x10<= h10 and not(l1);
	
	x1<= h1;
	x4<= h4;
	x7<= h7;
	
	n1 : for i in 0 to 15 generate
	RF_D1_mux_out(i)<= (x1 and ALU1_C(i)) or ((x2 or x10) and ALU1_C_EX_Mem(i)) 
							  or ((x3 or x11 or x12) and ALU1_C_Mem_WB(i)) or (x5 and Data_Mem_D_out(i))
							  or (x6 and Data_Mem_D_out_Mem_WB(i)) or (x7 and Imm_RR_EX(i)) or (x8 and Imm_EX_Mem(i))
							  or (x9 and Imm_Mem_WB(i))
							  or (not(x1) and not(x2) and not(x3) and not(x5) and not(x6) and not(x7) and not(x8) and not(x9) and not(x10) and not(x11) and not(x12) and RF_D1(i));
	end generate;
	
	En_IF_ID<= not(x4);
	En_ID_RR<= not(x4);
	PC_W_hz<= not(x4);
	reset_RR_EX_hz<= x4;
	
end struct;