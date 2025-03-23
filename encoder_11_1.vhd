library ieee;
use ieee.std_logic_1164.all;
-- 
entity encoder_11_1 is
	port (A: in std_logic_vector(3 downto 0);
			D: in std_logic_vector(10 downto 0);
			Y: out std_logic);
end entity;

architecture struct of encoder_11_1 is

	signal S: std_logic_vector(10 downto 0);
	signal B: std_logic;
	
begin

	S(0) <= not(A(3)) and not(A(2)) and not(A(1)) and not(A(0)); -- 0000 corresponds to R0 of RF
	S(1) <= not(A(3)) and not(A(2)) and not(A(1)) and (A(0)); -- 0001 corresponds to R1 of RF
	S(2) <= not(A(3)) and not(A(2)) and (A(1)) and not(A(0)); -- 0010 corresponds to R2 of RF
	S(3) <= not(A(3)) and not(A(2)) and (A(1)) and (A(0)); -- 0011 corresponds to R3 of RF
	S(4) <= not(A(3)) and (A(2)) and not(A(1)) and not(A(0)); -- 0100 corresponds to R4 of RF
	S(5) <= not(A(3)) and (A(2)) and not(A(1)) and (A(0)); -- 0101 corresponds to R5 of RF
	S(6) <= not(A(3)) and (A(2)) and (A(1)) and not(A(0)); -- 0110 corresponds to R6 of RF
	S(7) <= not(A(3)) and (A(2)) and (A(1)) and (A(0)); -- 0111 corresponds to R7 of RF
	S(8) <= (A(3)) and not(A(2)) and not(A(1)) and not(A(0)); -- 1000 corresponds to Carry Reg
	s(9) <= (A(3)) and not(A(2)) and not(A(1)) and (A(0)); -- 1001 corresponds to Zero Reg
	s(10) <= (A(3)) and not(A(2)) and (A(1)) and not(A(0)); -- 1010 corresponds to Zero Reg
	
	--D(i) denotes the valid bit of ith opearnd in the scoreboard_register.
	
	B <= S(0) and D(0);
	
	n1: for i in 10 downto 1 generate
		B <= B or (S(i) and D(i));
	end generate;
	
	Y <= B; -- Y is the valid bit of operand A in scoreboard_register.
	
end struct;