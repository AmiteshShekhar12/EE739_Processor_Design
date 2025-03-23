library ieee;
use ieee.std_logic_1164.all;

entity MUX_4_3bit  is
  port (I0,I1,I2,I3: in std_logic_vector (2 downto 0);
			S: in std_logic_vector(1 downto 0);
			Y: out std_logic_vector (2 downto 0));
end entity MUX_4_3bit;

architecture Struct of MUX_4_3bit is
	component MUX_2_3bit  is
		port (IN_0, IN_1: in std_logic_vector(2 downto 0);
				S : in std_logic;
				Y: out std_logic_vector(2 downto 0));
	end component MUX_2_3bit;


  signal A0,A1: std_logic_vector (2 downto 0);
begin
  MUX1: MUX_2_3bit port map (IN_0 => I0, IN_1 => I1,S => S(0), Y => A0);
  MUX2: MUX_2_3bit port map (IN_0 => I2, IN_1 => I3,S => S(0), Y => A1);
  MUX3: MUX_2_3bit port map (IN_0 => A0, IN_1 => A1,S => S(1), Y => Y);
end Struct;