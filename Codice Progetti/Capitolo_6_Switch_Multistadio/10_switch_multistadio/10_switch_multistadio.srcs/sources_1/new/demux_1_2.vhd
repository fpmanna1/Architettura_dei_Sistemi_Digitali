library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity demux_1_2 is
    port(
        x : in  std_logic_vector(0 to 1);
        s : in  std_logic;
        y0 : out std_logic_vector(0 to 1);
        y1 : out std_logic_vector(0 to 1)
    );
end demux_1_2;

architecture Dataflow of demux_1_2 is
begin
  y0 <= x when s = '0' else "00";
  y1 <= x when s = '1' else "00" ;
            
end Dataflow;

