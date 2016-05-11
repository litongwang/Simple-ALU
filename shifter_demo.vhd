library ieee;
use ieee.std_logic_1164.all;

entity shifter_demo is
end shifter_demo;

architecture structural of shifter_demo is

component shifter is port (
                             A:in std_logic_vector(31 downto 0);
                             B:in std_logic_vector(4 downto 0);
                             shift:out std_logic_vector(31 downto 0)
        
                           );
end component shifter;
  
signal A : std_logic_vector(31 downto 0);
signal B : std_logic_vector(4 downto 0); 
signal shift : std_logic_vector(31 downto 0); 

begin
    
shift_map : shifter port map (A => A, B => B, shift => shift);

test_proc : process 
begin
     A <= "10000000000000000000000000000000"; 
     B <= "00111"; 
     wait for 5 ns; 
	  assert shift="00000001000000000000000000000000" report "shift 7" severity error;
    
	  A <= "10000000000000000000000000000000"; 
     B <= "00001"; 
     wait for 5 ns; 
	  assert shift="01000000000000000000000000000000" report "shift 1" severity error;
     
	  A <= "00000000100000000000000100000000"; 
     B <= "01111"; 
     wait for 5 ns; 
	  assert shift="00000000000000000000000100000000" report "shift 15" severity error;
	  
	  wait;
     end process;
     
     end architecture structural;
     
     