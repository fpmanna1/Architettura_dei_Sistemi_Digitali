library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_4_1 is
    port(
        input_a : in std_logic_vector(0 to 3); --vettore degli ingressi
        input_s : in std_logic_vector(1 downto 0); --vettore delle selezioni
        output_y : out std_logic --uscita
    );

end mux_4_1;

architecture rtl of mux_4_1 is

begin

    output_y <= input_a(0) when input_s = "00" else
         input_a(1) when input_s = "01" else
         input_a(2) when input_s = "10" else
         input_a(3) when input_s = "11" else
         '-';

end rtl;

