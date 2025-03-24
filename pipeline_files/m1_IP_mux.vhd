library ieee;
use ieee.std_logic_1164.all;

entity m1_IP_mux is
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
end entity;


architecture struct of m1_IP_mux is

	signal c1, c2, c3, c4, c5, c6, c7, s5, s6, s7, l1, l2, l3: std_logic;
	signal x1, x2, x3, x4, x5, x6, x7, x8, x_bar: std_logic;
	signal IP1, IP2, IP3, IP4, IP5, IP6, IP7, IP_def: std_logic_vector(15 downto 0);
	signal op: std_logic_vector(3 downto 0);

begin
	
	op<=op_RR_EX;
	
	s5<= not(op(3)) and not(op(2)) and ((not(op(1)) and not(op(0))) or (op(1) and not(op(0))) or (not(op(1)) and op(0)));
	s6<= not(op_IF_ID(3)) and not(op_IF_ID(2)) and op_IF_ID(1) and op_IF_ID(0);
	s7<= not(op_EX_Mem(3)) and op_EX_Mem(2) and not(op_EX_Mem(1)) and not(op_EX_Mem(0));
	
	c1<= op_IF_ID(3) and op_IF_ID(2) and not(op_IF_ID(1)) and not(op_IF_ID(0));
	c2<= op_ID_RR(3) and op_ID_RR(2) and not(op_ID_RR(1)) and op_ID_RR(0);
	c3<= op_ID_RR(3) and op_ID_RR(2) and op_ID_RR(1) and op_ID_RR(0);
	c4<= (op(3) and not(op(2)) and not(op(1)) and not(op(0)) and ALU1_Z) or (op(3) and not(op(2)) and not(op(1)) and op(0) and ALU1_Cy) or (op(3) and not(op(2)) and op(1) and not(op(0)) and (ALU1_Z or ALU1_Cy));
	c5<= s5 and RF_W_dec_out and not(RF_A3_RR_EX(2)) and not(RF_A3_RR_EX(1)) and not(RF_A3_RR_EX(0));
	c6<= s6 and not(RF_A3_dec_out(2)) and not(RF_A3_dec_out(1)) and not(RF_A3_dec_out(0));
	c7<= s7 and not(RF_A3_EX_Mem(2)) and not(RF_A3_EX_Mem(1)) and not(RF_A3_EX_Mem(0));
	
	l1<= c7;
	l2<= c4 or c5;
	l3<= c2 or c3;
	
	x1<= c1 and not(l1) and not(l2) and not(l3);
	x6<= c6 and not(l1) and not(l2) and not(l3);
	x2<= c2 and not(l1) and not(l2);
	x3<= c3 and not(l1) and not(l2);
	x4<= c4 and not(l1);
	x5<= c5 and not(l1);
	x7<= c7;
	x8<= st_bit and not(c1) and not(l1) and not(l2) and not(l3) and not(c6);
	x8<= not(x1) and not(x2) and not(x3) and not(x4) and not(x5) and not(x6) and not(x7) and not(x8);
	
	IP1<= ALU4_C;
	IP2<= RF_D1;
	IP3<= ALU5_C;
	IP4<= ALU3_C;	
	IP5<= ALU1_c;
	IP6<= Imm16_dec_out;
	IP7<= Data_Mem_D_out;
	IP_def<= ALU2_C;
	
	n: for i in 15 downto 0 generate
		IP_mux_out(i)<= (x1 and IP1(i)) or (x2 and IP2(i)) or (x3 and IP3(i)) or (x4 and IP4(i)) or (x5 and IP5(i)) or (x6 and IP6(i))
								or (x7 and IP7(i)) or (x_bar and IP_def(i)) or (x8 and PC_in_R0(i));
	end generate n;
	
	rst_IF_ID<= x5 or x6 or x7;
	rst_ID_RR<= x5 or x6 or x7;
	rst_RR_EX<= x5 or x7;
	rst_EX_Mem<= x5 or x7;
	rst_Mem_WB<= x7;
	hx7<= x7;
	b_hazard_for_lm_sm<= x2 or x3 or x4 or x5 or x6 or x7;
	
end struct;