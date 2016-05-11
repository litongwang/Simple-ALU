library ieee;
use ieee.std_logic_1164.all;

entity compare is
    port (
    ctrl:in std_logic;
    arith:in std_logic;
    A:in std_logic;
    B:in std_logic;
    c:in std_logic;
    r_compare:out std_logic_vector(31 downto 0)
    );
end compare;

architecture structural of compare is 

component not_gate is port (x:in std_logic;z:out std_logic);
end component not_gate;

component and_gate is port (x:in std_logic;y:in std_logic;z:out std_logic);
end component and_gate;

component or_gate is port (x:in std_logic;y:in std_logic;z:out std_logic);
end component or_gate;

component mux_32 is port (sel   : in  std_logic;
                          src0  : in  std_logic_vector(31 downto 0);
                          src1  : in  std_logic_vector(31 downto 0);
                          z	   : out std_logic_vector(31 downto 0));
end component mux_32;


signal compare_1_out,compare_2_out:std_logic_vector (31 downto 0);
signal compare_01:std_logic_vector(30 downto 0);
signal c_n:std_logic;
signal B_n:std_logic;
signal ab_out:std_logic;
signal slt_input:std_logic;

begin
   b_negative: not_gate port map (x=>B,z=>B_n);
   ab: and_gate port map (x=>A,y=>B_n,z=>ab_out);
   slt_in: or_gate port map (x=>ab_out,y=>arith,z=>slt_input);
   c_negative: not_gate port map (x=>c,z=>c_n);
   c1:compare_01<="0000000000000000000000000000000"; 
   c2:compare_1_out<=compare_01&slt_input;
   c3:compare_2_out<=compare_01&c_n;
   result: mux_32 port map(sel=>ctrl,src0=>compare_1_out,src1=>compare_2_out,z=>r_compare);
 end architecture structural;
