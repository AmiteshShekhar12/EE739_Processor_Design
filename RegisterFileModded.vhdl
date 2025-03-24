library ieee;
use ieee.std_logic_1164.all;

package regfile is
  component RegisterFileModded is
-- modded regfile is common to both the pipelines and supports simultaneous write as well as read (assuming both the write locations are different)
--RF_W is the union of the individual RF_W of the individual pipelines
--IP_W is also the union of the individual IP_W of the individual pipelines. However, this can't theoretically happen simultaneously and we delegate the responsibility 
--to scorecard to take care of dependencies (false dependencies in this case)
		port(	A1_1, A2_1, A3_1 : IN std_logic_vector(2 downto 0);
				A1_2, A2_2, A3_2 : IN std_logic_vector(2 downto 0);
				D1_1, D2_1 : OUT std_logic_vector(15 downto 0);
				D3_1 : IN std_logic_vector(15 downto 0);
				D1_2, D2_2 : OUT std_logic_vector(15 downto 0);
				D3_2 : IN std_logic_vector(15 downto 0);
				IP_W_1 : IN std_logic;
				IP_W_2 : IN std_logic;
				PC_in_1 : IN std_logic_vector(15 downto 0);
				PC_in_2 : IN std_logic_vector(15 downto 0);
				PC_out : OUT std_logic_vector(15 downto 0);
			    Clk, Reset : IN std_logic;
				RF_W_1 : IN std_logic;
				RF_W_2 : IN std_logic
		  );
	end component RegisterFileModded;
  
end package regfile;

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.mux_16_2.all;
use work.mux_16_8.all;
use work.reg.all;

entity RegisterFileModded is
		port(A1_1, A2_1, A3_1 : IN std_logic_vector(2 downto 0);
				A1_2, A2_2, A3_2 : IN std_logic_vector(2 downto 0);
				D1_1, D2_1 : OUT std_logic_vector(15 downto 0);
				D3_1 : IN std_logic_vector(15 downto 0);
				D1_2, D2_2 : OUT std_logic_vector(15 downto 0);
				D3_2 : IN std_logic_vector(15 downto 0);
				IP_W_1 : IN std_logic;
				IP_W_2 : IN std_logic;
				PC_in_1 : IN std_logic_vector(15 downto 0);
				PC_in_2 : IN std_logic_vector(15 downto 0);
				PC_out : OUT std_logic_vector(15 downto 0);
			    Clk, Reset : IN std_logic;
				RF_W_1 : IN std_logic;
				RF_W_2 : IN std_logic
		  );
end entity RegisterFileModded;


architecture behav of RegisterFileModded is
 signal B,B0,B1,B2,B3,B4,B5,B6,B7: std_logic_vector (15 downto 0); --output_data of the registers in RF
 signal E0_1,E1_1,E2_1,E3_1,E4_1,E5_1,E6_1,E7_1: std_logic; --enable signals pipeline 1, used for writing to RF
 signal E0_2,E1_2,E2_2,E3_2,E4_2,E5_2,E6_2,E7_2: std_logic; --enable signals pipeline 2, used for writin to RF
 signal E0, E1, E2, E3, E4, E5, E6, E7 : std_logic; --enable signals of the register of main RF, xor of enable1 and enable2
 signal IP_W, RF_W : std_logic;
 signal PC_in : std_logic_vector (15 downto 0);
 signal D3_R0, D3_R1, D3_R2, D3_R3, D3_R4, D3_R5, D3_R6, D3_R7 : std_logic_vector (15 downto 0);

begin

IP_W <= IP_W_1 and IP_W_2; --when both are one, don't write to program counter -> don't jump
RF_W <= RF_W_1 or RF_W_2; --since you can have two simulateneous write operations of the RF

PC_in <= PC_in_1 when IP_W_1 = '1' else
		 PC_in_2 when IP_W_2 = '1' else
		 (others => '0'); --Default case
		 
D3_R0 <= D3_1 when E0_1 = '1' else
         D3_2 when E0_2 = '1' else
         (others => '0'); -- Default case

D3_R1 <= D3_1 when E1_1 = '1' else
         D3_2 when E1_2 = '1' else
         (others => '0'); -- Default case

D3_R2 <= D3_1 when E2_1 = '1' else
         D3_2 when E2_2 = '1' else
         (others => '0'); -- Default case

D3_R3 <= D3_1 when E3_1 = '1' else
         D3_2 when E3_2 = '1' else
         (others => '0'); -- Default case
		 
D3_R4 <= D3_1 when E4_1 = '1' else
         D3_2 when E4_2 = '1' else
         (others => '0'); -- Default case
		 
D3_R5 <= D3_1 when E5_1 = '1' else
         D3_2 when E5_2 = '1' else
         (others => '0'); -- Default case
		 
D3_R6 <= D3_1 when E6_1 = '1' else
         D3_2 when E6_2 = '1' else
         (others => '0'); -- Default case
		 
D3_R7 <= D3_1 when E7_1 = '1' else
         D3_2 when E7_2 = '1' else
         (others => '0'); -- Default case
		 
-- DEMUX PROCESS STARTS

E0_1 <=((((not A3_1(2)) and (not A3_1(1)) and (not A3_1(0)) and RF_W)) or Reset or IP_W);
E1_1 <=((((not A3_1(2)) and (not A3_1(1)) and (A3_1(0))) and RF_W) or Reset) ;
E2_1 <= ((((not A3_1(2)) and (A3_1(1)) and (not A3_1(0))) and RF_W) or Reset);
E3_1 <= ((((not A3_1(2)) and (A3_1(1)) and (A3_1(0))) and RF_W) or Reset);
E4_1 <= ((((A3_1(2)) and (not A3_1(1)) and (not A3_1(0))) and RF_W) or Reset);
E5_1 <= ((((A3_1(2)) and (not A3_1(1)) and (A3_1(0))) and RF_W) or Reset);
E6_1 <= ((((A3_1(2)) and (A3_1(1)) and (not A3_1(0))) and RF_W) or Reset);
E7_1 <= ((((A3_1(2)) and (A3_1(1)) and (A3_1(0))) and RF_W) or Reset);

E0_2 <=((((not A3_2(2)) and (not A3_2(1)) and (not A3_2(0)) and RF_W)) or Reset or IP_W);
E1_2 <=((((not A3_2(2)) and (not A3_2(1)) and (A3_2(0))) and RF_W) or Reset) ;
E2_2 <= ((((not A3_2(2)) and (A3_2(1)) and (not A3_2(0))) and RF_W) or Reset);
E3_2 <= ((((not A3_2(2)) and (A3_2(1)) and (A3_2(0))) and RF_W) or Reset);
E4_2 <= ((((A3_2(2)) and (not A3_2(1)) and (not A3_2(0))) and RF_W) or Reset);
E5_2 <= ((((A3_2(2)) and (not A3_2(1)) and (A3_2(0))) and RF_W) or Reset);
E6_2 <= ((((A3_2(2)) and (A3_2(1)) and (not A3_2(0))) and RF_W) or Reset);
E7_2 <= ((((A3_2(2)) and (A3_2(1)) and (A3_2(0))) and RF_W) or Reset);

E0 <= E0_1 xor E0_2;
E1 <= E1_1 xor E1_2;
E2 <= E2_1 xor E2_2;
E3 <= E3_1 xor E3_2;
E4 <= E4_1 xor E4_2;
E5 <= E5_1 xor E5_2;
E6 <= E6_1 xor E6_2;
E7 <= E7_1 xor E7_2;


REG0 : Register16bit port map (Clk => Clk ,Reset => Reset,Enable =>E0, --REGO has PC stored
										 data_in => B, data_out =>B0);
										 
REG1 : Register16bit port map (Clk => Clk ,Reset => Reset,Enable =>E1,
										 data_in => D3_R1, data_out =>B1);
										 
REG2 : Register16bit port map (Clk => Clk ,Reset => Reset,Enable =>E2,
										 data_in => D3_R2, data_out =>B2);
										 
REG3 : Register16bit port map (Clk => Clk ,Reset => Reset,Enable =>E3,
										 data_in => D3_R3, data_out =>B3);
										 
REG4 : Register16bit port map (Clk => Clk ,Reset => Reset,Enable =>E4,
										 data_in => D3_R4, data_out =>B4);
										 
REG5 : Register16bit port map (Clk => Clk ,Reset => Reset,Enable =>E5,
										 data_in => D3_R5, data_out =>B5);
										 
REG6 : Register16bit port map (Clk => Clk ,Reset => Reset,Enable =>E6,
										 data_in => D3_R6, data_out =>B6);	
										 
REG7 : Register16bit port map (Clk => Clk ,Reset => Reset,Enable =>E7,
										 data_in => D3_R7, data_out =>B7);

																		 
--DEMUX PROCESS ENDS

MUX1_1 : MUX_8 port map(     I0 =>B0,
							 I1 =>B1,
							 I2 =>B2,
							 I3 =>B3,
							 I4 =>B4,
							 I5 =>B5,
							 I6 =>B6,
							 I7 =>B7,
							 S =>A1_1,Y =>D1_1);
							 
MUX2_1 : MUX_8 port map(	 I0 =>B0,
							 I1 =>B1,
							 I2 =>B2,
							 I3 =>B3,
							 I4 =>B4,
							 I5 =>B5,
							 I6 =>B6,
							 I7 =>B7,
							 S => A2_1,Y =>D2_1);
							 
MUX1_2 : MUX_8 port map(     I0 =>B0,
							 I1 =>B1,
							 I2 =>B2,
							 I3 =>B3,
							 I4 =>B4,
							 I5 =>B5,
							 I6 =>B6,
							 I7 =>B7,
							 S =>A1_2,Y =>D1_2);
							 
MUX2_2 : MUX_8 port map(     I0 =>B0,
							 I1 =>B1,
							 I2 =>B2,
							 I3 =>B3,
							 I4 =>B4,
							 I5 =>B5,
							 I6 =>B6,
							 I7 =>B7,
							 S => A2_2,Y =>D2_2);
							 
--MUX3 : MUX_2 port map(IN_0 =>"0000000000000000",IN_1 =>B7,S =>IP_R,Y =>DR);
MUX0 : MUX_2 port map(IN_0 =>D3_R0,IN_1 =>PC_in,S =>IP_W,Y =>B);
PC_out <= B0;
								 									 
end behav;