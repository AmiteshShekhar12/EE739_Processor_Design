library ieee;
use ieee.std_logic_1164.all;

entity mux_RF_D3 is 
	port (op_code : IN std_logic_vector(3 downto 0);
			alu1_C, mem_Dout, Imm: IN std_logic_vector(15 downto 0);
			mux_out : OUT std_logic_vector(15 downto 0)
			);
end entity mux_RF_D3;

architecture behav of mux_RF_D3 is 

	signal s1, s2, s3: std_logic;
	signal opcode: std_logic_vector(3 downto 0);
	
begin 
	
	opcode<=op_code;
	s1<= (not(opcode(3)) and not(opcode(2)) and not(opcode(1)) and opcode(0)) or (not(opcode(3)) and not(opcode(2)) and opcode(1) and not(opcode(0))) or (not(opcode(3)) and not(opcode(2)) and not(opcode(1)) and not(opcode(0))) or (opcode(3) and opcode(2) and not(opcode(1)));
	s2<= (not(opcode(3)) and not(opcode(2)) and opcode(1) and opcode(0));
	s3<= (not(opcode(3)) and opcode(2) and not(opcode(1)) and not(opcode(0)));


	n1 : for i in 0 to 15 generate
		mux_out(i)<=(s1 and alu1_c(i)) or (s2 and Imm(i)) or (s3 and mem_Dout(i));
	end generate;
	
	--	mux_proc : process (op_code)
--		begin 
--			if (op_code = "0001" or op_code = "0010" or op_code = "0000" or op_code = "1101" or op_code = "1100") then
--				mux_out <= alu1_C;
--			
--			elsif (op_code = "0011") then
--				mux_out <= Imm;
--			
--			elsif (op_code = "0100") then
--				mux_out <= mem_Dout;
--			end if;
--
--	end process mux_proc;
end behav;