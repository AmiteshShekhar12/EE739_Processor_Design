--Left Shifter
library ieee;
use ieee.std_logic_1164.all;

entity LS is
	port (LS_in: in std_logic_vector(15 downto 0); LS_out : out std_logic_vector(15 downto 0));
end entity;

architecture Struct of LS is
begin
	LS_out(0)<='0';
	n1 : for i in 0 to 14 generate
		LS_out(i+1)<=LS_in(i);
	end generate n1;
end Struct;