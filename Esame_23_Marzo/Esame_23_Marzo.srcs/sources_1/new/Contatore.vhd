library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;
use ieee.std_logic_unsigned.all;

entity Counter is
    Generic(
        M : integer := 8
    );
    Port(
        clock   :   in  std_logic;
        reset   :   in  std_logic;
        enable  :   in  std_logic;
        count   :   out std_logic_vector(0 to integer(ceil(log2(real(M))))-1);
        fine    :   out std_logic
    );
end Counter;

architecture Behavioral of Counter is

begin

process(clock)
variable count_tmp : integer := 0;
begin
    if reset = '1' then
        count_tmp := 0;
        fine <= '0';
    end if;
    if falling_edge(clock) then
        if enable = '1' then
            if count_tmp = M-1 then
                count_tmp := 0;
                fine <= '1';
            else
                count_tmp := count_tmp + 1;
                fine <= '0';
            end if;
        end if;
    end if;
    count <= std_logic_vector(to_unsigned(count_tmp, integer(ceil(log2(real(M))))));
end process;    

end Behavioral;
