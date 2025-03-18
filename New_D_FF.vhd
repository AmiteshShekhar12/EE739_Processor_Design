library ieee;
use ieee.std_logic_1164.all;

entity New_D_FF is 

	port (D, clock, reset:in std_logic;
			Q:out std_logic);
			
end entity New_D_FF;

architecture behav of New_D_FF is 

signal QQ : std_logic := '0';
begin 

	dff_set_proc : process (clock, reset)
	
	begin
	
		if (reset = '0') then
		
			if (clock'event and clock='1') then
				QQ <= D;
		   end if;
		
		elsif (reset = '1') then
			QQ <= '0';
		end if;
		
	end process dff_set_proc;
	
	Q <= QQ;

end behav;