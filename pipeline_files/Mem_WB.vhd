library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Flipflops.all;

entity Mem_WB is
port(instrn_in, ALU1_C_in, Mem_Dout_in, Imm_in : IN std_logic_vector(15 downto 0);
	  RF_A3_in : IN std_logic_vector(2 downto 0);
	  IP_W_in, RF_W_in : IN std_logic;
	  Rst_Mem_WB, Clk, En_Mem_WB: IN std_logic;
	  instrn_out, ALU1_C_out, Mem_Dout_out, Imm_out : OUT std_logic_vector(15 downto 0);
	  RF_A3_out : OUT std_logic_vector(2 downto 0);
	  IP_W_out, RF_W_out : OUT std_logic
	  );
end entity Mem_WB;


architecture Struct of Mem_WB is

signal data_in, data_out : std_logic_vector(68 downto 0);
begin
   
reg_size1 : for i in 0 to 48 generate 
		DF0: D_Flipflop port map (D => data_in(i),clock => Clk,preset => '0' , reset => Rst_Mem_WB,enable => En_Mem_WB,Q => data_out(i));
end generate ;	
	
	DF1: D_Flipflop port map (D => data_in(52),clock => Clk,preset => Rst_Mem_WB , reset =>'0',enable => En_Mem_WB,Q => data_out(52));
	DF2: D_Flipflop port map (D => data_in(51),clock => Clk,preset => '0' , reset => Rst_Mem_WB,enable => En_Mem_WB,Q => data_out(51));
	DF3: D_Flipflop port map (D => data_in(50),clock => Clk,preset => Rst_Mem_WB , reset => '0',enable => En_Mem_WB,Q => data_out(50));
	DF4: D_Flipflop port map (D => data_in(49),clock => Clk,preset => Rst_Mem_WB , reset => '0',enable => En_Mem_WB,Q => data_out(49));

	
reg_size2 : for i in 53 to 68 generate 
		DF0: D_Flipflop port map (D => data_in(i),clock => Clk,preset => '0' , reset => Rst_Mem_WB,enable => En_Mem_WB,Q => data_out(i));
end generate ;
	
	data_in(68 downto 53) <= Imm_in;
	data_in(52 downto 37) <= instrn_in;
	data_in(36) <= IP_W_in;
	data_in(35) <= RF_W_in;
	data_in(34 downto 32) <= RF_A3_in;
	data_in(31 downto 16) <= Mem_Dout_in;
	data_in(15 downto 0) <= ALU1_C_in;
	
	Imm_out <= data_out(68 downto 53);
	instrn_out <= data_out(52 downto 37);
	IP_W_out <= data_out(36);
	RF_W_out <= data_out(35);
	RF_A3_out <= data_out(34 downto 32);
	Mem_Dout_out <= data_out(31 downto 16);
	ALU1_C_out <= data_out(15 downto 0);
	
end Struct;