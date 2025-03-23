library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.ALL;
use ieee.numeric_std.all;


entity data_memory is 
--updated for dual read/write ports for multi-fetch pipeline
	port (clk : in std_logic;
			Mem_W_1 : in std_logic;
			Mem_W_2 : in std_logic;
			addr_in_1 : in std_logic_vector (15 downto 0);
			addr_in_2 : in std_logic_vector (15 downto 0);
			data_in_1 : in std_logic_vector (15 downto 0);
			data_in_2 : in std_logic_vector (15 downto 0);
			data_out_1 : out std_logic_vector (15 downto 0):="0000000000000000";
			data_out_2 : out std_logic_vector (15 downto 0):="0000000000000000");
end data_memory;

architecture behav of data_memory is
	
	type memory_array is array (0 to 32) of std_logic_vector (7 downto 0);
	
	signal memory : memory_array := (
"00010000",
"00000000",

"00000010",
"00000000",

"00000010",
"00000000",

"00000101",
"00000000",

"00001110",
"00000000",

"00000101",
"00000000",

"00000000",
"11111111",

"00011110",
"00000000",

"00000000",
"00000000",

"00000000",
"00000000",

"00000000",
"00000000",

"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000"
);
	
	begin
	p1 : process (clk)
		begin 
		 -- Conflict detection: Both writes enabled AND addresses match
         if (Mem_W_1 = '1' and Mem_W_2 = '1' and addr_in_1 = addr_in_2) then
                report "ERROR: Write conflict detected at address " & 
                        integer'image(to_integer(unsigned(addr_in_1)))
                        severity ERROR;
			elsif (clk'event and clk = '0') then --memory write back operation at falling edge :(
			
				if (Mem_W_1 = '1') then
					memory(to_integer(unsigned(addr_in_1))) <= data_in_1(7 downto 0); --LSB first, Little Endian
					memory(to_integer(unsigned(addr_in_1))+1) <= data_in_1(15 downto 8);
				end if;
				
				if (Mem_W_2 = '1') then
					memory(to_integer(unsigned(addr_in_2))) <= data_in_2(7 downto 0); --LSB first, Little Endian
					memory(to_integer(unsigned(addr_in_2))+1) <= data_in_2(15 downto 8);
				end if;
			end if;	
		end process p1;
	data_out_1 <= memory(to_integer(unsigned(addr_in_1))+1) & memory(to_integer(unsigned(addr_in_1))) ;
	data_out_2<= memory(to_integer(unsigned(addr_in_2))+1) & memory(to_integer(unsigned(addr_in_2))) ;
end behav;