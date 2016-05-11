library ieee;
use ieee.std_logic_1164.all;

entity fulladder_4_demo is
end fulladder_4_demo;

architecture structural of fulladder_4_demo is

component fulladder_4 is port (
                             A   : in  std_logic_vector (3 downto 0);
                             B   : in  std_logic_vector (3 downto 0);
                             Cin : in  std_logic;
                             Cout: out std_logic;
                             Sum : out std_logic_vector (3 downto 0)
                          
        
                           );
end component fulladder_4;
  
signal A : std_logic_vector(3 downto 0); 
signal B : std_logic_vector(3 downto 0); 
signal Cin : std_logic; 
signal Cout : std_logic; 
signal Sum:std_logic_vector(3 downto 0);

begin

fulladder_map : fulladder_4 port map (A => A, B => B, Cin => Cin, Cout => Cout, Sum => Sum );

test_proc : process 
begin
A<="0000";
B<="0111";
Cin<='0';
wait for 5 ns;
assert Cout='0' report "cout" severity error;
assert Sum="0111" report "Sum 1" severity error;

A<="1111";
B<="1111";
Cin<='1';
wait for 5 ns;
assert Cout='1' report "cout" severity error;
assert Sum="1111" report "Sum 2" severity error;

A<="1000";
B<="1000";
Cin<='1';
wait for 5 ns;
assert Cout='1' report "cout" severity error;
assert Sum="0001" report "Sum 3" severity error;

A<="1001";
B<="0001";
Cin<='1';
wait for 5 ns;
assert Cout='0' report "cout" severity error;
assert Sum="1011" report "Sum 4" severity error;
wait;
end process;

end architecture structural;





