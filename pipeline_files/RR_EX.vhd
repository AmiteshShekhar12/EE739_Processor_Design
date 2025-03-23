library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Flipflops.all;

entity RR_EX is
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
end entity RR_EX;


architecture Struct of RR_EX is

signal data_in, data_out : std_logic_vector(91 downto 0);
begin
   
	DF1: D_Flipflop port map (D => data_in(90),clock => Clk,preset => Rst_RR_EX , reset =>'0',enable => En_RR_EX,Q => data_out(90));
	DF2: D_Flipflop port map (D => data_in(89),clock => Clk,preset => '0' , reset => Rst_RR_EX,enable => En_RR_EX,Q => data_out(89));
	DF3: D_Flipflop port map (D => data_in(88),clock => Clk,preset => Rst_RR_EX , reset => '0',enable => En_RR_EX,Q => data_out(88));
	DF4: D_Flipflop port map (D => data_in(87),clock => Clk,preset => Rst_RR_EX , reset => '0',enable => En_RR_EX,Q => data_out(87));

	
reg_size : for i in 0 to 86 generate 
	DF1: D_Flipflop port map (D => data_in(i),clock => Clk,preset => '0' , reset =>Rst_RR_EX,enable => En_RR_EX,Q => data_out(i));
end generate ;
	DF5: D_Flipflop port map (D => data_in(91),clock => Clk,preset => '0' , reset =>Rst_RR_EX,enable => En_RR_EX,Q => data_out(91));

	
	data_in(91) <= LM_bit_in;
	data_in(90 downto 75) <= instrn_in;
	data_in(74) <= Mem_W_in;
	data_in(73) <= IP_W_in;
	data_in(72 downto 71) <= ALU1_op_in;
	data_in(70) <= Zf_W_in;
	data_in(69) <= Cy_W_in;
	data_in(68 downto 53) <= RF_D1_in;
	data_in(52 downto 37) <= RF_D2_in;
	data_in(36 downto 34) <= RF_A3_in;
	data_in(33 downto 18) <= Imm_in;
	data_in(17 downto 2) <= PC_in;
	data_in(1) <= comp_en_in;
	data_in(0) <= add_cy_in;
	
	LM_bit_out <= data_out(91);
	instrn_out <= data_out(90 downto 75);
	Mem_W_out <= data_out(74);
	IP_W_out <= data_out(73);
	ALU1_op_out <= data_out(72 downto 71);
	Zf_W_out <= data_out(70);
	Cy_W_out <= data_out(69);
	RF_D1_out <= data_out(68 downto 53);
	RF_D2_out <= data_out(52 downto 37);
	RF_A3_out <= data_out(36 downto 34);
	Imm_out <= data_out(33 downto 18);
	PC_out <= data_out(17 downto 2);
	comp_en_out <= data_out(1);
	add_cy_out <= data_out(0);
	
end Struct;