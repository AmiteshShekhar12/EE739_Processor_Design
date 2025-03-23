library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.ALL;
use ieee.numeric_std.all;


entity instr_memory is 
	port (clk : in std_logic;
			addr_in : in std_logic_vector (15 downto 0);
			data_out : out std_logic_vector (31 downto 0):="0000000000000000"); --changed to 32 bit out for 2 instructions
end instr_memory;

architecture behav of instr_memory is
	
	type memory_array is array (0 to 71) of std_logic_vector (7 downto 0);
	
	signal memory : memory_array := (
--"11000000", -- INSTR1_LSB; regB=reg7(val=0), Imm=0
--"01000011", -- INSTR1_MSB; op_code = 0100 (LW), regA=reg1=mem(0)(val=41290)
---- reg1=1, remaining reg=0
--"11000010", -- INSTR2_LSB; regB=reg7(val=0), Imm=2
--"01000101", -- INSTR2_MSB; op_code = 0100 (LW), regA=reg2=mem(2)(val=32768)
---- reg2=2, reg 1=1, remaining=0
--"11000010", -- INSTR2_LSB; regB=reg7(val=0), Imm=2
--"01000111", -- INSTR2_MSB; op_code = 0100 (LW), regA=reg2=mem(2)(val=32768)
---- reg2=2, reg 1=1, remaining=0
"11111100",
"01101110", --loc0


"10001010",
"10011010", --loc2

"10000010",
"00010010", --loc4

"10000000",
"01101000", --loc6

"00000000",
"00010000", -- loc8

"00000000",
"00010000", --loc10

"00000000",
"00010000", --loc12 

"00000000",
"00010000", --loc14

"10000000",
"11010010", --loc16 

"00000000",
"00010000", --loc18

"00000000",
"00010000", --loc20

"00000000",
"00010000", --loc22

"00000000",
"00010000", --loc24

"00000000",
"00010000", --loc26

"00000000",
"10110000", --loc26

"00000000",
"10110000", --loc28

"01001000",
"10000111", --loc30

"00000000",
"00010000", --loc32

"00000000",
"00010000", --loc34

"00000000",
"00010000", --loc36

"00000000",
"00010000", --loc38

"00000000",
"00010000", --loc40

"00000000",
"00010000", --loc42

"00000000",
"00010000", --loc44

"00000000",
"10110000", --loc46

"00000000",
"10110000",

"00000000",
"10110000",

"00000000",
"10110000",

"00000000",
"10110000",

"00000000",
"10110000",

"00000000",
"10110000",

"00000000",
"10110000",

"00000000",
"10110000",

"00000000",
"10110000",

"00000000",
"10110000",

"00000000",
"10110000"
);
	
	begin
	
--	p1 : process (clk)
--		begin 
--			if(clk'event and clk = '0') then
--				if (Mem_W = '1') then
--					memory(to_integer(unsigned(addr_in))) <= data_in(7 downto 0);
--					memory(to_integer(unsigned(addr_in))+1) <= data_in(15 downto 8);
--
--				end if;
--			end if;	
--		end process p1;
	data_out <= memory(to_integer(unsigned(addr_in))+3) & memory(to_integer(unsigned(addr_in))+2) & memory(to_integer(unsigned(addr_in))+1) & memory(to_integer(unsigned(addr_in))) ;
end behav;