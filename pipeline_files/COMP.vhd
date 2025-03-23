library ieee;
use ieee.std_logic_1164.all;

entity COMP is
	port(RF_D2_RR_EX: in std_logic_vector(15 downto 0); COMP_En: in std_logic; COMP_out: out std_logic_vector(15 downto 0));
end entity COMP;

architecture Struct of COMP is

begin
	n: for i in 15 downto 0 generate
		COMP_out(i)<= (COMP_En and not(RF_D2_RR_EX(i))) or (not(COMP_En) and RF_D2_RR_EX(i));
	end generate n;
end Struct;