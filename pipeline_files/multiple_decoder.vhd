library ieee;
use ieee.std_logic_1164.all;

entity multiple_decoder is
	port( inst : in std_logic_vector(15 downto 0);
			clk : in std_logic;
			LW_SW : out std_logic_vector(15 downto 0);
			LM_SM_updated : out std_logic_vector(15 downto 0);
			mult_cntrl : out std_logic := '0';
			mult_cntrl_bar : out std_logic := '0';
			lm_or_sm : out std_logic := '0'
		);
			
end entity multiple_decoder;


architecture struct of multiple_decoder is
	
	component priority_encoder_8_3 is
	port( x: in std_logic_vector(7 downto 0) ; y: out std_logic_vector(2 downto 0) := "000"; z : out std_logic);
	end component priority_encoder_8_3;
	
	component decoder_3_8 is
	port (x : in std_logic_vector(2 downto 0);
			y : out std_logic_vector(7 downto 0));
	end component decoder_3_8;
	
--	component counter is
--	port(clk, v : in std_logic;
--		  op_code : in std_logic_vector(3 downto 0);
--		  Imm6 : out std_logic_vector(5 downto 0) := "000000");
--	end component counter;
	
	component validation is
	port(imm8 : in std_logic_vector(7 downto 0); v : out std_logic);
	end component validation;
	
	
	component add_sub_6 is
	port(A,B: std_logic_vector(5 downto 0); M: in std_logic; Cout: out std_logic; S: out std_logic_vector(5 downto 0));
	end component add_sub_6;

	
	
	signal op_code	: std_logic_vector(3 downto 0);
	signal v,z : std_logic;
	signal Ra : std_logic_vector (2 downto 0);   -- same as Rb_W ,first target mem location in LM instruction
	signal Rb_W : std_logic_vector (2 downto 0);  --target mem_add of LW/SW instruction
	signal Ra_W : std_logic_vector (2 downto 0);  --target location of where to load the data from mem or from where in RF to store the data 
	signal decoder_out : std_logic_vector(7 downto 0);
	signal decoder_out_bar : std_logic_vector(7 downto 0);
	signal imm9_updated : std_logic_vector (8 downto 0);
	signal lm_sm : std_logic;
	signal imm6 : std_logic_vector (5 downto 0) := "000000";
	signal inst_reversed : std_logic_vector (7 downto 0);
	
	signal a1,a2,a3,a4,a5,a6,a7,a8 : std_logic_vector (5 downto 0);
	signal t0, t1, t2, t3, t4, t5, t6, t7 : std_logic_vector (5 downto 0) := "000000";
	signal c0 , c1, c2, c3, c4, c5, c6, c7,c8 : std_logic; --carry bit of the 7 six-bit adders used\
	
	
	begin
	op_code(3) <= inst(15);
	op_code(2) <= inst(14);
	op_code(1) <= inst(13);
	op_code(0) <= inst(12);
	lm_sm <= not(op_code(3)) and op_code(2) and op_code(1);
	lm_or_sm <= lm_sm;  --lm_or_sm is the output of multicoder which is used as the control signal of Mux 7
	mult_cntrl<= not(z) and v and lm_sm;
	mult_cntrl_bar <= z or not (v) or not(lm_sm);
	
	Ra(2) <= inst(11);
	Ra(1) <= inst(10);
	Ra(0) <= inst(9);
	
	Rb_W <= Ra;
	g4 : for i in 0 to 7 generate
		inst_reversed(i) <= inst(7-i);
	end generate g4;
	
	priority_encoder_1 : priority_encoder_8_3 port map(x => inst_reversed(7 downto 0), y => Ra_W, z => z);
	decoder_1 : decoder_3_8 port map ( x => Ra_W, y => decoder_out);
	
	validation1 : validation port map( imm8 => inst(7 downto 0), v => v);
	
	--counter1 : counter port map (clk => clk, v =>v, op_code => op_code, Imm6 => imm6);
	
	t7(0) <= inst(7);
	t6(0) <= inst(6);
	t5(0) <= inst(5);
	t4(0) <= inst(4);
	t3(0) <= inst(3);
	t2(0) <= inst(2);
	t1(0) <= inst(1);
	t0(0) <= inst(0);
	
	add_1 : add_sub_6 port map ( A => t7 , B => t6, M => '0' , Cout => c0, S => a1);
	add_2 : add_sub_6 port map ( A => t5 , B => t4, M => '0' , Cout => c1, S => a2);
	add_3 : add_sub_6 port map ( A => t3 , B => t2, M => '0' , Cout => c2, S => a3);
	add_4 : add_sub_6 port map ( A => t1 , B => t0, M => '0' , Cout => c3, S => a4);
	add_5 : add_sub_6 port map ( A => a1 , B => a2, M => '0' , Cout => c4, S => a5);
	add_6 : add_sub_6 port map ( A => a3 , B => a4, M => '0' , Cout => c5, S => a6);
	add_7 : add_sub_6 port map ( A => a5 , B => a6, M => '0' , Cout => c6, S => a7);
	sub_8 : add_sub_6 port map ( A => a7, B => "000001", M=> '1', Cout => c7, S => a8);
	
	g5 : for i in 0 to 4 generate
		imm6(i+1) <= a8(i);
	end generate g5;
	
	imm6(0) <= '0';
	
	g1 : for i in 0 to 7 generate
			decoder_out_bar(i) <= not(decoder_out(i));
	end generate g1;
	
	g2: for i in 0 to 7 generate
			imm9_updated(i) <= inst(i) and decoder_out_bar(i);
	end generate g2;
		
	imm9_updated(8) <= inst(8);
	
	LM_SM_updated(15 downto 12) <= inst(15 downto 12);
	LM_SM_updated(11 downto 9) <= Ra;
	LM_SM_updated(8 downto 0) <= imm9_updated;
	
	LW_SW(15) <= z;
	LW_SW(14) <= not(z);
	LW_SW(13) <= z;
	LW_SW(12) <= (inst(12) and not(z)) or z;
	
	
	LW_SW(11) <= Ra_W(2) and not(z);
	LW_SW(10) <= Ra_W(1) and not(z);
	LW_SW(9) <= Ra_W(0) and not(z);
	
	LW_SW(8) <= Rb_w(2) and not(z);
	LW_SW(7) <= Rb_w(1) and not(z);
	LW_SW(6) <= Rb_w(0) and not(z);
	
	
	
	g3: for i in 0 to 5 generate
		LW_SW(i) <= imm6(i) and not(z);
	end generate g3;
	
	
end struct;
	
	