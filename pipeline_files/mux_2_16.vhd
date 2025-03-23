--library ieee;
--use ieee.std_logic_1164.all;
--
--package mux_16_2 is
--  component MUX_2 is
--   port (IN_0, IN_1: in std_logic_vector(15 downto 0);
--			S : in std_logic;
--			Y: out std_logic_vector(15 downto 0));
--  end component MUX_2;
--  
--end package mux_16_2;

library ieee;
use ieee.std_logic_1164.all;

entity MUX_2_16  is
  port (IN_0, IN_1: in std_logic_vector(15 downto 0);
			S : in std_logic;
			Y: out std_logic_vector(15 downto 0));
end entity MUX_2_16;

architecture Struct of MUX_2_16 is
begin
bit_16_1 : for i in 0 to 15 generate 
		Y(i) <= (IN_0(i) AND (NOT S)) OR (IN_1(i) AND S);
end generate ;
end Struct;