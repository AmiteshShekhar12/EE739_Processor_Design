library ieee;
use ieee.std_logic_1164.all;

entity overhead_dec is
	port (inst_in: in std_logic_vector(15 downto 0);
			op2, op1, op0, dest2, dest1, dest0: out std_logic_vector(3 downto 0)); --1010 is invalid operand
end entity;

architecture struct of overhead_dec is

	signal opcd: std_logic_vector(3 downto 0); --opcode
	signal opcd_s: std_logic_vector(15 downto 0); --output of a opcode decoder 
	signal s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, a, b: std_logic; 

begin

	opcd <= inst_in(15 downto 12);
	a<= inst_in(1); --C flag
	b<= inst_in(0); --Z flag
	
	opcd_s(0) <= not(opcd(3)) and not(opcd(2)) and not(opcd(1)) and not(opcd(0));
	opcd_s(1) <= not(opcd(3)) and not(opcd(2)) and not(opcd(1)) and (opcd(0)); -- opcode of ADA and similar add instructions
	opcd_s(2) <= not(opcd(3)) and not(opcd(2)) and (opcd(1)) and not(opcd(0));
	opcd_s(3) <= not(opcd(3)) and not(opcd(2)) and (opcd(1)) and (opcd(0));
	opcd_s(4) <= not(opcd(3)) and (opcd(2)) and not(opcd(1)) and not(opcd(0));
	opcd_s(5) <= not(opcd(3)) and (opcd(2)) and not(opcd(1)) and (opcd(0));
	opcd_s(6) <= not(opcd(3)) and (opcd(2)) and (opcd(1)) and not(opcd(0));
	opcd_s(7) <= not(opcd(3)) and (opcd(2)) and (opcd(1)) and (opcd(0));
	opcd_s(8) <= (opcd(3)) and not(opcd(2)) and not(opcd(1)) and not(opcd(0));
	opcd_s(9) <= (opcd(3)) and not(opcd(2)) and not(opcd(1)) and (opcd(0));
	opcd_s(10) <= (opcd(3)) and not(opcd(2)) and (opcd(1)) and not(opcd(0));
	opcd_s(11) <= (opcd(3)) and not(opcd(2)) and (opcd(1)) and (opcd(0)); --opcode of NOP
	opcd_s(12) <= (opcd(3)) and (opcd(2)) and not(opcd(1)) and not(opcd(0));
	opcd_s(13) <= (opcd(3)) and (opcd(2)) and not(opcd(1)) and (opcd(0));
	opcd_s(14) <= (opcd(3)) and (opcd(2)) and (opcd(1)) and not(opcd(0));
	opcd_s(15) <= (opcd(3)) and (opcd(2)) and (opcd(1)) and (opcd(0));
	
	s1<= opcd_s(1) or opcd_s(0) or opcd_s(2) or opcd_s(5) or opcd_s(8) or opcd_s(9) or opcd_s(10) or opcd_s(15);
	s2<= opcd_s(1) or opcd_s(2) or opcd_s(4) or opcd_s(5) or opcd_s(8) or opcd_s(9) or opcd_s(10) or opcd_s(13);
	s3<= (opcd_s(1) and a) or (opcd_s(2) and a and not(b));
	s4<= (opcd_s(1) and not(a) and b) or (opcd_s(2) and not(a) and b);
	s5<= opcd_s(8) or opcd_s(9) or opcd_s(10) or opcd_s(12) or opcd_s(13);
	
	op2(3)<= ('0' and s1) or ('1' and not(s1));
	op2(2)<= (inst_in(11) and s1) or ('0' and not(s1));
	op2(1)<= (inst_in(10) and s1) or ('1' and not(s1));
	op2(0)<= (inst_in(9) and s1) or ('0' and not(s1));
	
	op1(3)<= ('0' and s1) or ('1' and not(s1));
	op1(2)<= (inst_in(8) and s1) or ('0' and not(s1));
	op1(1)<= (inst_in(7) and s1) or ('1' and not(s1));
	op1(0)<= (inst_in(6) and s1) or ('0' and not(s1));
	
	op0(3)<= ('1' and s3) or ('1' and s4) or ('0' and s5) or ('1' and not(s3 or s4 or s5));
	op0(2)<= ('0' and s3) or ('0' and s4) or ('0' and s5) or ('0' and not(s3 or s4 or s5));
	op0(1)<= ('0' and s3) or ('0' and s4) or ('0' and s5) or ('1' and not(s3 or s4 or s5));
	op0(0)<= ('0' and s3) or ('1' and s4) or ('0' and s5) or ('0' and not(s3 or s4 or s5));
	
	s6<= opcd_s(1) or opcd_s(2);
	s7<= opcd_s(0);
	s8<= opcd_s(3) or opcd_s(4) or opcd_s(12) or opcd_s(13);
	s9<= opcd_s(1) or opcd_s(0);
	s10<= opcd_s(8) or opcd_s(9) or opcd_s(10) or opcd_s(12) or opcd_s(13) or opcd_s(15);
	s11<= opcd_s(1) or opcd_s(0) or opcd_s(2) ;
	
	dest2(3)<= ('0' and s6) or ('0' and s7) or ('0' and s8) or ('1' and not(s6 or s7 or s8));
	dest2(2)<= (inst_in(5) and s6) or (inst_in(8) and s7) or (inst_in(11) and s8) or ('0' and not(s6 or s7 or s8));
	dest2(1)<= (inst_in(4) and s6) or (inst_in(7) and s7) or (inst_in(10) and s8) or ('1' and not(s6 or s7 or s8));
	dest2(0)<= (inst_in(3) and s6) or (inst_in(6) and s7) or (inst_in(9) and s8) or ('0' and not(s6 or s7 or s8));
	
	dest1(3)<= ('1' and s9) or ('0' and s10) or ('1' and not(s9 or s10));
	dest1(2)<= ('0' and s9) or ('0' and s10) or ('0' and not(s9 or s10));
	dest1(1)<= ('0' and s9) or ('0' and s10) or ('1' and not(s9 or s10));
	dest1(0)<= ('0' and s9) or ('0' and s10) or ('0' and not(s9 or s10));
	
	dest0(3)<= ('1' and s11) or ('1' and not(s11));
	dest0(2)<= ('0' and s11) or ('0' and not(s11));
	dest0(1)<= ('0' and s11) or ('1' and not(s11));
	dest0(0)<= ('1' and s11) or ('0' and not(s11));
end struct;