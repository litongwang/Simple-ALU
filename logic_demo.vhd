library ieee;
use ieee.std_logic_1164.all;

entity logic_demo is
end logic_demo;

architecture structural of logic_demo is

component logicmath is port (
                              A   : in  std_logic_vector(31 downto 0);
                              B   : in  std_logic_vector(31 downto 0);
                              ctrl : in  std_logic_vector(1 downto 0);
                              r_logic : out std_logic_vector(31 downto 0)
                           );
end component logicmath;
  
signal A : std_logic_vector(31 downto 0); 
signal B : std_logic_vector(31 downto 0);
signal ctrl : std_logic_vector(1 downto 0);
signal r_logic : std_logic_vector(31 downto 0);

begin
    
logic_map : logicmath port map (A => A, B => B, ctrl => ctrl, r_logic=>r_logic);
     
test_proc : process 
begin
     A <= "10000000001000000000000000000000"; 
     B <= "00000000001000000000000000000111";
     ctrl <="01"; --or
     wait for 5 ns; 
	  assert r_logic="10000000001000000000000000000111" report "or" severity error;
	  
     A <= "10111110000000000110111111100000"; 
     B <= "00111000001000100000000000000111"; 
     ctrl <="01"; --or
     wait for 5 ns; 
	  assert r_logic="10111110001000100110111111100111" report "or" severity error;
	  
     A <= "10000000010000000000000000000000"; 
     B <= "00000000010000000000000000000111"; 
     ctrl <="00"; --and
     wait for 5 ns;
	  assert r_logic="00000000010000000000000000000000" report "and" severity error;
	  
     A <= "10000000010000000011100000000101"; 
     B <= "00000000010000000011100000000111"; 
     ctrl <="00"; --and
     wait for 5 ns;
	  assert r_logic="00000000010000000011100000000101" report "and" severity error;
    
	  A <= "10000000001000000000000000000000"; 
     B <= "00000000001000000000000000000111"; 
     ctrl <="10"; --xor
     wait for 5 ns;
	  assert r_logic="10000000000000000000000000000111" report "xor" severity error;
	  
	  A <= "10000000001000000000000000000000"; 
     B <= "00000000001000000000110000000111"; 
     ctrl <="10"; --xor
     wait for 5 ns;
	  assert r_logic="10000000000000000000110000000111" report "xor" severity error;
     wait;
	  end process;
     
     end architecture structural;
     
     