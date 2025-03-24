library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Flipflops.all;

entity Mem_WB is
port(instrn_in, ALU1_C_in, Mem_Dout_in, Imm_in : IN std_logic_vector(15 downto 0);
	  RF_A3_in : IN std_logic_vector(2 downto 0);
	  IP_W_in, RF_W_in : IN std_logic;
	  Rst_Mem_WB, Clk, En_Mem_WB: IN std_logic;
	  op2_in, op1_in, op0_in, dest2_in, dest1_in, dest0_in: in std_logic_vector(3 downto 0); --1010 is invalid operand
	  instrn_out, ALU1_C_out, Mem_Dout_out, Imm_out : OUT std_logic_vector(15 downto 0);
	  RF_A3_out : OUT std_logic_vector(2 downto 0);
	  IP_W_out, RF_W_out : OUT std_logic;
	  op2_out, op1_out, op0_out, dest2_out, dest1_out, dest0_out: out std_logic_vector(3 downto 0) --1010 is invalid operand
	  );
end entity Mem_WB;


architecture Struct of Mem_WB is

signal data_in, data_out : std_logic_vector(92 downto 0);
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

reg_size3 : for i in 69 to 92 generate
	odd_gen: if (i mod 2 = 1) generate
		DF6: D_Flipflop port map (D => data_in(i),clock => Clk,preset => '0' , reset => Rst_Mem_WB,enable => En_Mem_WB,Q => data_out(i));
	end generate;
	
	even_gen: if (i mod 2 = 0) generate
		DF7: D_Flipflop port map (D => data_in(i),clock => Clk,preset => Rst_Mem_WB , reset => '0' ,enable => En_Mem_WB,Q => data_out(i));
	end generate;
end generate ;
	
	data_in(92 downto 89) <= dest0_in;
	data_in(88 downto 85) <= dest1_in;
	data_in(84 downto 81) <= dest2_in;
	data_in(80 downto 77) <= op0_in;
	data_in(76 downto 73) <= op1_in;
	data_in(72 downto 69) <= op2_in;
	data_in(68 downto 53) <= Imm_in;
	data_in(52 downto 37) <= instrn_in;
	data_in(36) <= IP_W_in;
	data_in(35) <= RF_W_in;
	data_in(34 downto 32) <= RF_A3_in;
	data_in(31 downto 16) <= Mem_Dout_in;
	data_in(15 downto 0) <= ALU1_C_in;
	
	dest0_out <= data_out(92 downto 89);
	dest1_out <= data_out(88 downto 85);
	dest2_out <= data_out(84 downto 81);
	op0_out <= data_out(80 downto 77);
	op1_out <= data_out(76 downto 73);
	op2_out <= data_out(72 downto 69);
	Imm_out <= data_out(68 downto 53);
	instrn_out <= data_out(52 downto 37);
	IP_W_out <= data_out(36);
	RF_W_out <= data_out(35);
	RF_A3_out <= data_out(34 downto 32);
	Mem_Dout_out <= data_out(31 downto 16);
	ALU1_C_out <= data_out(15 downto 0);
	
end Struct;