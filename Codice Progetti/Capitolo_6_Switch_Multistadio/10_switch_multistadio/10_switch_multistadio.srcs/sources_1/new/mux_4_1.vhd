library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_4_1 is
        port(
            x0 : in  std_logic_vector(0 to 1);
            x1 : in  std_logic_vector(0 to 1);
            x2 : in  std_logic_vector(0 to 1);
            x3 : in  std_logic_vector(0 to 1);
            s  : in  std_logic_vector(0 to 1);
            Y  : out std_logic_vector(0 to 1)
            );
end mux_4_1;

architecture dataflow of mux_4_1 is

begin
    with s select
    Y <= X0 when "00",
         X1 when "01",
         X2 when "10",
         X3 when "11",
         "00" when others;
         
end dataflow;
