library ieee;
use ieee.std_logic_1164.all;

entity SE6 is
	port(IMM6_in: in std_logic_vector(5 downto 0); SE6_out: out std_logic_vector(15 downto 0));
end entity SE6;

architecture Struct of SE6 is
begin

	n1:for i in 0 to 5 generate
		SE6_out(i)<=Imm6_in(i);
	end generate n1;
	
	n2:for i in 6 to 15 generate
		SE6_out(i)<=Imm6_in(5);
	end generate n2;
end Struct;