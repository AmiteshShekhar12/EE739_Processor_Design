library ieee;
use ieee.std_logic_1164.all;

entity tb_dff is
end tb_dff;

architecture behv of tb_dff is

--add the componenet dff
component New_D_FF is
	port (D, clock, reset:in std_logic;
				Q:out std_logic);
end component;

--include intermediate signals
signal D, clock : std_logic := '0';
signal reset : std_logic := '1';
signal Q : std_logic := '0';

--generate clock and reset signal
begin
	dff1 : New_D_FF port map(D, clock, reset, Q);
	
	main_process: process
	begin
		reset <= '0' after 20 ns;
		D <= '1', '0' after 30 ns, '1' after 60 ns, '0' after 70 ns;
		wait;
	end process;
	
	clk_process: process
	begin
	while true loop
		clock <= '0';
		wait for 5ns;
		clock <= '1';
		wait for 5ns;
	end loop; 	
	end process;
end architecture;
