library ieee;
use ieee.std_logic_1164.all;

entity hopefully_last_hazard is
port (RF_D1 : IN std_logic_vector(15 downto 0);
		LM_bit_ID_RR, LM_bit_RR_Ex, clk, reset : IN std_logic;
		RF_D1_RR_EX_in : OUT std_logic_vector(15 downto 0)
		);
end entity hopefully_last_hazard;

architecture behav of hopefully_last_hazard is

	component Register16bit is
	port(Clk, Reset,Enable : in std_logic;
		  data_in : in std_logic_vector(15 downto 0);
		  data_out : out std_logic_vector(15 downto 0));
	end component Register16bit;
	
	signal x1, x2, C_i, R_W : std_logic;
	signal R_out : std_logic_vector(15 downto 0);
	
begin
	
	
	x1 <= LM_bit_ID_RR;
	x2 <= LM_bit_RR_EX;
	C_i <= (x1 and x2);
	R_W <= (x1 and not(x2));
	
	reg : Register16bit port map (clk, reset, R_W, RF_D1, R_out);
	
	--mux
	reg_size : for i in 0 to 15 generate
	RF_D1_RR_EX_in(i) <= (C_i and R_out(i)) or ((not C_i) and RF_D1(i));
	end generate;
	
end behav;