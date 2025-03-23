library ieee;
use ieee.std_logic_1164.all;

entity demux2_16 is
	port (En : IN std_logic;
			S : IN std_logic;
			D : IN std_logic_vector(15 downto 0);
			Y0 : OUT std_logic_vector(15 downto 0);
			Y1 : OUT std_logic_vector(15 downto 0));
end entity demux2_16;

architecture behav of demux2_16 is
	
begin
	loop1 : for i in 0 to 15 generate
		Y0(i) <= En and (not S) and D(i);
		Y1(i) <= En and S and D(i);
	end generate;
end behav;