library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.regfile.all;

entity tb_rf_modded is
end entity;

architecture behv of tb_rf_modded is

signal clk: std_logic := '0';
signal reset : std_logic := '1';
signal A1_1, A2_1, A3_1, A1_2, A2_2, A3_2 : std_logic_vector (2 downto 0);
signal D1_1, D2_1 , D3_1, D1_2, D2_2, D3_2 : std_logic_vector (15 downto 0);
signal IP_W_1, IP_W_2 : std_logic;
signal PC_in_1, PC_in_2, PC_out : std_logic_vector (15 downto 0) := (others => '0');
signal RF_W_1, RF_W_2 : std_logic;

begin 

reg_file : RegisterFileModded port map (A1_1, A2_1, A3_1, A1_2, A2_2, A3_2, D1_1, D2_1, D3_1, D1_2, D2_2, D3_2, IP_W_1, IP_W_2,
													PC_in_1, PC_in_2, PC_out, clk, reset, RF_W_1, RF_W_2);
													

													
clk_process: process
	begin
	while true loop
		clk <= '0';
		wait for 5ns;
		clk <= '1';
		wait for 5ns;
	end loop; 	
end process;

reset_process: process
	begin
		reset <= '0' after 18 ns;
		wait;
	end process;

main_process: process
begin
	A3_1  <= "001" after 20 ns;
	D3_1 <= std_logic_vector(to_unsigned(69, 16)) after 20ns;
	
	A3_2  <= "101" after 20 ns;
	D3_2 <= std_logic_vector(to_unsigned(44, 16)) after 20ns;
	
	RF_W_1 <= '1' after 20ns;
	RF_W_2 <= '1' after 20ns;
	
	A1_1 <= "101" after 40ns;
	A2_2 <= "001" after 40ns;
	wait;
	
end process;

end architecture;
