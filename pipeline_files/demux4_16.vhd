library ieee;
use ieee.std_logic_1164.all;

entity demux4_16 is
	port (En : IN std_logic;
			S : IN std_logic_vector(1 downto 0);
			D : IN std_logic_vector(15 downto 0);
			Y0, Y1, Y2, Y3: OUT std_logic_vector(15 downto 0));
end entity demux4_16;

architecture behav of demux4_16 is
	component demux2_16 is
		port (En : IN std_logic;
				S : IN std_logic;
				D : IN std_logic_vector(15 downto 0);
				Y0 : Out std_logic_vector(15 downto 0);
				Y1 : OUT std_logic_vector(15 downto 0));
	end component demux2_16;
	
	signal A0, A1 : std_logic_vector(15 downto 0);
begin
	demux1 : demux2_16 port map (En=>En, S=>S(1), D=>D, Y0=>A0, Y1=>A1);
	demux2 : demux2_16 port map (En=>En, S=>S(0), D=>A0, Y0=>Y0, Y1=>Y1);
	demux3 : demux2_16 port map (En=>En, S=>S(0), D=>A1, Y0=>Y2, Y1=>Y3);
end behav;