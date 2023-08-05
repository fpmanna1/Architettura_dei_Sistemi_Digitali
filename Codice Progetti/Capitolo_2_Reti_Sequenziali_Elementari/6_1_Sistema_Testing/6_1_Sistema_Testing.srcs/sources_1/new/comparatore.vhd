library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity comparatore is
    port(
        clock : in std_logic;
        en    : in std_logic;
        val1  : in std_logic_vector(0 to 2);
        val2  : in std_logic_vector(0 to 2);
        load  : in std_logic;
        y     : out std_logic
    );
end comparatore;

architecture Behavioral of comparatore is

signal temp1 : std_logic_vector(0 to 2) := "000";
signal temp2 : std_logic_vector(0 to 2) := "000";

begin
process(clock)
begin
    if rising_edge(clock) then
        if(load = '1') then
            temp1 <= val1;
            temp2 <= val2;
        elsif (en = '1') then
            if((temp1(0) = temp2(0)) AND (temp1(1) = temp2(1)) AND (temp1(2) = temp2(2))) then
               y <= '1';
            else
               y <= '0';
            end if;
         end if;
    end if;

end process;
end Behavioral;

