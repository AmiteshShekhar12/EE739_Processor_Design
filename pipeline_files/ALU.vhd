library ieee;
use ieee.std_logic_1164.all;

entity ALU is
	port(ALU_A, ALU_B: in std_logic_vector(15 downto 0);
			ALU_C: out std_logic_vector(15 downto 0));
end entity;


architecture struct of ALU is

	component add_sub_16 is
		port(A,B: std_logic_vector(15 downto 0); M: in std_logic; Cout: out std_logic; S: out std_logic_vector(15 downto 0));
	end component add_sub_16;
	signal carry: std_logic;
begin

	
	add_ins: add_sub_16 port map(A=>ALU_A, B=>ALU_B, M=>'0', Cout=>carry, S=>ALU_C);
	
end struct;