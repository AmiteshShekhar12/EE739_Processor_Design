library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Flipflops.all;

entity IF_ID is
port(instrn_in, PC_in : IN std_logic_vector(15 downto 0);
	  Rst_IF_ID, Clk, En_IF_ID: IN std_logic;
	  instrn_out, PC_out : OUT std_logic_vector(15 downto 0));
end entity IF_ID;


architecture Struct of IF_ID is

signal data_in, data_out : std_logic_vector(31 downto 0);
begin
   
	DF1: D_Flipflop port map (D => data_in(31),clock => Clk,preset =>  Rst_IF_ID , reset =>'0',enable => En_IF_ID,Q => data_out(31));
	DF2: D_Flipflop port map (D => data_in(30),clock => Clk,preset => '0' , reset => Rst_IF_ID,enable => En_IF_ID,Q => data_out(30));
	DF3: D_Flipflop port map (D => data_in(29),clock => Clk,preset => Rst_IF_ID , reset => '0',enable => En_IF_ID,Q => data_out(29));
	DF4: D_Flipflop port map (D => data_in(28),clock => Clk,preset => Rst_IF_ID , reset => '0',enable => En_IF_ID,Q => data_out(28));
	
reg_size : for i in 0 to 27 generate 
		DF0: D_Flipflop port map (D => data_in(i),clock => Clk,preset => '0' , reset => Rst_IF_ID,enable => En_IF_ID,Q => data_out(i));
end generate ;
	
	data_in(15 downto 0) <= PC_in;
	data_in(31 downto 16) <= instrn_in;
	
	PC_out <= data_out(15 downto 0);
	instrn_out <= data_out(31 downto 16);
	
end Struct;