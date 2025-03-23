library ieee;
use ieee.std_logic_1164.all;

entity SE9 is
	port(IMM9_in: in std_logic_vector(8 downto 0); SE9_out: out std_logic_vector(15 downto 0));
end entity SE9;

architecture Struct of SE9 is
begin

	n1:for i in 0 to 8 generate
		SE9_out(i)<=Imm9_in(i);
	end generate n1;
	
	n2:for i in 9 to 15 generate
		SE9_out(i)<=Imm9_in(8);
	end generate n2;
end Struct;