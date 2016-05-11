library ieee;
use ieee.std_logic_1164.all;

entity fulladder_4 is
   port (
     A   : in  std_logic_vector(3 downto 0);
     B   : in  std_logic_vector(3 downto 0);
     Cin : in  std_logic;
     Cout: out std_logic;
     Sum : out std_logic_vector(3 downto 0)
     );
end fulladder_4;

architecture structrual of fulladder_4 is
    
    component fulladder_1 is port (A:in std_logic; B:in std_logic; Cin:in std_logic; Cout:out std_logic; Sum:out std_logic);
    end component fulladder_1;
    
    component or_gate is port (x:in std_logic; y:in std_logic; z:out std_logic);
    end component or_gate;
    
    signal cout0_out,cout1_out,cout2_out,ze0_out,ze1_out:std_logic;
    
    begin
        
        cout0: fulladder_1 port map (A=>A(0),B=>B(0),Cin=>Cin,Cout=>cout0_out,Sum=>Sum(0));
        cout1: fulladder_1 port map (A=>A(1),B=>B(1),Cin=>cout0_out,Cout=>cout1_out,Sum=>Sum(1));
        cout2: fulladder_1 port map (A=>A(2),B=>B(2),Cin=>cout1_out,Cout=>cout2_out,Sum=>Sum(2));
        cout3: fulladder_1 port map (A=>A(3),B=>B(3),Cin=>cout2_out,Cout=>Cout,Sum=>Sum(3));
    
end architecture structrual;