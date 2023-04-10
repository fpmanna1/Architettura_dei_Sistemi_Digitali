library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RippleCarryAdder is
Port(
    
    a: in std_logic_vector (0 to 3);
    b: in std_logic_vector (0 to 3);
    c_in: in std_logic;
    c_out: out std_logic;
    s: out std_logic_vector (0 to 3)
  );
  
end RippleCarryAdder;

architecture Structural of RippleCarryAdder is 

component FullAdder is   
   Port ( 
      a: in std_logic;
      b: in std_logic;
      carry_in: in std_logic;
      carry_out: out std_logic;
      ris: out std_logic
  );
end component;

signal carry_temp: std_logic_vector(0 to 2);

begin
    F0: FullAdder port map(a(0), b(0), c_in, carry_temp(0), s(0));
    
    --F: for i in 1 to 2 generate
    --Fi:  FullAdder port map(a(i), b(i), carry_temp(i-1), carry_temp(i), s(i));
    
    F1 : FullAdder port map(a(1), b(1), carry_temp(0), carry_temp(1), s(1));
    F2 : FullAdder port map(a(2), b(2), carry_temp(1), carry_temp(2), s(2));
    
    F3:  FullAdder port map(a(3), b(3), carry_temp(2), c_out, s(3));
--end generate;
end Structural;