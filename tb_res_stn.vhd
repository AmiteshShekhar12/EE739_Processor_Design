library IEEE;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity tb_res_stn is
end entity;

architecture bhv of tb_res_stn is

component res_stn is
	port (clk, rst: in std_logic;
			I1, I2: in std_logic_vector(63 downto 0);
			I_out1, I_out2: out std_logic_vector(63 downto 0));
end component;

signal clock : std_logic := '0';
signal reset : std_logic := '1';
signal int_I1 : integer := 0;
signal int_I2 : integer := 1;
signal I1: std_logic_vector(63 downto 0) := "1010101010101010101010101010101010101010101010101010101010101010";
signal I2: std_logic_vector(63 downto 0) := (others => '1');
signal I_out1, I_out2 : std_logic_vector(63 downto 0) := (others => '0');

begin
	res_stn1 : res_stn port map(clock,reset,I1, I2,I_out1, I_out2);
	
	main_process: process
	begin
		reset <= '0' after 19 ns;
		wait;
	end process;
	
	-- Process to Increment Integers and Update Inputs
    update_inputs: process(clock)
   begin
		if (rising_edge(clock) and reset = '0') then
			int_I1 <= int_I1 + 2;
			int_I2 <= int_I2 + 2;
			I1 <= std_logic_vector(to_unsigned(int_I1, 64));
			I2 <= std_logic_vector(to_unsigned(int_I2, 64));
		end if;
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