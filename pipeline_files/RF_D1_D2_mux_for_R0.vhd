library ieee;
use ieee.std_logic_1164.all;

entity RF_D1_D2_mux_for_R0 is
	port(RF_A1_ID_RR, RF_A2_ID_RR: in std_logic_vector(2 downto 0);
			op_ID_RR: in std_logic_vector(3 downto 0);
			RF_D1_in, RF_D2_in, PC_ID_RR_in: in std_logic_vector(15 downto 0);
			RF_D1_out, RF_D2_out: out std_logic_vector(15 downto 0));
end entity;


architecture struct of RF_D1_D2_mux_for_R0 is

	signal s1,s2,c1,c2,rf_a1_op,rf_a2_op : std_logic;
	signal op: std_logic_vector(3 downto 0);
	

begin

	op<= op_ID_RR;
					
   rf_a1_op<= (not(op(3)) and not(op(1))) or (not(op(2)) and op(1) and not(op(0))) 
					or (op(3) and op(2) and op(0)) or (op(3) and not(op(2)) and not(op(1)));

					
	rf_a2_op<= (not(op(3)) and not(op(1)) and op(0)) or (op(3) and not(op(2)) and not(op(1)))
   				or (not(op(2)) and op(1) and not(op(0)));
					
	c1<= not(RF_A1_ID_RR(2)) and not(RF_A1_ID_RR(1)) and not(RF_A1_ID_RR(0));
	c2<= not(RF_A2_ID_RR(2)) and not(RF_A2_ID_RR(1)) and not(RF_A2_ID_RR(0));
	
	s1<= c1 and rf_a1_op;
	s2<= c2 and rf_a2_op;
	
	n1: for i in 0 to 15 generate
		RF_D1_out(i)<= (s1 and PC_ID_RR_in(i)) or (not(s1) and RF_D1_in(i));
		RF_D2_out(i)<= (s2 and PC_ID_RR_in(i)) or (not(s2) and RF_D2_in(i));
	end generate n1;
	
end struct;