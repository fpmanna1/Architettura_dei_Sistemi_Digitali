library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity m_comb is
    port(
        input  : in std_logic_vector(0 to 3);
        output : out std_logic_vector(0 to 2)
    );
end m_comb;

architecture dataflow of m_comb is
begin

    output(0) <= input(0) AND input(1) AND input(2) AND input(3);
    output(1) <= input(0) OR  input(1) OR  input(2) OR  input(3);
    output(2) <= input(0) XOR input(1) XOR input(2) XOR input(3);
    
    
end dataflow;
