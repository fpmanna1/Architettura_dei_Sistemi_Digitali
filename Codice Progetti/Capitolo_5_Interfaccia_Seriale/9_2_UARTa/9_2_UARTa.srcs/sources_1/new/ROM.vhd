library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity ROM is
    port(
        clock       :   in  std_logic;
        reset       :   in  std_logic;
        read        :   in  std_logic;
        addr        :   in  std_logic_vector(0 to 2); --la memoria è composta da 8 locazioni
        value_out   :   out std_logic_vector(7 downto 0)
    );
end ROM;

architecture Behavioral of ROM is

type rom_type is array (0 to 7) of std_logic_vector(7 downto 0);
type init_rom is array (0 to 7) of std_logic_vector(7 downto 0);

signal ROM_t : rom_type;
signal value : init_rom := (
"11001100", 
"10011010",
"11001100",
"11010011",
"00110101",
"01110111",
"11111000",
"00001111"
);

begin

process(clock)
begin
    if rising_edge(clock) then
        init: for i in 0 to 7 loop
            ROM_t(i) <= value(i);
        end loop init;
       if(reset = '1') then
            value_out <= ROM_t(0);
       elsif(read = '1') then
            value_out <= ROM_t(to_integer(unsigned(addr)));
       end if;
    end if;           
end process;

end Behavioral;
