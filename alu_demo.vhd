 library ieee;
 use ieee.std_logic_1164.all;
 
 
 entity alu_demo is
 end alu_demo;
 
 architecture structural of alu_demo is
 component alu is port (
  ctrl: in std_logic_vector (3 downto 0);
  A   : in std_logic_vector (31 downto 0);
  B   : in std_logic_vector (31 downto 0);
  cout: out std_logic;
  ovf : out std_logic;
  ze  : out std_logic;
  R   : out std_logic_vector (31 downto 0));
 end component;

 signal ctrl:  std_logic_vector (3 downto 0);
 signal A   :  std_logic_vector (31 downto 0);
 signal B   :  std_logic_vector (31 downto 0);
 signal cout:  std_logic;
 signal ovf :  std_logic;
 signal ze  :  std_logic;
 signal R   :  std_logic_vector (31 downto 0);

 begin
     test_comp:alu
     
 port map(
            ctrl=> ctrl ,
            A   => A , 
            B   => B ,
            cout=> cout ,
            ovf => ovf ,
            ze  => ze ,
            R   => R 
          );
testbench: process

 
 begin

-- test AND  
A <= "00100000000000000000111111111111";
B <= "00100000000000000000111111000000";
ctrl  <=  "0100";  -- and
wait for 5 ns;
assert R= "00100000000000000000111111000000" report "and 1" severity error;

A <= "00100001010001011000101011101111";
B <= "11110110110110011001010010101100";
ctrl <= "0100";
wait for 5 ns;
assert R = "00100000010000011000000010101100" report "and 2" severity error;

-- test OR 
A <= "00000000000000000000111111111111";
B <= "00011111111111111111000000000000";
ctrl  <=  "0101";  -- or
wait for 5 ns;
assert R= "00011111111111111111111111111111" report "or 1" severity error;

A <= "00100001010001011000101011101111";
B <= "11110110110110011001010010101100";
ctrl <= "0101";
wait for 5 ns;
assert R = "11110111110111011001111011101111" report "or 2" severity error;

-- test xor
A <= "00111111111000000000000000000000";
B <= "01111111111111111111110000000111";
ctrl  <=  "0110";  -- xor
wait for 5 ns;
assert R= "01000000000111111111110000000111" report "xor" severity error;

A <= "00100001010001011000101011101111";
B <= "11110110110110011001010010101100";
ctrl <= "0110";
wait for 5 ns;
assert R = "11010111100111000001111001000011" report "xor 2" severity error;

-- test srl
A <= "11111000000000000000000000000000";
B <= "00000000000000000000000000000101";
ctrl  <=  "1010";  -- srl 5 bits
wait for 5 ns;
assert R= "00000111110000000000000000000000" report "srl 5" severity error;

A <= "10000000000000000000000000000000";
B <= "00000000000000000000000000011111";
ctrl  <=  "1010";  -- srl 31 bits
wait for 5 ns;
assert R= "00000000000000000000000000000001" report "srl 31" severity error;

A <= "10000000000000000000000000000000"; 
B <= "00000000000000000000000000000111"; 
wait for 5 ns; 
assert R="00000001000000000000000000000000" report "srl 7" severity error;
    
A <= "10000000000000000000000000000000"; 
B <= "00000000000000000000000000000001"; 
wait for 5 ns; 
assert R="01000000000000000000000000000000" report "srl 1" severity error;
     
A <= "00000000100000000000000100000000"; 
B <= "00000000000000000000000000001111"; 
wait for 5 ns; 
assert R="00000000000000000000000100000000" report "srl 15" severity error;
	  
A <= "00000000000000000000000000000111";
B <= "00000000000000000000000000001000";
ctrl  <=  "1100";  --slt A_P<B_P compare by arith
wait for 5 ns;
assert R= "00000000000000000000000000000001" report "slt 1" severity error;

A <= "10000000000000000000000000001000";
B <= "00000001111111111111111111101000";
ctrl  <=  "1100";  --slt A_N<B_P compare by the sign of A(31) and B(31)
wait for 5 ns;
assert R= "00000000000000000000000000000001" report "slt 2" severity error;

A <= "11111111111111111111111111111001";
B <= "11111111111111111111111111111110";
ctrl  <=  "1100";  --slt A_N=-7<B_N=-2  compare by arith(31)
wait for 5 ns;
assert R= "00000000000000000000000000000001" report "slt 3" severity error;

A <= "00000000000000000000000000001111";
B <= "00000000000000000000000000001000";
ctrl  <=  "1100";  --slt A_P>B_P  compare by arith(31)
wait for 5 ns;
assert R= "00000000000000000000000000000000" report "slt 4" severity error;

A <= "00000000000000000000000000001000";
B <= "10000001111111111111111111101000";
ctrl  <=  "1100";  --slt A_P>B_N 
wait for 5 ns;
assert R= "00000000000000000000000000000000" report "slt 5" severity error;

A <= "11111111111111111111111111111001";
B <= "11111111111111111111111111110111";
ctrl  <=  "1100";  --slt A_N=-7>B_N=-9
wait for 5 ns;
assert R= "00000000000000000000000000000000" report "slt 6" severity error;

A <= "00000000000000000000000000000111";
B <= "00000000000000000000000000000111";
ctrl  <=  "1100";  --slt A_P=B_P
wait for 5 ns;
assert R= "00000000000000000000000000000000" report "slt 7" severity error;

A <= "10000001111111111111111111101000";
B <= "10000001111111111111111111101000";
ctrl  <=  "1100";  --slt A_N=B_N 
wait for 5 ns;
assert R= "00000000000000000000000000000000" report "slt 8" severity error;

A <= "10000000000000000000000000000111";
B <= "10000000000000000000000000001000";
ctrl  <=  "1101";  --sltu A_P<B_P compare by cout
wait for 5 ns;
assert R= "00000000000000000000000000000001" report "sltu 1" severity error;

A <= "10000000000000000000000000001000";
B <= "10000000000000000000000000001000";
ctrl  <=  "1101";  --sltu A_P=B_P  compare by cout
wait for 5 ns;
assert R= "00000000000000000000000000000000" report "sltu 2" severity error;

A <= "10000000000000000000000000001000";
B <= "10000000000000000000000000000111";
ctrl  <=  "1101";  --sltu A_P>B_P  compare by cout
wait for 5 ns;
assert R= "00000000000000000000000000000000" report "sltu 3" severity error;

-- test add

A <= "00000000000000000000000000001000";
B <= "00000000000000000000000000000111";
ctrl  <=  "0000";  --add A_P+B_P
wait for 5 ns;
assert R="00000000000000000000000000001111" report "add 1" severity error;

A <= "11111111111111111111111111111001";
B <= "11111111111111111111111111110111";
ctrl  <=  "0000";  --add A_N+B_N
wait for 5 ns;
assert R="11111111111111111111111111110000" report "add 2" severity error;

A <= "00111101000000001011011000010101";
B <= "00111110101000011010111010110000";
ctrl <= "0000";
wait for 10 ns;
assert R = "01111011101000100110010011000101" report "add 3" severity error;
assert cout = '0' report "cout 0" severity error;
assert ovf = '0' report "ovf 0" severity error;
assert ze = '0' report "ze 0" severity error;

A <= "01111111111111111110000000000000";
B <= "00000000000000000001111111111111";
ctrl  <=  "0000";  --add A_P+B_P without overflow
wait for 5 ns;
assert ovf='0' report "overflow" severity error;

A <= "01111111111111111111111111111111";
B <= "00000000000000000000000000000001";
ctrl  <=  "0000";  --add A_P+B_P with overflow
wait for 5 ns;
assert ovf='1' report "overflow" severity error;

A <= "11111111111111111111111111111111";
B <= "10000000000000000000000000000000";
ctrl  <=  "0000";  --add A_N+B_N with overflow
wait for 5 ns;
assert ovf='1' report "overflow" severity error;

A <= "11111111111111111111111111111111";
B <= "10000000000000000000000000000001";
ctrl  <=  "0000";  --add A_N+B_N without overflow
wait for 5 ns;
assert ovf='0' report "overflow" severity error;

A <= "10000000000000000000000000000001";
B <= "01111111111111111111111111111111";
ctrl  <=  "0000";  --add A_N+B_P with cout and ze
wait for 5 ns;
assert cout='1' report "cout" severity error;
assert ze='1' report "ze" severity error;

A <= "10000000000000000000000000000001";
B <= "11111111111111111111111111111111";
ctrl  <=  "0000";  --add A_N+B_N with cout
wait for 5 ns;
assert cout='1' report "cout" severity error;

A <= "01111111111111111111111111111111";
B <= "01111111111111111111111111111111";
ctrl  <=  "0000";  --add A_P+B_P won't have cout, only will have ovf
wait for 5 ns;
assert cout='0' report "cout" severity error;
assert ovf='1' report "ovf" severity error;

-- test sub

A <= "00000000000000000000000000001000";
B <= "00000000000000000000000000000111";
ctrl  <=  "0010";  --sub A_P-B_P>0
wait for 5 ns;
assert R="00000000000000000000000000000001" report "sub 1" severity error;

A <= "00000000000000000000000000000011";
B <= "00000000000000000000000000000111";
ctrl  <=  "0010";  --sub A_P-B_P<0
wait for 5 ns;
assert R="11111111111111111111111111111100" report "sub 2" severity error;

A <= "11111111111111111111111111111011";
B <= "00000000000000000000000000000111";
ctrl  <=  "0010";  --sub A_N-B_P<0
wait for 5 ns;
assert R="11111111111111111111111111110100" report "sub 3" severity error;

A <= "11111111111111111111111111111110";
B <= "01111111111111111111111111111111";
ctrl  <=  "0010";  --sub A_N-B_P with overflow
wait for 5 ns;
assert ovf='1' report "overflow" severity error;

A <= "11111111111111111111111111111111";
B <= "01111111111111111111111111111111";
ctrl  <=  "0010";  --sub A_N-B_P without overflow
wait for 5 ns;
assert ovf='0' report "overflow" severity error;

A <= "01111111111111111111111111111111";
B <= "11111111111111111111111111111111";
ctrl  <=  "0010";  --sub A_P-B_N with overflow
wait for 5 ns;
assert ovf='1' report "overflow" severity error;

A <= "01111111111111111111111111111110";
B <= "11111111111111111111111111111111";
ctrl  <=  "0010";  --sub A_P-B_N without overflow
wait for 5 ns;
assert ovf='0' report "overflow" severity error;

A <= "10000000000000000000001111111111";
B <= "10000000000000000000001111111111";
ctrl  <=  "0010";  --sub A_N-B_N with cout
wait for 5 ns;
assert cout='1' report "cout" severity error;

A <= "10000000000000000000001111111111";
B <= "01111111111111111111110000000001";
ctrl  <=  "0010";  --sub A_N-B_P with cout and ovf
wait for 5 ns;
assert cout='1' report "cout" severity error;
assert ovf='1' report "ovf" severity error;

-- test ze

A <= "00000000000000000000000000001111";
B <= "11111111111111111111111111110001";
ctrl  <=  "0000";  --add test ze
wait for 5 ns;
assert ze='1' report "ze" severity error;

A <= "10000000000000000000000000000111";
B <= "10000000000000000000000000000111";
ctrl  <=  "0010";  --sub test ze
wait for 5 ns;
assert ze='1' report "ze" severity error;
	
wait;
end process;
end structural;