library ieee;
use ieee.std_logic_1164.all;

entity fulladder_32 is
   port( 
     A   : in  std_logic_vector(31 downto 0);
     B   : in  std_logic_vector(31 downto 0);
     ctrl: in  std_logic_vector(1 downto 0);
     Cout: out std_logic;
     Sum : out std_logic_vector(31 downto 0);
     ovf : out std_logic
     );
end fulladder_32;

architecture structrual of fulladder_32 is
    
    component fulladder_4 is port (
    A:in std_logic_vector(3 downto 0); 
    B:in std_logic_vector(3 downto 0); 
    Cin:in std_logic; 
    Cout:out std_logic; 
    Sum:out std_logic_vector(3 downto 0));
    end component fulladder_4;
    
    component fulladder_1 is port (
        A:in std_logic;
        B:in std_logic;
        Cin:in std_logic;
        Cout: out std_logic;
        Sum:out std_logic);
    end component fulladder_1;
    
    component xor_gate is port (
        x:in std_logic;
        y:in std_logic;
        z:out std_logic);
    end component xor_gate;
    
    component or_gate is port (
        x:in std_logic;
        y:in std_logic;
        z:out std_logic);
    end component or_gate;
    
    component not_gate_32 is port(
         x   : in  std_logic_vector(31 downto 0);
         z   : out std_logic_vector(31 downto 0)
         );
     end component not_gate_32;
     
     component mux_32 is port(
          sel	  : in	std_logic;
          src0  :	in	std_logic_vector(31 downto 0);
          src1  :	in	std_logic_vector(31 downto 0); 
          z	  : out std_logic_vector(31 downto 0)
          );
      end component mux_32;
      
      component mux is port(sel	  : in	std_logic;
                            src0  :	in	std_logic;
                            src1  :	in	std_logic; 
                            z	  : out std_logic
                            );
                        end component mux;
          
    
    signal cout0_out,cout1_out,cout2_out,cout3_out,cout4_out,cout5_out,cout6_out,cout7_out,cout8_out,cout9_out,cout10_out:std_logic;
    signal add_sub:std_logic;
    signal B_n:std_logic_vector(31 downto 0);
    signal B_in:std_logic_vector(31 downto 0);
    signal c_in:std_logic;
    
    begin
        negativeb: not_gate_32 port map(x=>B,z=>B_n);
        B_in_final:mux_32 port map(sel=>add_sub,src0=>B,src1=>B_n,z=>B_in);
        add_sub_choose: or_gate port map (x=>ctrl(1),y=>ctrl(0),z=>add_sub);
        cout0: fulladder_4 port map (A=>A(3 downto 0),B=>B_in(3 downto 0),Cin=>add_sub,Cout=>cout0_out,Sum=>Sum(3 downto 0));
        cout1: fulladder_4 port map (A=>A(7 downto 4),B=>B_in(7 downto 4),Cin=>cout0_out,Cout=>cout1_out,Sum=>Sum(7 downto 4));
        cout2: fulladder_4 port map (A=>A(11 downto 8),B=>B_in(11 downto 8),Cin=>cout1_out,Cout=>cout2_out,Sum=>Sum(11 downto 8));
        cout3: fulladder_4 port map (A=>A(15 downto 12),B=>B_in(15 downto 12),Cin=>cout2_out,Cout=>cout3_out,Sum=>Sum(15 downto 12));
        cout4: fulladder_4 port map (A=>A(19 downto 16),B=>B_in(19 downto 16),Cin=>cout3_out,Cout=>cout4_out,Sum=>Sum(19 downto 16));
        cout5: fulladder_4 port map (A=>A(23 downto 20),B=>B_in(23 downto 20),Cin=>cout4_out,Cout=>cout5_out,Sum=>Sum(23 downto 20));
        cout6: fulladder_4 port map (A=>A(27 downto 24),B=>B_in(27 downto 24),Cin=>cout5_out,Cout=>cout6_out,Sum=>Sum(27 downto 24));
        cout7: fulladder_1 port map (A=>A(28),B=>B_in(28),Cin=>cout6_out,Cout=>cout7_out,Sum=>Sum(28));
        cout8: fulladder_1 port map (A=>A(29),B=>B_in(29),Cin=>cout7_out,Cout=>cout8_out,Sum=>Sum(29));
        cout9: fulladder_1 port map (A=>A(30),B=>B_in(30),Cin=>cout8_out,Cout=>cout9_out,Sum=>Sum(30));
        cout10:fulladder_1 port map (A=>A(31),B=>B_in(31),Cin=>cout9_out,Cout=>cout10_out,Sum=>Sum(31));
        overflow: xor_gate port map (x=>cout9_out,y=>cout10_out,z=>ovf);
        coutf: Cout<=cout10_out;
        
end architecture structrual;