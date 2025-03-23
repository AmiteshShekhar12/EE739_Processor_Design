library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Flipflops.all;

entity Zf_reg is
   port(Clk,Reset,Zf_W, Zf_in : in std_logic;
		  Zf_out : out std_logic);
end entity Zf_reg;


architecture Struct of Zf_reg is
begin
   
DF0: D_Flipflop port map (D => Zf_in,clock => Clk,preset => '0' , reset => Reset,enable => Zf_W,Q => Zf_out);
	
end Struct;