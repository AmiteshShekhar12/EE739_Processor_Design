library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.ALL;
use ieee.numeric_std.all;

entity score_card is
	port (clk, rst: in std_logic;
			opA0, opA1, opA2, opA3, dsA0, dsA1: in std_logic_vector(2 downto 0);
			chA0, chA1: in std_logic_vector(2 downto 0);
			r0, r1, r2, r3: out std_logic);
end entity;

architecture struct of score_card is
	
	component New_D_FF is 
		port (D, clock, reset:in std_logic;
				Q:out std_logic);		
	end component New_D_FF;
	
	signal valid : std_logic_vector(7 downto 0) := "00000000";
	signal s00, s10, s20, s30, s40, s50, s60, s70: std_logic;
	signal s01, s11, s21, s31, s41, s51, s61, s71: std_logic;
	signal D: std_logic_vector(7 downto 0);
	
begin
 
	r0 <= valid(to_integer(unsigned(opA0)));
	r1 <= valid(to_integer(unsigned(opA1)));
	r2 <= valid(to_integer(unsigned(opA2)));
	r3 <= valid(to_integer(unsigned(opA3)));
	
	d0: New_D_FF port map(D=>D(0), clock=>clk, reset=>rst, Q=>valid(0));
	d1: New_D_FF port map(D=>D(1), clock=>clk, reset=>rst, Q=>valid(1));
	d2: New_D_FF port map(D=>D(2), clock=>clk, reset=>rst, Q=>valid(2));
	d3: New_D_FF port map(D=>D(3), clock=>clk, reset=>rst, Q=>valid(3));
	d4: New_D_FF port map(D=>D(4), clock=>clk, reset=>rst, Q=>valid(4));
	d5: New_D_FF port map(D=>D(5), clock=>clk, reset=>rst, Q=>valid(5));
	d6: New_D_FF port map(D=>D(6), clock=>clk, reset=>rst, Q=>valid(6));
	d7: New_D_FF port map(D=>D(7), clock=>clk, reset=>rst, Q=>valid(7));
	
	s00 <= (not(dsA0(2)) and not(dsA0(1)) and not(dsA0(0))) or (not(dsA1(2)) and not(dsA1(1)) and not(dsA1(0)));
	s01 <= (not(chA0(2)) and not(chA0(1)) and not(chA0(0))) or (not(chA1(2)) and not(chA1(1)) and not(chA1(0)));
	D(0) <= (not(s00 or s01) and valid(0)) or s00;
	
	s10 <= (not(dsA0(2)) and not(dsA0(1)) and (dsA0(0))) or (not(dsA1(2)) and not(dsA1(1)) and (dsA1(0)));
	s11 <= (not(chA0(2)) and not(chA0(1)) and (chA0(0))) or (not(chA1(2)) and not(chA1(1)) and (chA1(0)));
	D(1) <= (not(s10 or s11) and valid(1)) or s10;
	
	s20 <= (not(dsA0(2)) and (dsA0(1)) and not(dsA0(0))) or (not(dsA1(2)) and (dsA1(1)) and not(dsA1(0)));
	s21 <= (not(chA0(2)) and (chA0(1)) and not(chA0(0))) or (not(chA1(2)) and (chA1(1)) and not(chA1(0)));
	D(2) <= (not(s20 or s21) and valid(2)) or s20;
	
	s30 <= (not(dsA0(2)) and (dsA0(1)) and (dsA0(0))) or (not(dsA1(2)) and (dsA1(1)) and (dsA1(0)));
	s31 <= (not(chA0(2)) and (chA0(1)) and (chA0(0))) or (not(chA1(2)) and (chA1(1)) and (chA1(0)));
	D(3) <= (not(s30 or s31) and valid(3)) or s30;
	
	s40 <= ((dsA0(2)) and not(dsA0(1)) and not(dsA0(0))) or ((dsA1(2)) and not(dsA1(1)) and not(dsA1(0)));
	s41 <= ((chA0(2)) and not(chA0(1)) and not(chA0(0))) or ((chA1(2)) and not(chA1(1)) and not(chA1(0)));
	D(4) <= (not(s40 or s41) and valid(4)) or s40;
	
	s50 <= ((dsA0(2)) and not(dsA0(1)) and (dsA0(0))) or ((dsA1(2)) and not(dsA1(1)) and (dsA1(0)));
	s51 <= ((chA0(2)) and not(chA0(1)) and (chA0(0))) or ((chA1(2)) and not(chA1(1)) and (chA1(0)));
	D(5) <= (not(s50 or s51) and valid(5)) or s50;
	
	s60 <= ((dsA0(2)) and (dsA0(1)) and not(dsA0(0))) or ((dsA1(2)) and (dsA1(1)) and not(dsA1(0)));
	s61 <= ((chA0(2)) and (chA0(1)) and not(chA0(0))) or ((chA1(2)) and (chA1(1)) and not(chA1(0)));
	D(6) <= (not(s60 or s61) and valid(6)) or s60;
	
	s70 <= ((dsA0(2)) and (dsA0(1)) and (dsA0(0))) or ((dsA1(2)) and (dsA1(1)) and (dsA1(0)));
	s71 <= ((chA0(2)) and (chA0(1)) and (chA0(0))) or ((chA1(2)) and (chA1(1)) and (chA1(0)));
	D(7) <= (not(s70 or s71) and valid(7)) or s70;
	
	
end struct;

	