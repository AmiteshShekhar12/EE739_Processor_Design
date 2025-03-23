library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Flipflops.all;

entity Cy_reg is
--update the Cy_reg to allow dual read/write
   port(Clk,Reset,Cy_W, Cy_in : in std_logic;
		  Cy_out : out std_logic);
end entity Cy_reg;


architecture Struct of Cy_reg is
begin
   
DF0: D_Flipflop port map (D => Cy_in,clock => Clk,preset => '0' , reset => Reset,enable => Cy_W,Q => Cy_out);
	
end Struct;