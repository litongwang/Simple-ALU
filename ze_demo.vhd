library ieee;
use ieee.std_logic_1164.all;

entity ze_32_demo is
end ze_32_demo;

architecture structural of ze_32_demo is

component ze_32 is port (A   : in  std_logic_vector(31 downto 0);
                        ze  : out std_logic
                        
                           );
end component ze_32;
  
signal A: std_logic_vector(31 downto 0);  
signal ze : std_logic;


begin

fulladder_map : ze_32 port map (A => A, ze=>ze);

test_proc : process 
begin

A <= "00000000000000000000000000000000";
wait for 5 ns;
assert ze='1' report "ze" severity error;

A <= "00000000000000000000000000000001";
wait for 5 ns;
assert ze='0' report "ze" severity error;
wait;

end process;

end architecture structural;





