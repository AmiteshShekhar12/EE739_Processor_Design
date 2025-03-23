library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Flipflops.all;

entity EX_Mem is
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
end entity EX_Mem;


architecture Struct of EX_Mem is

signal data_in, data_out : std_logic_vector(70 downto 0);
begin
   
reg_size1 : for i in 0 to 49 generate 
		DF0: D_Flipflop port map (D => data_in(i),clock => Clk,preset => '0' , reset => Rst_EX_Mem,enable => En_EX_Mem,Q => data_out(i));
end generate ;

	DF1: D_Flipflop port map (D => data_in(53),clock => Clk,preset => Rst_EX_Mem , reset =>'0',enable => En_EX_Mem,Q => data_out(53));
	DF2: D_Flipflop port map (D => data_in(52),clock => Clk,preset => '0' , reset => Rst_EX_Mem,enable => En_EX_Mem,Q => data_out(52));
	DF3: D_Flipflop port map (D => data_in(51),clock => Clk,preset => Rst_EX_Mem , reset => '0',enable => En_EX_Mem, Q => data_out(51));
	DF4: D_Flipflop port map (D => data_in(50),clock => Clk,preset => Rst_EX_Mem , reset => '0',enable => En_EX_Mem,Q => data_out(50));

	
reg_size2 : for i in 54 to 70 generate 
		DF6: D_Flipflop port map (D => data_in(i),clock => Clk,preset => '0' , reset => Rst_EX_Mem,enable => En_EX_Mem,Q => data_out(i));
end generate ;
	
	data_in(70) <= LM_bit_in;
	data_in(69 downto 54) <= Imm_in;
	data_in(53 downto 38) <= instrn_in;
	data_in(37) <= Mem_W_in;
	data_in(36) <= IP_W_in;
	data_in(35) <= RF_W_in;
	data_in(34 downto 19) <= RF_D2_in;
	data_in(18 downto 16) <= RF_A3_in;
	data_in(15 downto 0) <= ALU1_C_in;
	
	LM_bit_out <= data_out(70);
	Imm_out <= data_out(69 downto 54);
	instrn_out <= data_out(53 downto 38);
	Mem_W_out <= data_out(37);
	IP_W_out <= data_out(36);
	RF_W_out <= data_out(35);
	RF_D2_out <= data_out(34 downto 19);
	RF_A3_out <= data_out(18 downto 16);
	ALU1_C_out <= data_out(15 downto 0);
	
end Struct;