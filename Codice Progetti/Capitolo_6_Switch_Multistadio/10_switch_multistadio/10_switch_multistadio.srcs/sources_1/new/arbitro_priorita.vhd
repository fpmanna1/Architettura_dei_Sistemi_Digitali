library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity arbitro is
    port(
        enable00 : in  std_logic;
        enable01 : in  std_logic;
        enable10 : in  std_logic;
        enable11 : in  std_logic;
        y        : out std_logic_vector(0 to 1) 
    );
end arbitro;

architecture Dataflow of arbitro is

begin
    y <= "00" when enable00 = '1' else
         "01" when enable01 = '1' else
         "10" when enable10 = '1' else
         "11" when enable11 = '1' else
         "--";
end Dataflow;
