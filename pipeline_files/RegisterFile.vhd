library ieee;
use ieee.std_logic_1164.all;

package regfile is
  component RegisterFile is
		port(A1, A2, A3 : IN std_logic_vector(2 downto 0);
				D1, D2 : OUT std_logic_vector(15 downto 0);
				D3 : IN std_logic_vector(15 downto 0);
				IP_W : IN std_logic;
				PC_in : IN std_logic_vector(15 downto 0);
				PC_out : OUT std_logic_vector(15 downto 0);
		      RF_W, Clk, Reset : IN std_logic
--			  R0_out, R1_out, R2_out,R3_out,R4_out,R5_out,R6_out,R7_out : OUT std_logic_vector(15 downto 0)
		  );
	end component RegisterFile;
  
end package regfile;

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.mux_16_2.all;
use work.mux_16_8.all;
use work.reg.all;

entity RegisterFile is
		port(A1, A2, A3 : IN std_logic_vector(2 downto 0);
				D1, D2 : OUT std_logic_vector(15 downto 0);
				D3 : IN std_logic_vector(15 downto 0);
				IP_W : IN std_logic;
				PC_in : IN std_logic_vector(15 downto 0);
				PC_out : OUT std_logic_vector(15 downto 0);
		      RF_W, Clk, Reset : IN std_logic
--			  R0_out, R1_out, R2_out,R3_out,R4_out,R5_out,R6_out,R7_out : OUT std_logic_vector(15 downto 0)
		  );
end entity RegisterFile;


architecture behav of RegisterFile is
--	component demux8_16 is
--		port (En : IN std_logic;
--				S : IN std_logic_vector(2 downto 0);
--				D : IN std_logic_vector(15 downto 0);
--				Y0, Y1, Y2, Y3, Y4, Y5, Y6, Y7 : OUT std_logic_vector(15 downto 0));
--	end component demux8_16;


 signal B,B0,B1,B2,B3,B4,B5,B6,B7: std_logic_vector (15 downto 0);
 signal E0,E1,E2,E3,E4,E5,E6,E7: std_logic;

begin
-- DEMUX PROCESS STARTS

E0 <=((((not A3(2)) and (not A3(1)) and (not A3(0)) and RF_W)) or Reset or IP_W);
E1 <=((((not A3(2)) and (not A3(1)) and (A3(0))) and RF_W) or Reset) ;
E2 <= ((((not A3(2)) and (A3(1)) and (not A3(0))) and RF_W) or Reset);
E3 <= ((((not A3(2)) and (A3(1)) and (A3(0))) and RF_W) or Reset);
E4 <= ((((A3(2)) and (not A3(1)) and (not A3(0))) and RF_W) or Reset);
E5 <= ((((A3(2)) and (not A3(1)) and (A3(0))) and RF_W) or Reset);
E6 <= ((((A3(2)) and (A3(1)) and (not A3(0))) and RF_W) or Reset);
E7 <= ((((A3(2)) and (A3(1)) and (A3(0))) and RF_W) or Reset);



REG0 : Register16bit port map (Clk => Clk ,Reset => Reset,Enable =>E0,
										 data_in => B, data_out =>B0);
										 
REG1 : Register16bit port map (Clk => Clk ,Reset => Reset,Enable =>E1,
										 data_in => D3, data_out =>B1);
										 
REG2 : Register16bit port map (Clk => Clk ,Reset => Reset,Enable =>E2,
										 data_in => D3, data_out =>B2);
										 
REG3 : Register16bit port map (Clk => Clk ,Reset => Reset,Enable =>E3,
										 data_in => D3, data_out =>B3);
										 
REG4 : Register16bit port map (Clk => Clk ,Reset => Reset,Enable =>E4,
										 data_in => D3, data_out =>B4);
										 
REG5 : Register16bit port map (Clk => Clk ,Reset => Reset,Enable =>E5,
										 data_in => D3, data_out =>B5);
										 
REG6 : Register16bit port map (Clk => Clk ,Reset => Reset,Enable =>E6,
										 data_in => D3, data_out =>B6);	
										 
REG7 : Register16bit port map (Clk => Clk ,Reset => Reset,Enable =>E7,
										 data_in => D3, data_out =>B7);

																		 
--DEMUX PROCESS ENDS
MUX1 : MUX_8 port map(I0 =>B0,
							 I1 =>B1,
							 I2 =>B2,
							 I3 =>B3,
							 I4 =>B4,
							 I5 =>B5,
							 I6 =>B6,
							 I7 =>B7,
							 S =>A1,Y =>D1);
MUX2 : MUX_8 port map(I0 =>B0,
							 I1 =>B1,
							 I2 =>B2,
							 I3 =>B3,
							 I4 =>B4,
							 I5 =>B5,
							 I6 =>B6,
							 I7 =>B7,
							 S => A2,Y =>D2);
							 
--MUX3 : MUX_2 port map(IN_0 =>"0000000000000000",IN_1 =>B7,S =>IP_R,Y =>DR);
MUX0 : MUX_2 port map(IN_0 =>D3,IN_1 =>PC_in,S =>IP_W,Y =>B);
PC_out <= B0;

--R0_out <= B0;
--R1_out <= B1;
--R2_out <= B2;
--R3_out <= B3;
--R4_out <= B4;
--R5_out <= B5;
--R6_out <= B6;
--R7_out <= B7;	
						 
										 									 
end behav;