library ieee;
use ieee.std_logic_1164.all;

entity logicmath is
   port (
     A   : in  std_logic_vector(31 downto 0);
     B   : in  std_logic_vector(31 downto 0);
     ctrl : in  std_logic_vector(1 downto 0);
     r_logic : out std_logic_vector(31 downto 0)
     );
end logicmath;

architecture structrual of logicmath is
    
    component and_gate_32 is port (
    x:in std_logic_vector(31 downto 0); 
    y:in std_logic_vector(31 downto 0); 
    z:out std_logic_vector(31 downto 0)); 
    end component and_gate_32;
    
    component xor_gate_32 is port (
        x:in std_logic_vector(31 downto 0); 
        y:in std_logic_vector(31 downto 0); 
        z:out std_logic_vector(31 downto 0)); 
    end component xor_gate_32;
        
    component or_gate_32 is port (
        x:in std_logic_vector(31 downto 0); 
        y:in std_logic_vector(31 downto 0); 
        z:out std_logic_vector(31 downto 0)); 
    end component or_gate_32;
    
    component mux_32 is port (sel   : in  std_logic;
                              src0  : in  std_logic_vector(31 downto 0);
                              src1  : in  std_logic_vector(31 downto 0);
                              z	   : out std_logic_vector(31 downto 0));
                          end component mux_32;
    
    signal and_out,xor_out,or_out,sel1,sel2:std_logic_vector(31 downto 0);
    
    begin
        
        andout: and_gate_32 port map (x=>A,y=>B,z=>and_out);
        xorout: xor_gate_32 port map (x=>A,y=>B,z=>xor_out);
        orout : or_gate_32  port map (x=>A,y=>B,z=>or_out);
        result_sel1: mux_32 port map (sel=>ctrl(0),src0=>and_out,src1=>or_out,z=>sel1);
        result_sel2: mux_32 port map (sel=>ctrl(0),src0=>xor_out,src1=>or_out,z=>sel2);
        result_sel3: mux_32 port map (sel=>ctrl(1),src0=>sel1,src1=>sel2,z=>r_logic);
      
        
end architecture structrual;