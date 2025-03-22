library ieee;
use ieee.std_logic_1164.all;

entity RS_decoder is
	port (clk, rst: in std_logic;
			bs, vl: in std_logic_vector(31 downto 0);
			self, I1, I2, R_ip1, R_ip2, bs_out, vl_out: out std_logic_vector(31 downto 0);
			st_out: out std_logic);
end entity;

architecture struct of RS_decoder is
	
	component New_D_FF is 
	port (D, clock, reset:in std_logic;
			Q:out std_logic);		
	end component New_D_FF;
	
	signal st31,st30, st29, st: std_logic;
	signal b, v, I1_s, I2_s, R_ip1_s, R_ip2_s, self_s: std_logic_vector(31 downto 0);
	
begin
	
	b <= bs;
	v <= vl;
	I1 <= I1_s;
	I2 <= I2_s;
	R_ip1 <= R_ip1_s;
	R_ip2 <= R_ip2_s;
	self <= self_s;
	st_out <= st;
	st <= st31 or st30 or st29;
	
--	I1_s(31) <= ((not(b(31)) and b(30)) and (not(v(0)))) or ((b(31)) and (not(v(1)) and v(0)));
--	I2_s(31) <= ((not(b(30)) and b(29)) and (not(v(0)))) or ((not(b(31)) and b(30)) and (not(v(1)) and v(0))) or ((b(31)) and (v(1) and v(0)));
--	R_ip1_s(31) <= '0';
--	R_ip2_s(31) <= '0';
--	self_s(31) <= not(I1_s(31) or I2_s(31) or R_ip1_s(31) or R_ip2_s(31));
--	bs_out(31) <= ((not(b(30)) and b(29)) and (not(v(0)))) or ((not(b(31)) and b(30)) and (not(v(0)) or not(v(1)))) or (bs(31) and (not(st1) or st));


	I1_s(31) <= '0'; 
	I2_s(31) <= (not(b(31)) and not(b(30)) and b(29) and not(v(0))) or 
					(not(b(31)) and b(30) and b(29) and not(v(1)) and v(0)) or
					(b(31) and b(30) and b(29) and v(0) and v(1));
	R_ip1_s(31) <= '0';
	R_ip2_s(31) <= '0';
	self_s(31) <= (not b(29)) or 
              (not b(30) and b(29) and v(0)) or 
              (not b(31) and b(30) and ((v(1) and v(0)) or not v(0))) or
              (b(31) and ((v(1) and not v(0)) or not v(1)));
	bs_out(31) <= (not(b(30)) and b(29) and not(v(0))) or (not(b(31)) and b(30) and not(v(1)) and v(0)) or (b(31) and (not(v(0)) or v(1)));
	st31 <= (not(b(31)) and b(30) and not(v(0))) or 
	        (b(31) and ( (v(1) and not(v(0))) or not(v(1)) ) );
	
	
--	I1_s(30) <= ((not(b(30)) and b(29)) and (not(v(0)))) or ((not(b(31)) and b(30)) and (not(v(1)) and v(0))) or ((b(31)) and (v(1) and v(0)));
--	I2_s(30) <= ((not(b(29)) and b(28)) and (not(v(0)))) or ((not(b(30)) and b(29)) and (not(v(1)) and v(0))) or ((not(b(31)) and b(30)) and (v(1) and v(0)));
--	R_ip1_s(30) <= ((b(31)) and (not(v(1)) and v(0)));
--	R_ip2_s(30) <= '0';
--	self_s(30) <= not(I1_s(30) or I2_s(30) or R_ip1_s(30) or R_ip2_s(30));
--	bs_out(30) <= ((not(b(29)) and b(28)) and (not(v(0)))) or ((not(b(30)) and b(29)) and (not(v(0)) or not(v(1)))) or (bs(30) and (not(st1) or st));

	I1_s(30) <= (not(v(0)) and b(28) and b(29) and not(b(30))) or (v(0) and not(v(1)) and b(28) and b(29) and b(30) and not(b(31))) or 
					(v(0) and v(1) and b(28) and b(29) and b(30) and b(31));
					
	I2_s(30) <= (not(v(0)) and b(28) and not(b(29))) or (v(0) and not(v(1)) and b(28) and b(29) and not(b(30))) or
					(v(0) and v(1) and b(28) and b(29) and b(30) and not(b(31)));
					
	R_ip1_s(30) <= (v(0) and not(v(1)) and b(28) and b(29) and b(30) and b(31));
	R_ip2_s(30) <= '0';
	self_s(30) <= (b(28)) or (v(0) and b(28) and not(b(29))) or (v(0) and v(1) and b(28) and b(29) and not(b(30))) or
						(not(v(0)) and b(28) and b(29) and b(30) and not(b(31))) or (not(v(0)) and v(1) and b(28) and b(29) and b(30) and b(31));
						
	bs_out(30) <= (not(v(0)) and b(28) and not(b(29))) or 
					  (b(29) and not(b(30)) and (not(v(1)) or (v(1) and not(v(0))))) or 
					  (b(30));
	st30 <= (not(v(0)) and b(30) and not(b(31))) or 
			  (b(31) and (not(v(1)) or (v(1) and not(v(0)))));
						

	I1_s(29) <= ((not(b(29)) and b(28) and b(27)) and (not(v(0)))) or ((not(b(30)) and b(29) and b(28) and b(27)) and (not(v(1)) and v(0))) or ((not(b(31)) and b(30) and b(29) and b(28) and b(27)) and (v(1) and v(0)));
	I2_s(29) <= ((not(b(29-1)) and b(29-2)) and (not(v(0)))) or ((not(b(29)) and b(29-1)) and (not(v(1)) and v(0))) or ((not(b(29+1)) and b(29)) and (v(1) and v(0)));
	R_ip1_s(29) <= ((not(b(29+2)) and b(29+1)) and (not(v(1)) and v(0))) or ((b(29+2)) and (not(v(1)) and v(0)));
	R_ip2_s(29) <= b(29+2) and v(1) and v(0);
	self_s(29) <= not(I1_s(29) or I2_s(29) or R_ip1_s(29) or R_ip2_s(29));
	bs_out(29) <= ((not(b(29-1)) and b(29-2)) and (not(v(0)))) or ((not(b(29)) and b(29-1)) and ((not(v(0)) and v(1)) or not(v(1)))) or (b(29));
	st29 <= (not(v(0)) and b(30) and not(b(31))) or (b(31) and (not(v(1)) or (v(1) and not(v(0)))));
	
	
	n1: for i in 28 downto 2 generate
		
		I1_s(i) <= ((not(b(i)) and b(i-1)) and (not(v(0)))) or ((not(b(i+1)) and b(i)) and (not(v(1)) and v(0))) or ((not(b(i+2)) and b(i+1)) and (v(1) and v(0))); -- verified
		I2_s(i) <= ((not(b(i-1)) and b(i-2)) and (not(v(0)))) or ((not(b(i)) and b(i-1)) and (not(v(1)) and v(0))) or ((not(b(i+1)) and b(i)) and (v(1) and v(0))); --verified
		R_ip1_s(i) <= ((not(b(i+2)) and b(i+1)) and (not(v(1)) and v(0))) or ((b(i+2)) and (not(v(1)) and v(0))); --verified
		R_ip2_s(i) <= b(i+2) and v(1) and v(0); --verified
		self_s(i) <= not(I1_s(i) or I2_s(i) or R_ip1_s(i) or R_ip2_s(i)); --verified
		--bs_out(i) <= ((not(b(i-1)) and b(i-2)) and (not(v(0)))) or ((not(b(i)) and b(i-1)) and (not(v(0)) or not(v(1)))) or bs(i);
		bs_out(i) <= (not(b(i)) and not(b(i-1)) and b(i-2) and not(v(0))) or (not(b(i)) and b(i-1) and b(i-2) and (not(v(1)) or (v(1) and not(v(0))))) or (b(i)); --verified
	
	end generate;
	
	I1_s(1) <= ((not(b(1)) and b(0)) and (not(v(0)))) or 
				  ((not(b(2)) and b(1) and (not(v(1)) and v(0)))) or 
				  ((not(b(3)) and b(2)) and (v(1) and v(0))); --verified
	I2_s(1) <= not(b(0)) or ((not(b(1)) and b(0)) and (v(0))) or ((not(b(2)) and b(1)) and (v(1) and v(0))); --verified
	R_ip1_s(1) <= b(2) and b(1) and b(0) and not(v(1)) and v(0); --verified
	R_ip2_s(1) <= b(3) and b(2) and b(1) and b(0) and v(1) and v(0); --verified
	self_s(1) <= not(I1_s(1) or I2_s(1) or R_ip1_s(1) or R_ip2_s(1)); --verified
	bs_out(1) <= '1'; --verified
	
	I1_s(0) <= not(b(0)) or ((not(b(1)) and b(0)) and (v(0))) or ((not(b(2)) and b(1)) and (v(1) and v(0))); --verified
	I2_s(0) <= '0'; --verified
	R_ip1_s(0) <= b(1) and b(0) and not(v(1)) and v(0); --verified
	R_ip2_s(0) <= b(2) and b(1) and b(0) and v(1) and v(0); --verified
	self_s(0) <= not(I1_s(0) or I2_s(0) or R_ip1_s(0) or R_ip2_s(0)); --verified
	bs_out(0) <= '1'; --verified
	
  --st <= (b(31) and (not(v(1)) or not(v(0)))) or (not(b(31)) and b(30) and not(v(0)));
  --d1: New_D_FF port map(st, clk, rst, st1);
	
	vl_out<="00000000000000000000000000000000";
end struct;