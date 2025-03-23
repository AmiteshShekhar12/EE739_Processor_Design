library ieee;
use ieee.std_logic_1164.all;

entity ALU1_A_mux is
	port(ALU1_A: out std_logic_vector(15 downto 0);
			opcode_RR_EX: in std_logic_vector(3 downto 0);
			PC_RR_EX, RF_D1_RR_EX: in std_logic_vector(15 downto 0));
end entity;


architecture struct of ALU1_A_mux is

	signal op: std_logic_vector(3 downto 0);
	signal ops: std_logic;
	
begin

	op<= opcode_RR_EX;
	ops<= (op(3) and op(2) and not(op(1)));
	n: for i in 15 downto 0 generate
		ALU1_A(i)<= (ops and PC_RR_EX(i)) or (not(ops) and RF_D1_RR_EX(i));
	end generate n;
	
end struct;