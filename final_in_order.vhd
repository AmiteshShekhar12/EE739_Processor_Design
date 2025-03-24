library ieee;
use ieee.std_logic_1164.all;

entity in_order_2_way is
	port ()
end entity;

architecture struct of in_order_2_way is

	component RegisterFileModded is
		port(A1_1, A2_1, A3_1 : IN std_logic_vector(2 downto 0);
				A1_2, A2_2, A3_2 : IN std_logic_vector(2 downto 0);
				D1_1, D2_1 : OUT std_logic_vector(15 downto 0);
				D3_1 : IN std_logic_vector(15 downto 0);
				D1_2, D2_2 : OUT std_logic_vector(15 downto 0);
				D3_2 : IN std_logic_vector(15 downto 0);
				IP_W_1 : IN std_logic;
				IP_W_2 : IN std_logic;
				PC_in_1 : IN std_logic_vector(15 downto 0);
				PC_in_2 : IN std_logic_vector(15 downto 0);
				PC_out : OUT std_logic_vector(15 downto 0);
			    Clk, Reset : IN std_logic;
				RF_W_1 : IN std_logic;
				RF_W_2 : IN std_logic
		  );
	end component;
	
	component instr_memory is 
		port (clk : in std_logic;
				addr_in : in std_logic_vector (15 downto 0);
				data_out : out std_logic_vector (15 downto 0):="0000000000000000");
	end component instr_memory;
	
begin 
	
	RF_ins: RegisterFileModded port map (RF_A1_1, RF_A2_1, RF_A3_1, RF_A1_2, RF_A2_2, RF_A3_2, RF_D1_1, RF_D2_2, RF_D3_1, RF_D3_2, RF_PC_W_1, RF_PC_W_2, RF_PC_in_1, RF_PC_in_2, RF_PC_out, clk, rst, RF_W_1, RF_W_2);
	imem: instr_memory port map(clk, RF_PC_out, imem_out);