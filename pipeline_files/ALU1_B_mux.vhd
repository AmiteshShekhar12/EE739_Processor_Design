library ieee;
use ieee.std_logic_1164.all;

entity ALU1_B_mux is
	port(ALU1_B: out std_logic_vector(15 downto 0);
			opcode_RR_EX: in std_logic_vector(3 downto 0);
			Imm_RR_EX, COMP_out: in std_logic_vector(15 downto 0));
end entity;


architecture struct of ALU1_B_mux is

	signal op: std_logic_vector(3 downto 0);
	signal ops1, ops2: std_logic;
	signal imm: std_logic_vector(15 downto 0);
	
begin
	imm<= "0000000000000010";
	op<= opcode_RR_EX;
	ops1<= (op(3) and op(2) and not(op(1)));
	ops2<= (not(op(3)) and not(op(1)) and not(op(0))) or (not(op(3)) and op(2) and not(op(1)) and op(0));
	n: for i in 15 downto 0 generate
		ALU1_B(i)<= (ops1 and imm(i)) or (not(ops1) and not(ops2) and COMP_out(i)) or (ops2 and Imm_RR_EX(i));
	end generate n;
	
end struct;