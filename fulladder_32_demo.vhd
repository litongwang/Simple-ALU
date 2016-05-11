 library ieee;
 use ieee.std_logic_1164.all;
 
 entity fulladder_32_demo is
 end fulladder_32_demo;
 
 architecture structural of fulladder_32_demo is
 
 component fulladder_32 is port (
                              A   : in  std_logic_vector (31 downto 0);
                              B   : in  std_logic_vector (31 downto 0);
                              ctrl: in  std_logic_vector(1 downto 0);
                              Cout: out std_logic;
                              ovf : out std_logic;
                              Sum : out std_logic_vector (31 downto 0)
         
                            );
 end component fulladder_32;
   
 signal ctrl:  std_logic_vector (1 downto 0);
 signal A   :  std_logic_vector (31 downto 0);
 signal B   :  std_logic_vector (31 downto 0);
 signal cout:  std_logic;
 signal ovf :  std_logic;
 signal Sum :  std_logic_vector (31 downto 0);
 
 begin
 fulladder_map : fulladder_32 port map (A => A, B => B, ctrl => ctrl, Cout => Cout, ovf => ovf, Sum => Sum );

 test_proc : process 
 begin
 
A <= "00000000000000000000000000001000";
B <= "00000000000000000000000000000111";
ctrl  <=  "00";  --add A_P+B_P
wait for 5 ns;
assert Sum="00000000000000000000000000001111" report "add1" severity error;

A <= "11111111111111111111111111111001";
B <= "11111111111111111111111111110111";
ctrl  <=  "00";  --add A_N+B_N
wait for 5 ns;
assert Sum="11111111111111111111111111110000" report "add2" severity error;

A <= "01111111111111111110000000000000";
B <= "00000000000000000001111111111111";
ctrl  <=  "00";  --add A_P+B_P without overflow
wait for 5 ns;
assert Sum="01111111111111111111111111111111" report "add3" severity error;
assert ovf='0' report "overflow" severity error;

A <= "01111111111111111111111111111111";
B <= "00000000000000000000000000000001";
ctrl  <=  "00";  --add A_P+B_P with overflow
wait for 5 ns;
assert ovf='1' report "overflow" severity error;
assert Sum="10000000000000000000000000000000" report "add4" severity error;

A <= "11111111111111111111111111111111";
B <= "10000000000000000000000000000000";
ctrl  <=  "00";  --add A_N+B_N with overflow
wait for 5 ns;
assert ovf='1' report "overflow" severity error;
assert Sum="01111111111111111111111111111111" report "add5" severity error;

A <= "11111111111111111111111111111111";
B <= "10000000000000000000000000000001";
ctrl  <=  "00";  --add A_N+B_N without overflow
wait for 5 ns;
assert ovf='0' report "overflow" severity error;
assert sum="10000000000000000000000000000000" report "add6" severity error;
 
A <= "10000000000000000000000000000001";
B <= "11111111111111111111111111111111";
ctrl  <=  "00";  --add A_N+B_N with cout
wait for 5 ns;
assert cout='1' report "cout" severity error;
assert sum="10000000000000000000000000000000" report "add7" severity error;

A <= "01111111111111111111111111111111";
B <= "01111111111111111111111111111111";
ctrl  <=  "00";  --add A_P+B_P won't have cout, only will have ovf
wait for 5 ns;
assert cout='0' report "cout" severity error;
assert ovf='1' report "ovf" severity error; 
assert sum="11111111111111111111111111111110" report "add8" severity error;

A <= "11111111111111111111111111111110";
B <= "01111111111111111111111111111111";
ctrl  <=  "01";  --sub A_N-B_P with overflow
wait for 5 ns;
assert ovf='1' report "overflow" severity error;
assert sum="01111111111111111111111111111111" report "sub1" severity error;

A <= "11111111111111111111111111111111";
B <= "01111111111111111111111111111111";
ctrl  <=  "01";  --sub A_N-B_P without overflow
wait for 5 ns;
assert ovf='0' report "overflow" severity error;
assert sum="10000000000000000000000000000000" report "sub2" severity error;


A <= "01111111111111111111111111111111";
B <= "11111111111111111111111111111111";
ctrl  <=  "01";  --sub A_P-B_N with overflow
wait for 5 ns;
assert ovf='1' report "overflow" severity error;
assert sum="10000000000000000000000000000000" report "sub3" severity error;

A <= "01111111111111111111111111111110";
B <= "11111111111111111111111111111111";
ctrl  <=  "01";  --sub A_P-B_N without overflow
wait for 5 ns;
assert ovf='0' report "overflow" severity error;
assert sum="01111111111111111111111111111111" report "sub4" severity error;
 wait;
 end process;
 
 end architecture structural;
 
 
 
 
 
 