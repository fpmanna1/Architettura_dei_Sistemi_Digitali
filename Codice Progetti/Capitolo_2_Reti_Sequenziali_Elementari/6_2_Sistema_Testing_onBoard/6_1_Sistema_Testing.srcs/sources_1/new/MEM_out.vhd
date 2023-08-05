library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity MEM_out is
    port(
        clock : in std_logic;
        reset : in std_logic;
        write : in std_logic;
        addr  : in std_logic_vector(0 to 2);
        value : in std_logic_vector(0 to 2)
    );

end MEM_out;

architecture Behavioral of MEM_out is

type mem_type is array (0 to 7) of std_logic_vector(0 to 2);
signal MEM : mem_type;

begin
process(clock)
begin
    if rising_edge(clock) then
        if(reset = '1') then
            init: for i in 0 to 7 loop
                MEM(i) <= "000";
            end loop init;
        end if;
        if(write = '1') then
            MEM(to_integer(unsigned(addr))) <= value;
        end if;
     end if;

end process;
end Behavioral;

