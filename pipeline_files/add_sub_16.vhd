library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity add_sub_16 is
	port(A,B: std_logic_vector(15 downto 0); M: in std_logic; Cout: out std_logic; S: out std_logic_vector(15 downto 0));
end entity add_sub_16;

architecture struct of add_sub_16 is
	component fulladder is
		port(A,B,Cin: in std_logic; sum,carry: out std_logic);
	end component fulladder;
	
	
	
	signal bs,cs: std_logic_vector(15 downto 0);
	
begin

	xor1: XOR_2 port map(A=>B(0), B=>M, Y=>bs(0));
	fa1: fulladder port map(A=>A(0), B=>bs(0), Cin=>M, sum=>S(0), carry=>cs(1));
	xor2: XOR_2 port map(A=>B(1), B=>M, Y=>bs(1));
	fa2: fulladder port map(A=>A(1), B=>bs(1), Cin=>cs(1), sum=>S(1), carry=>cs(2));
	xor3: XOR_2 port map(A=>B(2), B=>M, Y=>bs(2));
	fa3: fulladder port map(A=>A(2), B=>bs(2), Cin=>cs(2), sum=>S(2), carry=>cs(3));
	xor4: XOR_2 port map(A=>B(3), B=>M, Y=>bs(3));
	fa4: fulladder port map(A=>A(3), B=>bs(3), Cin=>cs(3), sum=>S(3), carry=>cs(4));
	xor5: XOR_2 port map(A=>B(4), B=>M, Y=>bs(4));
	fa5: fulladder port map(A=>A(4), B=>bs(4), Cin=>cs(4), sum=>S(4), carry=>cs(5));
	xor6: XOR_2 port map(A=>B(5), B=>M, Y=>bs(5));
	fa6: fulladder port map(A=>A(5), B=>bs(5), Cin=>cs(5), sum=>S(5), carry=>cs(6));
	

	xor7: XOR_2 port map(A=>B(6), B=>M, Y=>bs(6));
	fa7: fulladder port map(A=>A(6), B=>bs(6), Cin=>cs(6), sum=>S(6), carry=>cs(7));
	xor8: XOR_2 port map(A=>B(7), B=>M, Y=>bs(7));
	fa8: fulladder port map(A=>A(7), B=>bs(7), Cin=>cs(7), sum=>S(7), carry=>cs(8));
	xor9: XOR_2 port map(A=>B(8), B=>M, Y=>bs(8));
	fa9: fulladder port map(A=>A(8), B=>bs(8), Cin=>cs(8), sum=>S(8), carry=>cs(9));
	xor10: XOR_2 port map(A=>B(9), B=>M, Y=>bs(9));
	fa10: fulladder port map(A=>A(9), B=>bs(9), Cin=>cs(9), sum=>S(9), carry=>cs(10));
	xor11: XOR_2 port map(A=>B(10), B=>M, Y=>bs(10));
	fa11: fulladder port map(A=>A(10), B=>bs(10), Cin=>cs(10), sum=>S(10), carry=>cs(11));
	
	xor12: XOR_2 port map(A=>B(11), B=>M, Y=>bs(11));
	fa12: fulladder port map(A=>A(11), B=>bs(11), Cin=>cs(11), sum=>S(11), carry=>cs(12));
	xor13: XOR_2 port map(A=>B(12), B=>M, Y=>bs(12));
	fa13: fulladder port map(A=>A(12), B=>bs(12), Cin=>cs(12), sum=>S(12), carry=>cs(13));
	xor14: XOR_2 port map(A=>B(13), B=>M, Y=>bs(13));
	fa14: fulladder port map(A=>A(13), B=>bs(13), Cin=>cs(13), sum=>S(13), carry=>cs(14));
	xor15: XOR_2 port map(A=>B(14), B=>M, Y=>bs(14));
	fa15: fulladder port map(A=>A(14), B=>bs(14), Cin=>cs(14), sum=>S(14), carry=>cs(15));
	xor16: XOR_2 port map(A=>B(15), B=>M, Y=>bs(15));
	fa16: fulladder port map(A=>A(15), B=>bs(15), Cin=>cs(15), sum=>S(15), carry=>Cout);
	

end struct;
