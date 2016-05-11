library ieee;
use ieee.std_logic_1164.all;

entity ze_32 is
port( 
A   : in  std_logic_vector(31 downto 0);
ze  : out std_logic
);
end ze_32;

architecture structrual of ze_32 is

component or_gate is port(x   : in  std_logic;
                          y   : in  std_logic;
                          z   : out std_logic);
end component or_gate;

component not_gate is port (
   x:in std_logic;
   z:out std_logic
  );
end component not_gate;

signal c1:std_logic_vector(15 downto 0);
signal c2:std_logic_vector(7 downto 0);
signal c3:std_logic_vector(3 downto 0);
signal c4:std_logic_vector(1 downto 0);
signal ze_out:std_logic;

begin
    
G1:for i in 0 to 15 generate
g11:or_gate port map (x=>A(i), y=>A(i+16), z=>c1(i)); 
END GENERATE;

G2:for n in 0 to 7 generate
g12:or_gate port map (x=>c1(n), y=>c1(n+8), z=>c2(n)); 
end generate;

G3:for m in 0 to 3 generate
g13:or_gate port map (x=>c2(m), y=>c2(m+4), z=>c3(m)); 
end generate;

G4:for k in 0 to 1 generate
g14:or_gate port map (x=>c3(k), y=>c3(k+2), z=>c4(k)); 
end generate;  

G5: or_gate port map(x=>c4(0),y=>c4(1),z=>ze_out);

G6: not_gate port map(x=>ze_out,z=>ze);
 
end architecture structrual;