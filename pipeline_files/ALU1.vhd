library ieee;
use ieee.std_logic_1164.all;

entity ALU1 is
	port(ALU1_A, ALU1_B: in std_logic_vector(15 downto 0);
			ALU1_ctrl: in std_logic_vector(1 downto 0);
			Cy_in: in std_logic;
			Add_Cy: in std_logic;
			ALU1_C: out std_logic_vector(15 downto 0);
			ALU1_Cy, ALU1_Z: out std_logic);
end entity;


architecture struct of ALU1 is

	component add_sub_16 is
		port(A,B: std_logic_vector(15 downto 0); M: in std_logic; Cout: out std_logic; S: out std_logic_vector(15 downto 0));
	end component add_sub_16;
	
	signal add1, add2, sub, nand1, output_C, immm: std_logic_vector(15 downto 0);
	signal addc1, subc, add_s, sub_s, nand1_s, addc2_i, addc2, zs: std_logic;
begin
	immm(15 downto 1)<="000000000000000";
	immm(0)<=Cy_in;
	
	add_ins: add_sub_16 port map(A=>ALU1_A, B=>ALU1_B, M=>'0', Cout=>addc1, S=>add1);
	add_ins1: add_sub_16 port map(A=>add1, B=>Immm, M=>'0', Cout=>addc2_i, S=>add2);
	sub_ins: add_sub_16 port map(A=>ALU1_A, B=>ALU1_B, M=>'1', Cout=>subc, S=>sub);
	nand1<= not(ALU1_A and ALU1_B);
	addc2<= addc2_i or addc1;
	add_s<= not(ALU1_ctrl(1)) and not(ALU1_ctrl(0));
	sub_s<= ALU1_ctrl(1) and not(ALU1_ctrl(0));
	nand1_s<= not(ALU1_ctrl(1)) and ALU1_ctrl(0);
	
	n: for i in 15 downto 0 generate
		output_C(i)<= (add_s and Add_Cy and add2(i)) or (add_s and not(Add_Cy) and add1(i)) or (sub_s and sub(i)) or (nand1_s and nand1(i));
	end generate n;
	ALU1_Z<= zs;
	zs<=not(output_C(15) or output_C(14) or output_C(13) or output_C(12) or output_C(11) or output_C(10) or output_C(9) or output_C(8) or output_C(7) or output_C(6) or output_C(5) or output_C(4) or output_C(3) or output_C(2) or output_C(1) or output_C(0));
	ALU1_Cy<= (add_s and Add_Cy and addc2) or (add_s and not(Add_Cy) and addc1) or (sub_s and not(subc) and not(zs));
	ALU1_C<= output_C;
end struct;