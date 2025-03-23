library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity fulladder is
	port(A,B,Cin: in std_logic; sum,carry: out std_logic);
end entity fulladder;

architecture struct of fulladder is

	signal S11,s1,s12,C1,C2 : std_logic;
begin
	x1: XOR_2 port map(A=>A, B=>B, Y=>S1);
	a1: NAND_2 port map (A=>A, B=>B, Y=>s11);
	a2: NAND_2 port map (A=>s11, B=>s11, Y=>C1);
	x2: XOR_2 port map(A=>S1, B=>Cin, Y=>sum);
	a3: NAND_2 port map (A=>S1, B=>Cin, Y=>s12);
	a4: NAND_2 port map (A=>s12, B=>s12, Y=>C2);
	or1: OR_2 port map (A => C1, B => C2, Y => carry);
	
end struct;