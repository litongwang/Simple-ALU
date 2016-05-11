library ieee;
    use ieee.std_logic_1164.all;

entity alu is
    port(
        ctrl: in std_logic_vector (3 downto 0);
        A   : in std_logic_vector (31 downto 0);
        B   : in std_logic_vector (31 downto 0);
        cout: out std_logic;
        ovf : out std_logic;
        ze  : out std_logic;
        R   : out std_logic_vector (31 downto 0)
        );
    end alu;
    
    architecture structural of alu is
    
    component ze_32 is port (A:in std_logic_vector(31 downto 0);ze:out std_logic);
    end component;
    
    component shifter is port ( A:in std_logic_vector(31 downto 0);
                              B:in std_logic_vector(4 downto 0);
                              shift:out std_logic_vector(31 downto 0));
    end component shifter;
    
    component logicmath is port(A   : in  std_logic_vector(31 downto 0);
                                B   : in  std_logic_vector(31 downto 0);
                                ctrl: in  std_logic_vector(1 downto 0);
                                r_logic : out std_logic_vector(31 downto 0));
    end component logicmath;
    
    
    component fulladder_32 is port (A   : in  std_logic_vector(31 downto 0);
                                    B   : in  std_logic_vector(31 downto 0);
                                    ctrl: in  std_logic_vector(1 downto 0);
                                    Cout: out std_logic;
                                    Sum : out std_logic_vector(31 downto 0);
                                    ovf : out std_logic
                                    );
    end component fulladder_32;
    
    component and_gate_32 is port ( x   : in  std_logic_vector(31 downto 0);
                                    y   : in  std_logic_vector(31 downto 0);
                                    z   : out std_logic_vector(31 downto 0)
                                    );
    end component and_gate_32;
    
    component or_gate_32 is port ( x   : in  std_logic_vector(31 downto 0);
                                   y   : in  std_logic_vector(31 downto 0);
                                   z   : out std_logic_vector(31 downto 0)
                                   );
    end component or_gate_32;
    
    component xor_gate_32 is port ( x   : in  std_logic_vector(31 downto 0);
                                    y   : in  std_logic_vector(31 downto 0);
                                    z   : out std_logic_vector(31 downto 0)
                                    );
    end component xor_gate_32;
    
    component not_gate_32 is port ( x   : in  std_logic_vector(31 downto 0);
                                    z   : out std_logic_vector(31 downto 0));
    end component not_gate_32;
    
    component mux is port (sel	  : in	std_logic;
                           src0  :	in	std_logic;
                           src1  :	in	std_logic; 
                           z	    : out std_logic
                           );
    end component mux;
    
    component mux_32 is port (sel   : in  std_logic;
                              src0  : in  std_logic_vector(31 downto 0);
                              src1  : in  std_logic_vector(31 downto 0);
                              z	    : out std_logic_vector(31 downto 0)
                              );
    end component mux_32;
    
    component compare is port(
              ctrl:in std_logic;
              arith:in std_logic;
              A:in std_logic;
              B:in std_logic;
              c:in std_logic;
              r_compare:out std_logic_vector(31 downto 0)
              );
    end component compare;
   
   
    signal shift_r: std_logic_vector(31 downto 0);
    signal logic_r: std_logic_vector(31 downto 0);
    signal arith_r: std_logic_vector(31 downto 0);
    signal compare_r: std_logic_vector(31 downto 0); 
    signal mux1: std_logic_vector(31 downto 0);
    signal mux2: std_logic_vector(31 downto 0);
    signal cout1: std_logic;
   
    begin
       shift_out: shifter port map (A=>A,B=>B(4 downto 0),shift=>shift_r);
       logic_out: logicmath port map(A=>A,B=>B,ctrl=>ctrl(1 downto 0),r_logic=>logic_r);
       arith_out: fulladder_32 port map(A=>A,B=>B,ctrl=>ctrl(2 downto 1),Cout=>cout1,ovf=>ovf,Sum=>arith_r);
       compare_out: compare port map(ctrl=>ctrl(0),arith=>arith_r(31),A=>A(31),B=>B(31),c=>cout1,r_compare=>compare_r);
       result1: mux_32 port map(sel=>ctrl(3),src0=>arith_r,src1=>shift_r,z=>mux1);
       result2: mux_32 port map(sel=>ctrl(3),src0=>logic_r,src1=>compare_r,z=>mux2);
       result:  mux_32 port map(sel=>ctrl(2),src0=>mux1,src1=>mux2,z=>R);
       ze_out:  ze_32 port map(A=>arith_r,ze=>ze);
       cout_r: Cout<=cout1;
         
end architecture structural;        