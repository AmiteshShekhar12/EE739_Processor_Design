library ieee;
use ieee.std_logic_1164.all;

entity RF_W_decoder is 
	port (B0, B1, Cy, Zf : IN std_logic; --B0 = Instrn_RR/EX_bit0, B1 = Instrn_RR/EX_bit1
			op_code : IN std_logic_vector(3 downto 0);
			RF_W : OUT std_logic
			);
end entity RF_W_decoder;

architecture behav of RF_W_decoder is 
	signal opcode : std_logic_vector(3 downto 0);
begin 

--	decoder_proc : process (op_code)
--		begin 
--			if (op_code = "0001") then
--				RF_W <= ((not B0) and (not B1)) or ((B1 and (not B0) and Cy)) or ((not B1) and B0 and Zf) or (B1 and B0);
--				
--			elsif (op_code = "0010") then
--				RF_W <= ((not B1) and (not B0)) or (B1 and (not B0) and Cy) or ((not B1) and B0 and Zf);
--				
--			elsif (op_code = "0101" or op_code = "1000" or op_code = "1001" or op_code = "1010" or op_code = "1111" or op_code = "1011") then
--				RF_W <= '0';
--				
--			elsif (op_code = "0000" or op_code = "0011" or op_code = "0100" or op_code = "1100" or op_code = "1101") then
--				RF_W <= '1';
--				
--			end if;
--			
--		end process decoder_proc;
	opcode<=op_code;
	RF_W <= (not(opcode(3)) and not(opcode(2)) and not(opcode(1)) and opcode(0) and (((not B0) and (not B1)) or ((B1 and (not B0) and Cy)) or ((not B1) and B0 and Zf) or (B1 and B0))) 
	or (not(opcode(3)) and not(opcode(2)) and opcode(1) and not(opcode(0)) and (((not B1) and (not B0)) or (B1 and (not B0) and Cy) or ((not B1) and B0 and Zf)))
	or ((not(opcode(3)) and not(opcode(1)) and not(opcode(0))) or (opcode(3) and opcode(2) and not(opcode(1))) or (not(opcode(3)) and not(opcode(2)) and opcode(1) and opcode(0)));
end behav;