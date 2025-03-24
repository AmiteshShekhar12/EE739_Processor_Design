library ieee;
use ieee.std_logic_1164.all;
-- decoder reads the operand and activates the corresponding bit in the output vector, thereby indexing the operand
-- to the register's location.
entity dec_4_16 is
	port (A: in std_logic_vector(3 downto 0); -- operand
			B: out std_logic_vector(10 downto 0)); -- one hot vector to denote which operand has to be activated
end entity;

architecture struct of dec_4_16 is

begin

	B(0) <= not(A(3)) and not(A(2)) and not(A(1)) and not(A(0)); -- 0000 corresponds to R0 of RF
	B(1) <= not(A(3)) and not(A(2)) and not(A(1)) and (A(0)); -- 0001 corresponds to R1 of RF
	B(2) <= not(A(3)) and not(A(2)) and (A(1)) and not(A(0)); -- 0010 corresponds to R2 of RF
	B(3) <= not(A(3)) and not(A(2)) and (A(1)) and (A(0)); -- 0011 corresponds to R3 of RF
	B(4) <= not(A(3)) and (A(2)) and not(A(1)) and not(A(0)); -- 0100 corresponds to R4 of RF
	B(5) <= not(A(3)) and (A(2)) and not(A(1)) and (A(0)); -- 0101 corresponds to R5 of RF
	B(6) <= not(A(3)) and (A(2)) and (A(1)) and not(A(0)); -- 0110 corresponds to R6 of RF
	B(7) <= not(A(3)) and (A(2)) and (A(1)) and (A(0)); -- 0111 corresponds to R7 of RF
	B(8) <= (A(3)) and not(A(2)) and not(A(1)) and not(A(0)); -- 1000 corresponds to Carry register C
	B(9) <= (A(3)) and not(A(2)) and not(A(1)) and (A(0)); -- 1001 corresponds to Zero register Z
	B(10) <= (A(3)) and not(A(2)) and (A(1)) and not(A(0)); -- 1010 corresponds to invalid operand
	
end struct;