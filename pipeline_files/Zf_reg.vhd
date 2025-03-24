library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Flipflops.all;

entity Zf_reg is
   port(Clk,Reset,Zf_W_1, Zf_W_2, Zf_in_1, Zf_in_2 : in std_logic;
		  Zf_out : out std_logic);
end entity Zf_reg;


architecture Struct of Zf_reg is
signal Zf_W : std_logic;
signal Zf_in : std_logic;
begin

Zf_W <= Zf_W_1 xor Zf_W_2; 

Zf_in <= Zf_in_1 when Zf_W_1 = '1' else
			Zf_in_2 when Zf_W_2 = '1' else
			'0'; --default case


DF0: D_Flipflop port map (D => Zf_in,clock => Clk,preset => '0' , reset => Reset,enable => Zf_W,Q => Zf_out);
	
end Struct;