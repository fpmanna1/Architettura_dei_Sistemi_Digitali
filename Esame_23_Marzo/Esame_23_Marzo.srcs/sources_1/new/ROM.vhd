library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity ROM is
    port(
        clock   :   in  std_logic;
        reset   :   in  std_logic;
        read    :   in  std_logic;
        addr    :   in  std_logic_vector(0 to 1); --la memoria è composta da 4 locazioni
        value_out   :   out std_logic_vector(0 to 7)
    );
end ROM;

architecture Behavioral of ROM is

type rom_type is array (0 to 3) of std_logic_vector(0 to 7);
type init_rom is array (0 to 3) of std_logic_vector(0 to 7);

signal ROM : rom_type;
signal values : init_rom := (
"11111010",
"11011111",
"11110000",
"00000000"
);

begin

process(clock)
begin
    if rising_edge(clock) then
        init: for i in 0 to 3 loop
            ROM(i) <= values(i);
        end loop init;
       if(reset = '1') then
            value_out <= ROM(0);
       elsif(READ = '1') then
            value_out <= ROM(to_integer(unsigned(addr)));
       end if;
    end if;           
end process;

end Behavioral;
