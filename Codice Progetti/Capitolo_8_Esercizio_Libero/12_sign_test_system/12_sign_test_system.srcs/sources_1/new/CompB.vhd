library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity CompB is
    Port(
        enable : in std_logic;
        sum_in : in std_logic_vector(0 to 4);
        res : out std_logic
    );
    
end CompB; 

architecture Behavioral of CompB is

begin
process(sum_in)
variable var : integer := 0;

begin
    var := to_integer(signed(sum_in));
    
    if var < 0 then
        res <= '1';
    else
        res <= '0';
    end if;

end process;

end Behavioral;