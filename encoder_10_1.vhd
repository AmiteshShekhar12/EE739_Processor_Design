library ieee;
use ieee.std_logic_1164.all;

entity encoder_10_1 is
	port (A: in std_logic_vector(3 downto 0);
			D: in std_logic_vector(9 downto 0);
			Y: out std_logic);
end entity;

architecture struct of encoder_10_1 is

	signal S: std_logic_vector(9 downto 0);
	signal B: std_logic;
	
begin

	S(0) <= not(A(3)) and not(A(2)) and not(A(1)) and not(A(0));
	S(1) <= not(A(3)) and not(A(2)) and not(A(1)) and (A(0));
	S(2) <= not(A(3)) and not(A(2)) and (A(1)) and not(A(0));
	S(3) <= not(A(3)) and not(A(2)) and (A(1)) and (A(0));
	S(4) <= not(A(3)) and (A(2)) and not(A(1)) and not(A(0));
	S(5) <= not(A(3)) and (A(2)) and not(A(1)) and (A(0));
	S(6) <= not(A(3)) and (A(2)) and (A(1)) and not(A(0));
	S(7) <= not(A(3)) and (A(2)) and (A(1)) and (A(0));
	S(8) <= (A(3)) and not(A(2)) and not(A(1)) and not(A(0));
	s(9) <= (A(3)) and not(A(2)) and not(A(1)) and (A(0));
	
	B <= S(0) and D(0);
	
	n1: for i in 9 downto 1 generate
		B <= B or (S(i) and D(i));
	end generate;
	
end struct;