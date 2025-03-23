library ieee;
use ieee.std_logic_1164.all;

entity demux8_16 is
	port (En : IN std_logic;
			S : IN std_logic_vector(2 downto 0);
			D : IN std_logic_vector(15 downto 0);
			Y0, Y1, Y2, Y3, Y4, Y5, Y6, Y7 : OUT std_logic_vector(15 downto 0));
end entity demux8_16;

architecture behav of demux8_16 is
	component demux2_16 is
		port (En : IN std_logic;
				S : IN std_logic;
				D : IN std_logic_vector(15 downto 0);
				Y0 : Out std_logic_vector(15 downto 0);
				Y1 : OUT std_logic_vector(15 downto 0));
	end component demux2_16;
	
	component demux4_16 is
		port (En : IN std_logic;
				S : IN std_logic_vector(1 downto 0);
				D : IN std_logic_vector(15 downto 0);
				Y0, Y1, Y2, Y3: OUT std_logic_vector(15 downto 0));
	end component demux4_16;

	signal A0, A1, A2, A3 : std_logic_vector(15 downto 0);
	
begin
	demux1 : demux4_16 port map (En=>En, S=>S(2 downto 1), D=>D, Y0=>A0, Y1=>A1, Y2=>A2, Y3=>A3);
	demux2 : demux2_16 port map (En=>En, S=>S(0), D=>A0, Y0=>Y0, Y1=>Y1);
	demux3 : demux2_16 port map (En=>En, S=>S(0), D=>A1, Y0=>Y2, Y1=>Y3);
	demux4 : demux2_16 port map (En=>En, S=>S(0), D=>A2, Y0=>Y4, Y1=>Y5);
	demux5 : demux2_16 port map (En=>En, S=>S(0), D=>A3, Y0=>Y6, Y1=>Y7);
end behav;
	