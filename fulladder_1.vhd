library ieee;
use ieee.std_logic_1164.all;

entity fulladder_1 is
port (
  A   : in  std_logic;
  B   : in  std_logic;
  Cin : in  std_logic;
  Cout: out std_logic;
  Sum : out std_logic
);
end fulladder_1;

architecture fulladder_1_struct of fulladder_1 is

component xor_gate is port
(x: in  std_logic; y: in  std_logic; z: out std_logic);
end component xor_gate;

component and_gate is port
(x: in  std_logic; y: in  std_logic; z: out std_logic);
end component and_gate;

component or_gate is port
(x: in  std_logic; y: in  std_logic; z: out std_logic);
end component or_gate;

signal xor2_0_out,and2_0_out,and2_1_out,and2_2_out,or2_0_out:std_logic;

begin
xor2_0: xor_gate port map (x=>A,y=>B,z=>xor2_0_out);
xor2_1: xor_gate port map (x=>xor2_0_out,y=>Cin,z=>Sum);
and2_0: and_gate port map (x=>A,y=>B,z=>and2_0_out);
and2_1: and_gate port map (x=>A,y=>Cin,z=>and2_1_out);
and2_2: and_gate port map (x=>B,y=>Cin,z=>and2_2_out);
or2_0: or_gate port map (x=>and2_0_out,y=>and2_1_out,z=>or2_0_out);
or2_1: or_gate port map (x=>and2_2_out,y=>or2_0_out,z=>Cout);
end architecture fulladder_1_struct;

