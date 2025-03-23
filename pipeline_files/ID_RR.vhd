library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Flipflops.all;

entity ID_RR is
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
	  LM_bit_out : OUT std_logic
	  );
end entity ID_RR;


architecture Struct of ID_RR is

signal data_in, data_out : std_logic_vector(65 downto 0);
begin
   
	DF1: D_Flipflop port map (D => data_in(64),clock => Clk,preset =>  Rst_ID_RR , reset =>'0',enable => En_ID_RR,Q => data_out(64));
	DF2: D_Flipflop port map (D => data_in(63),clock => Clk,preset => '0' , reset => Rst_ID_RR,enable => En_ID_RR,Q => data_out(63));
	DF3: D_Flipflop port map (D => data_in(62),clock => Clk,preset => Rst_ID_RR , reset => '0',enable => En_ID_RR,Q => data_out(62));
	DF4: D_Flipflop port map (D => data_in(61),clock => Clk,preset => Rst_ID_RR , reset => '0',enable => En_ID_RR,Q => data_out(61));
	
reg_size : for i in 0 to 60 generate 
		DF0: D_Flipflop port map (D => data_in(i),clock => Clk,preset => '0' , reset => Rst_ID_RR,enable => En_ID_RR,Q => data_out(i));
end generate ;
	DF5 : D_Flipflop port map (D => data_in(65),clock => Clk,preset => '0' , reset => Rst_ID_RR,enable => En_ID_RR,Q => data_out(65));
	
	data_in(65) <= LM_bit_in;
	data_in(64 downto 49) <= instrn_in;
	data_in(48) <= Mem_W_in;
	data_in(47) <= IP_W_in;
	data_in(46 downto 45) <= ALU1_op_in;
	data_in(44) <= Zf_W_in;
	data_in(43) <= Cy_W_in;
	data_in(42 downto 40) <= RF_A1_in;
	data_in(39 downto 37) <= RF_A2_in;
	data_in(36 downto 34) <= RF_A3_in;
	data_in(33 downto 18) <= Imm_in;
	data_in(17 downto 2) <= PC_in;
	data_in(1) <= comp_en_in;
	data_in(0) <= add_cy_in;
	
	LM_bit_out <= data_out(65);
	instrn_out <= data_out(64 downto 49);
	Mem_W_out <= data_out(48);
	IP_W_out <= data_out(47);
	ALU1_op_out <= data_out(46 downto 45);
	Zf_W_out <= data_out(44);
	Cy_W_out <= data_out(43);
	RF_A1_out <= data_out(42 downto 40);
	RF_A2_out <= data_out(39 downto 37);
	RF_A3_out <= data_out(36 downto 34);
	Imm_out <= data_out(33 downto 18);
	PC_out <= data_out(17 downto 2);
	comp_en_out <= data_out(1);
	add_cy_out <= data_out(0);
	
end Struct;