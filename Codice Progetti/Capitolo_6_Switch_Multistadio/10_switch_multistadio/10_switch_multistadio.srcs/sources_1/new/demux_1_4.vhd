library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity demux_1_4 is
    port (
        x  : in  std_logic_vector(0 to 1);
        s  : in  std_logic_vector(0 to 1);
        y0 : out std_logic_vector(0 to 1);
        y1 : out std_logic_vector(0 to 1);
        y2 : out std_logic_vector(0 to 1);
        y3 : out std_logic_vector(0 to 1)
    );
end demux_1_4;

architecture dataflow of demux_1_4 is

begin

    y0 <= x when s = "00" else (others => '-');
    y1 <= x when s = "01" else (others => '-');
    y2 <= x when s = "10" else (others => '-');
    y3 <= x when s = "11" else (others => '-');
end architecture dataflow;
