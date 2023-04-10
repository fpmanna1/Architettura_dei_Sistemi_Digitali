library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity memory is
    Port(
        clock       :   in  std_logic;
        reset       :   in  std_logic;
        write       :   in  std_logic;
        addr        :   in  std_logic_vector(0 to 2);
        value_in    :   in  std_logic_vector(0 to 4) -- somma
    );
end memory;

architecture Behavioral of memory is

type mem_type is array (0 to 7) of std_logic_vector(0 to 4);
signal MEM : mem_type;

begin

process(clock)
begin 
    if rising_edge(clock) then
        if reset = '1' then
            init : for i in 0 to 7 loop
                MEM(i) <= (others => '0');
            end loop init;
        end if;
        if write = '1' then
            MEM(to_integer(unsigned(addr))) <= value_in;
        end if;
    end if;
end process;

end Behavioral;
