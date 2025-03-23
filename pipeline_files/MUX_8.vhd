library ieee;
use ieee.std_logic_1164.all;
package mux_16_8 is
  component MUX_8 is
   port (I0,I1,I2,I3,I4,I5,I6,I7: in std_logic_vector (15 downto 0);
			S: in std_logic_vector(2 downto 0);
			Y: out std_logic_vector (15 downto 0));
  end component MUX_8;
  
end package mux_16_8;

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.mux_16_2.all;

entity MUX_8  is
  port (I0,I1,I2,I3,I4,I5,I6,I7: in std_logic_vector (15 downto 0);
			S: in std_logic_vector(2 downto 0);
			Y: out std_logic_vector (15 downto 0));
end entity MUX_8;

architecture Struct of MUX_8 is
  signal A0,A1,A2,A3,B0,B1: std_logic_vector (15 downto 0);
begin
  MUX1: MUX_2 port map (IN_0 => I0, IN_1 => I1,S => S(0), Y => A0);
  MUX2: MUX_2 port map (IN_0 => I2, IN_1 => I3,S => S(0), Y => A1);
  MUX3: MUX_2 port map (IN_0 => I4, IN_1 => I5,S => S(0), Y => A2);
  MUX4: MUX_2 port map (IN_0 => I6, IN_1 => I7,S => S(0), Y => A3);
  MUX5: MUX_2 port map (IN_0 => A0, IN_1 => A1,S => S(1), Y => B0);
  MUX6: MUX_2 port map (IN_0 => A2, IN_1 => A3,S => S(1), Y => B1);
  MUX7: MUX_2 port map (IN_0 => B0, IN_1 => B1,S => S(2), Y => Y);
end Struct;