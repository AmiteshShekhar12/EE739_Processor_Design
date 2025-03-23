library ieee;
use ieee.std_logic_1164.all;

entity tb_cpu is
end tb_cpu;

architecture behav of tb_cpu is

	component Pipeline_CPU is
		port(clk, reset: in std_logic);
	end component Pipeline_CPU;
	
--	signal Clk_onboard, Clk_switch, Clk_pb, Reset, op_data_mux, Z_op, C_op: std_logic;
--	--signal op_data_mux : std_logic_vector(1 downto 0);
--	signal loc : std_logic_vector(2 downto 0);
--	signal op_data : std_logic_vector(15 downto 0);

	signal clk, reset : std_logic;
	begin
		dut_instance : Pipeline_cpu port map (clk, reset);
		
		Reset <= '1', '0' after 44 ns;
--		op_data_mux <= '0';
--		loc <= "000", "111" after 25 ms;
--		--lsb_msb <= '1', '0' after 80 ms, '1' after 81 ms, '0' after 82 ms;
--		Clk_switch <= '0';
--		Clk_pb <= '0';

		
		L1: process  -- In Testbench Process statement does not have sensitivity list
					 -- the Statement written inside process block in testbench will run in a infinite loop
				begin
--					clk <= '0';
--					wait for 5 ns; -- 100 us is used as Clk_50 freq = 50 MHz, so T = 200 us 
--									 -- So T/2 Clk_50 will be OFF and for next T/2 Clk_50 will ON 
--					clk <= '1';
--					
--					wait for 5 ns;

				while true loop
						  clk <= '0';
						  wait for 5 ns;
						  clk <= '1';
						  wait for 5 ns;
				end loop;
				end process;
		
end behav;