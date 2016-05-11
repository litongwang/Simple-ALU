library ieee;
use ieee.std_logic_1164.all;

entity fulladder_1_demo is
end fulladder_1_demo;

architecture structural of fulladder_1_demo is

component fulladder_1 is port (
                             A   : in  std_logic;
                             B   : in  std_logic;
                             Cin : in  std_logic;
                             Cout: out std_logic;
                             Sum : out std_logic
                           );
end component fulladder_1;

signal A : std_logic; signal B : std_logic; signal Cin : std_logic; signal Cout : std_logic; signal Sum : std_logic; 

begin
fulladder_map : fulladder_1 port map (A => A, B => B, Cin => Cin, Cout => Cout, Sum => Sum);

test_proc : process 
begin
A<='0';
B<='0';
Cin<='0';
wait for 5 ns;
assert Cout='0' report "cout" severity error;
assert Sum='0' report "Sum" severity error;

A<='0';
B<='1';
Cin<='1';
wait for 5 ns;
assert Cout='1' report "cout" severity error;
assert Sum='0' report "Sum" severity error;

A<='1';
B<='1';
Cin<='1';
wait for 5 ns;
assert Cout='1' report "cout" severity error;
assert Sum='1' report "Sum" severity error;

A<='1';
B<='1';
Cin<='0';
wait for 5 ns;
assert Cout='1' report "cout" severity error;
assert Sum='0' report "Sum" severity error;

A<='1';
B<='0';
Cin<='0';
wait for 5 ns;
assert Cout='0' report "cout" severity error;
assert Sum='1' report "Sum" severity error;

wait;
end process;

end architecture structural;


