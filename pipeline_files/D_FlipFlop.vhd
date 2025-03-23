library ieee;
use ieee.std_logic_1164.all;

package Flipflops is
	component D_Flipflop is 
		port (D,clock,preset,reset,enable:in std_logic;
				Q:out std_logic);
	end component D_Flipflop;
end package Flipflops;


library ieee;
use ieee.std_logic_1164.all;

entity D_Flipflop is 
	port (D,clock,preset,reset,enable:in std_logic;
				Q:out std_logic);
end entity D_Flipflop;

architecture behav of D_Flipflop is 
signal QQ : std_logic := '0';
begin 

	dff_set_proc : process (clock, enable)
		begin 
		
		if ((clock'event and clock='0') and enable = '1') then
			if (reset='1') then
		   QQ <= '0';
			
			elsif (preset='1') then
			QQ <= '1';
	
		   else 
		   QQ <= D;
			
		   end if; 
		
		end if;

	end process dff_set_proc; 
	Q <= QQ;


end behav;