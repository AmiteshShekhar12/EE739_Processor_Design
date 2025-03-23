library ieee;
use ieee.std_logic_1164.all;

entity decoder_3_8 is
	port (x : in std_logic_vector(2 downto 0);
			y : out std_logic_vector(7 downto 0));
end entity decoder_3_8;

architecture struct of decoder_3_8 is
	
	begin
	
	y(7) <= not(x(2)) and not(x(1)) and not(x(0));
	y(6) <= not(x(2)) and not(x(1)) and x(0);
	y(5) <= not(x(2)) and x(1) and not(x(0));
	y(4) <= not(x(2)) and x(1) and x(0);
	y(3) <= x(2) and not(x(1)) and not(x(0));
	y(2) <= x(2) and not(x(1)) and x(0);
	y(1) <= x(2) and x(1) and not(x(0));
	y(0) <= x(2) and x(1) and x(0);
	end struct;