library ieee;
use ieee.std_logic_1164.all;

entity pc_f is port 
	(
	clk:in std_logic;
	D: in std_logic_vector(31 downto 0);
	Q: out std_logic_vector(31 downto 0)
	);
	end pc_f;
	
	architecture structural of pc_f is 
		component dff is 
			 port (
		clk	   : in  std_logic;
		d	   : in  std_logic;
		q	   : out std_logic
		);
			end component;
			
	begin

			GEN_REG: 
		for i in 0 to 31 generate
		g : dff port map (clk=>clk,d=>D(i),q=>Q(i));
		end generate GEN_REG;
	end architecture structural;