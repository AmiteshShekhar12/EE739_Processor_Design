library ieee;
use ieee.std_logic_1164.all;

entity score_board is
	port (clk, rst: in std_logic;
			op_I1, op_I2: in std_logic_vector(11 downto 0);
			dest_ID_RR1, dest_ID_RR2, dest_RR_EX1, dest_RR_EX2, dest_EX_Mem1, dest_EX_Mem2, dest_Mem_WB1, dest_Mem_WB2, dest_I1, dest_I2: in std_logic_vector(11 downto 0);
			val_I1, val_I2: out std_logic_vector(2 downto 0));
end entity;

architecture struct of score_board is

	component dec_4_16 is
		port (A: in std_logic_vector(3 downto 0);
				B: out std_logic_vector(10 downto 0));
	end component;
	
	component New_D_FF is
		port (D, clock, reset:in std_logic;
				Q:out std_logic);
	end component New_D_FF;

	component encoder_10_1 is
		port (A: in std_logic_vector(3 downto 0);
				D: in std_logic_vector(9 downto 0);
				Y: out std_logic);
	end component;
	
	signal a1, a2, x1, x2, x3, x4, x5, x6, y1, y2, y3, y4, y5, y6, y7, y8: std_logic_vector(10 downto 0);
	signal xn1, xn2, xn3, xn4, xn5, xn6, y9, y10, y11, y12, y13, y14, y15, y16, y17, y18, y19, y20, y21, y22, y23, y24: std_logic_vector(9 downto 0);
	signal make0, make1, finalD, Q: std_logic_vector(9 downto 0);
	
begin
	
	di1: dec_4_16 port map (dest_Mem_WB1(11 downto 8), x1);
	di2: dec_4_16 port map (dest_Mem_WB1(7 downto 4), x2);
	di3: dec_4_16 port map (dest_Mem_WB1(3 downto 0), x3);
	di4: dec_4_16 port map (dest_Mem_WB2(11 downto 8), x4);
	di5: dec_4_16 port map (dest_Mem_WB2(7 downto 4), x5);
	di6: dec_4_16 port map (dest_Mem_WB2(3 downto 0), x6);
	di7: dec_4_16 port map (dest_ID_RR1(11 downto 8), y1);
	di8: dec_4_16 port map (dest_ID_RR1(7 downto 4), y2);
	di9: dec_4_16 port map (dest_ID_RR1(3 downto 0), y3);
	di10: dec_4_16 port map (dest_ID_RR2(11 downto 8), y4);
	di11: dec_4_16 port map (dest_ID_RR2(7 downto 4), y5);
	di12: dec_4_16 port map (dest_ID_RR2(3 downto 0), y6);
	di13: dec_4_16 port map (dest_RR_EX1(11 downto 8), y7);
	di14: dec_4_16 port map (dest_RR_EX1(7 downto 4), y8);
	di15: dec_4_16 port map (dest_RR_EX1(3 downto 0), y9);
	di16: dec_4_16 port map (dest_RR_EX2(11 downto 8), y10);
	di17: dec_4_16 port map (dest_RR_EX2(7 downto 4), y11);
	di18: dec_4_16 port map (dest_RR_EX2(3 downto 0), y12);
	di19: dec_4_16 port map (dest_EX_Mem1(11 downto 8), y13);
	di20: dec_4_16 port map (dest_EX_Mem1(7 downto 4), y14);
	di21: dec_4_16 port map (dest_EX_Mem1(3 downto 0), y15);
	di22: dec_4_16 port map (dest_EX_Mem2(11 downto 8), y16);
	di23: dec_4_16 port map (dest_EX_Mem2(7 downto 4), y17);
	di24: dec_4_16 port map (dest_EX_Mem2(3 downto 0), y18);
	di25: dec_4_16 port map (dest_I1(11 downto 8), y19);
	di26: dec_4_16 port map (dest_I1(7 downto 4), y20);
	di27: dec_4_16 port map (dest_I1(3 downto 0), y21);
	di28: dec_4_16 port map (dest_I2(11 downto 8), y22);
	di29: dec_4_16 port map (dest_I2(7 downto 4), y23);
	di30: dec_4_16 port map (dest_I2(3 downto 0), y24);
	
	n1: for i in 9 downto 0 generate
		xn1(i) <= (not(x1(i)) and not(x1(10))) or (x1(10));
		xn2(i) <= (not(x2(i)) and not(x2(10))) or (x2(10));
		xn3(i) <= (not(x3(i)) and not(x3(10))) or (x3(10));
		xn4(i) <= (not(x4(i)) and not(x4(10))) or (x4(10));
		xn5(i) <= (not(x5(i)) and not(x5(10))) or (x5(10));
		xn6(i) <= (not(x6(i)) and not(x6(10))) or (x6(10));
		make0(i) <= x1(i) and x2(i) and x3(i) and x4(i) and x5(i) and x6(i);
		make1(i) <= y1(i) or y2(i) or y3(i) or y4(i) or y5(i) or y6(i) or y7(i) or y8(i) or y9(i) or y10(i) or y11(i) or y12(i) or y13(i) or y14(i) or y15(i) or y16(i) or y17(i) or y18(i) or y19(i) or y20(i) or y21(i) or y22(i) or y23(i) or y24(i);
	end generate;
	
	finalD <= make1 or (make0 and Q);
	
	n2: for i in 9 downto 0 generate
		dfi1: New_D_FF port map(finalD(i), clk, rst, Q(i));
	end generate;
	
	eni1: encoder_10_1 port map(op_I1(11 downto 8), Q, val_I1(2));
	eni2: encoder_10_1 port map(op_I1(7 downto 4), Q, val_I1(1));
	eni3: encoder_10_1 port map(op_I1(3 downto 0), Q, val_I1(0));
	eni4: encoder_10_1 port map(op_I2(11 downto 8), Q, val_I1(2));
	eni5: encoder_10_1 port map(op_I2(7 downto 4), Q, val_I1(1));
	eni6: encoder_10_1 port map(op_I2(3 downto 0), Q, val_I1(0));

end struct;