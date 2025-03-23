library ieee;
use ieee.std_logic_1164.all;

package reg is
  component Register16bit is
   port(Clk,Reset,Enable: in std_logic;
		  data_in : in std_logic_vector(15 downto 0);
		  data_out : out std_logic_vector(15 downto 0));
  end component Register16bit;
  
end package reg;

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Flipflops.all;

entity Register16bit is
port(Clk, Reset,Enable : in std_logic;
	  data_in : in std_logic_vector(15 downto 0);
	  data_out : out std_logic_vector(15 downto 0));
end entity;


architecture Struct of Register16bit is
begin
   
bit_16_2 : for i in 0 to 15 generate 
		DF0: D_Flipflop port map (D => data_in(i),clock => Clk,preset => '0' , reset => Reset,enable => Enable,Q => data_out(i));
end generate ;
	
end Struct;