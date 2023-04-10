library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Reg is
    Port(
        clock : in std_logic;
        reset : in std_logic;
        enable : in std_Logic;
        value_in : in std_logic_vector(0 to 4);
        value_out : out std_logic_vector(0 to 4)
    );
end Reg;

architecture Behavioral of Reg is

begin

process (clock, reset)
begin
    if reset = '1' then
        value_out <= (others => '0');
    end if;
    
    if rising_edge(clock) then
        if enable = '1' then
            value_out <= value_in;
        end if;
    end if;
end process;

end Behavioral;
