--library ieee;
--use ieee.std_logic_1164.all;
--package mux_16_4 is
--  component MUX_4 is
--   port (I0,I1,I2,I3: in std_logic_vector (15 downto 0);
--			S: in std_logic_vector(1 downto 0);
--			Y: out std_logic_vector (15 downto 0));
--  end component MUX_4;
--  
--end package mux_16_4;

library ieee;
use ieee.std_logic_1164.all;


entity MUX_4_16  is
  port (I0,I1,I2,I3: in std_logic_vector (15 downto 0);
			S: in std_logic_vector(1 downto 0);
			Y: out std_logic_vector (15 downto 0));
end entity MUX_4_16;

architecture Struct of MUX_4_16 is
	
	component MUX_2_16  is
	  port (IN_0, IN_1: in std_logic_vector(15 downto 0);
				S : in std_logic;
				Y: out std_logic_vector(15 downto 0));
	end component MUX_2_16;
	
  signal A0,A1: std_logic_vector (15 downto 0);
begin
  MUX1: MUX_2_16 port map (IN_0 => I0, IN_1 => I1,S => S(0), Y => A0);
  MUX2: MUX_2_16 port map (IN_0 => I2, IN_1 => I3,S => S(0), Y => A1);
  MUX3: MUX_2_16 port map (IN_0 => A0, IN_1 => A1,S => S(1), Y => Y);
end Struct;