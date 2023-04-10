library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Counter is
    Port(
        clock       :   in  std_logic;
        reset       :   in  std_logic;
        enable      :   in  std_logic;
        count_out   :   out std_logic_vector(0 to 2)
    );
end Counter;

architecture Behavioral of Counter is

begin

process(clock)
variable count : integer := 0;
begin
    if reset = '1' then
        count := 0;
    end if;
    if falling_edge(clock) then
        if enable = '1' then
            if count = 7 then
                count := 0;
            else
                count := count + 1;
            end if;
        end if;
    end if;
    count_out <= std_logic_vector(to_unsigned(count, 3));
end process;    

end Behavioral;
