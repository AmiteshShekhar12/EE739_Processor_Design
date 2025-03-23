library ieee;
use ieee.std_logic_1164.all;

entity MZE is
	port(IMM9 : in std_logic_vector(8 downto 0); MZE_out : out std_logic_vector(15 downto 0));
end entity;

architecture Struct of MZE is

begin

	n1: for i in 0 to 8 generate
		MZE_out(i)<=IMM9(i);
	end generate;
	
	n2: for i in 9 to 15 generate
		MZE_out(i)<='0';
	end generate;
end Struct;