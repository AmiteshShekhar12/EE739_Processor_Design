library ieee;
use ieee.std_logic_1164.all;

entity res_stn is
	port (clk, rst: in std_logic; --rst is same as rst of IF_ID
			I1, I2: in std_logic_vector(87 downto 0); --changed size to 87 from 63
			I_out1, I_out2: out std_logic_vector(87 downto 0);
			st_bit: out std_logic); 
end entity;

architecture struct of res_stn is

	component RS_decoder is
		port (clk, rst: in std_logic;
			bs, vl: in std_logic_vector(31 downto 0);
			self, I1, I2, R_ip1, R_ip2, bs_out, vl_out: out std_logic_vector(31 downto 0);
			st_out: out std_logic);
	end component;

	component DFF_65 is
		port (D: in std_logic_vector(89 downto 0);
				clk, rst: in std_logic;
				Q: out std_logic_vector(89 downto 0));
	end component;
	
	type memory_array is array (31 downto 0) of std_logic_vector (89 downto 0);
	
	signal D, Q : memory_array;
	
	signal bs, vl, self_s, I1_s, I2_s, R_ip1_s, R_ip2_s: std_logic_vector(31 downto 0);
	signal NOP: std_logic_vector(87 downto 0) := "1010101010101010101010101011000000000000000000000000000000000000000000000000000000000000";
	signal bs_out, vl_out: std_logic_vector(31 downto 0);
	signal st: std_logic;
	
begin

	idec: RS_decoder port map(clk, rst, bs, vl, self_s, I1_s, I2_s, R_ip1_s, R_ip2_s, bs_out, vl_out, st);
	
	n1: for i in 29 downto 0 generate
		n1_1: for j in 63 downto 0 generate
			D(i)(j) <= (self_s(i) and Q(i)(j)) or (I1_s(i) and I1(j)) or (I2_s(i) and I2(j)) or (R_ip1_s(i) and Q(i+1)(j)) or (R_ip2_s(i) and Q(i+2)(j));
		end generate;
		n1_2: for j in 89 downto 66 generate
			D(i)(j) <= (self_s(i) and Q(i)(j)) or (I1_s(i) and I1(j-2)) or (I2_s(i) and I2(j-2)) or (R_ip1_s(i) and Q(i+1)(j)) or (R_ip2_s(i) and Q(i+2)(j));
		end generate;
		D(i)(64) <= bs_out(i);
		D(i)(65) <= vl_out(i);
		bs(i) <= Q(i)(64);
		vl(i) <= Q(i)(65);
		dff1: DFF_65 port map(D=>D(i)(89 downto 0), clk=>clk, rst=>rst, Q=>Q(i)(89 downto 0));
	end generate;
	
	n2_1: for j in 63 downto 0 generate
		D(30)(j)<= (self_s(30) and Q(30)(j)) or (I1_s(30) and I1(j)) or (I2_s(30) and I2(j)) or (R_ip1_s(30) and Q(30+1)(j));
		D(31)(j)<= (self_s(31) and Q(31)(j)) or (I1_s(31) and I1(j)) or (I2_s(31) and I2(j));
	end generate;
	n2_2: for j in 89 downto 66 generate
		D(30)(j)<= (self_s(30) and Q(30)(j)) or (I1_s(30) and I1(j-2)) or (I2_s(30) and I2(j-2)) or (R_ip1_s(30) and Q(30+1)(j));
		D(31)(j)<= (self_s(31) and Q(31)(j)) or (I1_s(31) and I1(j-2)) or (I2_s(31) and I2(j-2));
	end generate;
	
	D(30)(64) <= bs_out(30);
	D(30)(65) <= vl_out(30);
	bs(30) <= Q(30)(64);
	vl(30) <= Q(30)(65);
	dff30: DFF_65 port map(D=>D(30)(89 downto 0), clk=>clk, rst=>rst, Q=>Q(30)(89 downto 0));
	
	D(31)(64) <= bs_out(31);
	D(31)(65) <= vl_out(31);
	bs(31) <= Q(31)(64);
	vl(31) <= Q(31)(65);
	dff31: DFF_65 port map(D=>D(31)(89 downto 0), clk=>clk, rst=>rst, Q=>Q(31)(89 downto 0));
	
	n3: for i in 87 downto 0 generate
		I_out1(i) <= (vl(0) and Q(0)(i)) or (not(vl(0)) and NOP(i));
		I_out2(i) <= (vl(0) and vl(1) and Q(1)(i)) or (not(vl(0) and vl(1)) and NOP(i));
	end generate;
	
	st_bit<= st;
	
end struct;