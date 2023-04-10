library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_2_1 is
port(
    x0 : in  std_logic_vector(0 to 1);
    x1 : in std_logic_vector(0 to 1);
    s : in  std_logic;
    y : out std_logic_vector(0 to 1)
);
end mux_2_1;

architecture Dataflow of mux_2_1 is
begin
  with s select
    Y <= x0 when '0',
         x1 when '1',
         "00" when others;
end Dataflow;

