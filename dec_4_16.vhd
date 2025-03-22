library ieee;
use ieee.std_logic_1164.all;

entity dec_4_16 is
	port (A: in std_logic_vector(3 downto 0);
			B: out std_logic_vector(10 downto 0));
end entity;

architecture struct of dec_4_16 is

begin

	B(0) <= not(A(3)) and not(A(2)) and not(A(1)) and not(A(0));
	B(1) <= not(A(3)) and not(A(2)) and not(A(1)) and (A(0));
	B(2) <= not(A(3)) and not(A(2)) and (A(1)) and not(A(0));
	B(3) <= not(A(3)) and not(A(2)) and (A(1)) and (A(0));
	B(4) <= not(A(3)) and (A(2)) and not(A(1)) and not(A(0));
	B(5) <= not(A(3)) and (A(2)) and not(A(1)) and (A(0));
	B(6) <= not(A(3)) and (A(2)) and (A(1)) and not(A(0));
	B(7) <= not(A(3)) and (A(2)) and (A(1)) and (A(0));
	B(8) <= (A(3)) and not(A(2)) and not(A(1)) and not(A(0));
	B(9) <= (A(3)) and not(A(2)) and not(A(1)) and (A(0));
	B(10) <= (A(3)) and not(A(2)) and (A(1)) and not(A(0));
	
end struct;