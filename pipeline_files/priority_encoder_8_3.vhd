library ieee;
use ieee.std_logic_1164.all;

entity priority_encoder_8_3 is
	port( x: in std_logic_vector(7 downto 0) ; y : out std_logic_vector(2 downto 0) := "000"; z : out std_logic);
end entity priority_encoder_8_3;



architecture struct of priority_encoder_8_3 is
	signal one, two, three, four, five, six, seven : std_logic;
	signal yy : std_logic_vector (2 downto 0);
	
	begin
	one <= not(x(7)) and x(6);
	two <= not(x(7)) and not(x(6)) and x(5);
	three <= not(x(7)) and not(x(6)) and not(x(5)) and x(4);
	four <= not(x(7)) and not(x(6)) and not(x(5)) and not(x(4)) and x(3);
	five <= not(x(7)) and not(x(6)) and not(x(5)) and not(x(4)) and not(x(3)) and x(2);
	six <=  not(x(7)) and not(x(6)) and not(x(5)) and not(x(4)) and not(x(3)) and not(x(2)) and x(1);
	seven <= not(x(7)) and not(x(6)) and not(x(5)) and not(x(4)) and not(x(3)) and not(x(2)) and not(x(1)) and x(0);
	
	yy(0) <= one or three or five or seven;
	yy(1) <= two or three or six or seven;
	yy(2) <= four or five or six or seven;
	
	y(0) <= not(yy(0));
	y(1) <= not(yy(1));
	y(2) <= not(yy(2));
	
	
	z <= not( x(0) or x(1) or x(2) or x(3) or x(4) or x(5) or x(6) or x(7));
	
	end struct;
	