library ieee;
use ieee.std_logic_1164.all;

entity compare_demo is
end compare_demo;

architecture structural of compare_demo is 

component compare is port ( 
    ctrl:in std_logic;
    arith:in std_logic;
    A:in std_logic;
    B:in std_logic;
    c:in std_logic;
    r_compare:out std_logic_vector(31 downto 0)
    );
end component compare;


signal ctrl:std_logic;
signal arith:std_logic;
signal A:std_logic;
signal B:std_logic;
signal c:std_logic;
signal r_compare:std_logic_vector(31 downto 0);

begin

 compare_map: compare port map( ctrl=>ctrl, arith=>arith, A=>A, B=>B,c=>c,r_compare=>r_compare);

test_proc : process 
begin
ctrl<='0';
arith<='0';
A<='0';
B<='0';
c<='0';
wait for 5 ns;
assert r_compare="00000000000000000000000000000000" report "slt 1" severity error;

ctrl<='0';
arith<='1';
A<='0';
B<='0';
c<='0';
wait for 5 ns;
assert r_compare="00000000000000000000000000000001" report "slt 2" severity error;

ctrl<='0';
arith<='0';
A<='1';
B<='0';
c<='0';
wait for 5 ns;
assert r_compare="00000000000000000000000000000001" report "slt 3" severity error;

ctrl<='0';
arith<='0';
A<='0';
B<='0';
c<='0';
wait for 5 ns;
assert r_compare="00000000000000000000000000000000" report "slt 1" severity error;

ctrl<='1';
arith<='0';
A<='0';
B<='0';
c<='0';
wait for 5 ns;
assert r_compare="00000000000000000000000000000001" report "sltu 1" severity error;

ctrl<='1';
arith<='0';
A<='0';
B<='0';
c<='1';
wait for 5 ns;
assert r_compare="00000000000000000000000000000000" report "sltu 2" severity error;

wait;
end process;
 end architecture structural;