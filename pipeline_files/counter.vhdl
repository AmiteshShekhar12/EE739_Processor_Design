library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
	port(clk, v : in std_logic;
		  op_code : in std_logic_vector(3 downto 0);
		  Imm6 : out std_logic_vector(5 downto 0) := "000000");
end entity counter;

architecture struct of counter is

signal lm_sm : std_logic;
signal rst : std_logic;
signal imm6_int : integer := 0;
begin
	p1 : process(clk)
		variable count : integer := 0;
	begin
		if (clk'event and (clk = '0')) then
			if rst= '0' then
				count := imm6_int + 2;
			elsif rst = '1' then 
				count := 0 ;
			end if;
			imm6_int <= count;
		end if;
	end process;
	
	lm_sm <= not(op_code(3)) and op_code(2) and op_code(1);
	rst<=not(lm_sm) or  not(v);
	Imm6 <= std_logic_vector(to_unsigned(imm6_int, 6));

end struct;
		
	
			