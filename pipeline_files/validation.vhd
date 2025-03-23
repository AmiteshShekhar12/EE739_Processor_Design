library ieee;
use ieee.std_logic_1164.all;

entity validation is
	port(imm8 : in std_logic_vector(7 downto 0); v : out std_logic);
end entity validation;

architecture struct of validation is

signal x : std_logic_vector(7 downto 0);

begin
	
	x(0) <= imm8(0) and not(imm8(1)) and not(imm8(2)) and not(imm8(3)) and not(imm8(4)) and not(imm8(5)) and not(imm8(6))and not(imm8(7));
	x(1) <= not(imm8(0)) and imm8(1) and not(imm8(2)) and not(imm8(3)) and not(imm8(4)) and not(imm8(5)) and not(imm8(6))and not(imm8(7));
	x(2) <= not(imm8(0)) and not(imm8(1)) and imm8(2) and not(imm8(3)) and not(imm8(4)) and not(imm8(5)) and not(imm8(6))and not(imm8(7));
	x(3) <= not(imm8(0)) and not(imm8(1)) and not(imm8(2)) and imm8(3) and not(imm8(4)) and not(imm8(5)) and not(imm8(6))and not(imm8(7));
	x(4) <= not(imm8(0)) and not(imm8(1)) and not(imm8(2)) and not(imm8(3)) and imm8(4) and not(imm8(5)) and not(imm8(6))and not(imm8(7));
	x(5) <= not(imm8(0)) and not(imm8(1)) and not(imm8(2)) and not(imm8(3)) and not(imm8(4)) and imm8(5) and not(imm8(6))and not(imm8(7));
	x(6) <= not(imm8(0)) and not(imm8(1)) and not(imm8(2)) and not(imm8(3)) and not(imm8(4)) and not(imm8(5)) and imm8(6)and not(imm8(7));
	x(7) <= not(imm8(0)) and not(imm8(1)) and not(imm8(2)) and not(imm8(3)) and not(imm8(4)) and not(imm8(5)) and not(imm8(6))and imm8(7);
	
	
	v <= not(x(0) or x(1) or x(2) or x(3) or x(4) or x(5) or x(6) or x(7));
	
end struct;