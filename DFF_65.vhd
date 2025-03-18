library ieee;
use ieee.std_logic_1164.all;

entity DFF_65 is
	port (D: in std_logic_vector(65 downto 0);
			clk, rst: in std_logic;
			Q: out std_logic_vector(65 downto 0));
end entity;

architecture struct of DFF_65 is

	component New_D_FF is 
		port (D, clock, reset:in std_logic;
				Q:out std_logic);
	end component New_D_FF;
	
begin

	n1: for i in 65 downto 0 generate
		idff: New_D_FF port map (D=>D(i), clock=>clk, reset=>rst, Q=>Q(i));	
	end generate;
	
end struct;