library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Flipflops.all;

entity Cy_reg is
--update the Cy_reg to allow dual read/write
   port(Clk,Reset,Cy_W_1, Cy_W_2, Cy_in_1, Cy_in_2 : in std_logic;
		  Cy_out : out std_logic);
end entity Cy_reg;


architecture Struct of Cy_reg is
signal Cy_W, Cy_in : std_logic;
begin   

Cy_W <= Cy_W_1 xor Cy_W_2;
Cy_in <= Cy_in_1 when Cy_W_1 = '1' else
			Cy_in_2 when Cy_W_2 = '1' else
			'0'; --default case
			
--we have not considered the case when both pipelines would try to update carry flag at the same time. Ignore for now :(

DF0: D_Flipflop port map (D => Cy_in,clock => Clk,preset => '0' , reset => Reset,enable => Cy_W,Q => Cy_out);


	
end Struct;