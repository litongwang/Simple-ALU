library ieee;
use ieee.std_logic_1164.all;

entity shifter is
    port (
    A:in std_logic_vector(31 downto 0);
    B:in std_logic_vector(4 downto 0);
    shift:out std_logic_vector(31 downto 0)
    );
end shifter;

architecture structural of shifter is
    
    component mux_32 is
    port (
                       sel   : in  std_logic;
                       src0  : in  std_logic_vector(31 downto 0);
                       src1  : in  std_logic_vector(31 downto 0);
                       z	   : out std_logic_vector(31 downto 0)
                      );
                  end component;

    signal shift1_out:std_logic_vector(31 downto 0);
    signal shift2_out:std_logic_vector(31 downto 0);
    signal shift4_out:std_logic_vector(31 downto 0);
    signal shift8_out:std_logic_vector(31 downto 0);
    signal shift16_out:std_logic_vector(31 downto 0);
    signal c1: std_logic_vector(31 downto 0);
    signal c2: std_logic_vector(31 downto 0);
    signal c4: std_logic_vector(31 downto 0);
    signal c8: std_logic_vector(31 downto 0);
    signal c16: std_logic_vector(31 downto 0);
    signal cc: std_logic_vector(15 downto 0);
    
    begin
    cc<="0000000000000000";   
    c1<=cc(0)&A(31 downto 1);
    c2<=cc(1 downto 0)&shift1_out(31 downto 2);
    c4<=cc(3 downto 0)&shift2_out(31 downto 4);
    c8<=cc(7 downto 0)&shift4_out(31 downto 8);
    c16<=cc(15 downto 0)&shift8_out(31 downto 16);
        
    shift1: mux_32 port map (sel=>B(0),src0=>A(31 downto 0),src1=>c1,z=>shift1_out);
    shift2: mux_32 port map (sel=>B(1),src0=>shift1_out(31 downto 0),src1=>c2,z=>shift2_out);
    shift4: mux_32 port map (sel=>B(2),src0=>shift2_out(31 downto 0),src1=>c4,z=>shift4_out);
    shift8: mux_32 port map (sel=>B(3),src0=>shift4_out(31 downto 0),src1=>c8,z=>shift8_out);
    shift16: mux_32 port map (sel=>B(4),src0=>shift8_out(31 downto 0),src1=>c16,z=>shift);
    
end architecture structural;
    
    