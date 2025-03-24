library ieee;
use ieee.std_logic_1164.all;

entity pipeline_reg_rst_decoder is
	port (opcode_RR_EX, opcode_ID_RR, opcode_IF_ID : IN std_logic_vector(3 downto 0);
			ALU1_Cy, ALU1_Zf : IN std_logic;
			RST_IF_ID, RST_ID_RR, RST_RR_EX, RST_EX_Mem, RST_Mem_WB : OUT std_logic
			);
end entity pipeline_reg_rst_decoder;

architecture struct of pipeline_reg_rst_decoder is
	signal f1, f2, f3, f4, f5, f6: std_logic := '0';
	signal c, z, rst1, rst2, rst3, rst4, rst5 : std_logic;
	
begin
	c <= ALU1_Cy;
	z <= ALU1_Zf;
--	
--	flag_proc : process (opcode_RR_EX, opcode_ID_RR, opcode_IF_ID)
--						begin
--							if (opcode_RR_EX = "1000") then
--								f1 <= '1';
--							elsif (opcode_RR_EX = "1001") then
--								f2 <= '1';
--							elsif (opcode_RR_EX = "1010") then
--								f3 <= '1';
--							else 
--								f1 <= '0';
--								f2 <= '0';
--								f3 <= '0';
--							end if;
--							
--							if (opcode_ID_RR = "1101") then
--								f4 <= '1';
--							elsif (opcode_ID_RR = "1111") then
--								f5 <= '1';
--							else
--								f4 <= '0';
--								f5 <= '0';
--							end if;
--							
--							if (opcode_IF_ID = "1100") then
--								f6 <= '1';
--							else
--								f6 <= '0';
--							end if;
--						end process flag_proc;
	
	f1<= opcode_RR_Ex(3) and not(opcode_RR_Ex(2)) and not(opcode_RR_Ex(1)) and not(opcode_RR_Ex(0));
	f2<= opcode_RR_Ex(3) and not(opcode_RR_Ex(2)) and not(opcode_RR_Ex(1)) and opcode_RR_Ex(0);
	f3<= opcode_RR_Ex(3) and not(opcode_RR_Ex(2)) and opcode_RR_Ex(1) and not(opcode_RR_Ex(0));
	f4<= opcode_ID_RR(3) and opcode_ID_RR(2) and not(opcode_ID_RR(1)) and opcode_ID_RR(0);
	f5<= opcode_ID_RR(3) and opcode_ID_RR(2) and opcode_ID_RR(1) and opcode_ID_RR(0);
	--f6<= opcode_IF_ID(3) and opcode_IF_ID(2) and not(opcode_IF_ID(1)) and not(opcode_IF_ID(0));
	
	rst1 <= (f1 and z) or (f2 and c) or (f3 and (c or z)) or f4 or f5;-- or f6;
	rst2 <= (f1 and z) or (f2 and c) or (f3 and (c or z)) or f4 or f5;
	rst3 <= (f1 and z) or (f2 and c) or (f3 and (c or z));
	rst4 <= '0';
	rst5 <= '0';
	
	RST_IF_ID <= rst1;
	RST_ID_RR <= rst2;
	RST_RR_EX <= rst3;
	RST_EX_Mem <= rst4;
	RST_Mem_WB <= rst5;
	
end architecture;