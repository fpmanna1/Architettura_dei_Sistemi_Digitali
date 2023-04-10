library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity ROM_in is
    port(
        clock       :   in  std_logic;
        reset       :   in  std_logic;
        read        :   in  std_logic;
        addr        :   in  std_logic_vector(0 to 2); --la memoria è composta da 8 locazioni
        value_out   :   out std_logic_vector(0 to 3)
    );
end ROM_in;

architecture Behavioral of ROM_in is

type rom_type is array (0 to 7) of std_logic_vector(0 to 3);
type init_rom is array (0 to 7) of std_logic_vector(0 to 3);

signal ROM : rom_type;
signal value : init_rom := (
"0000", 
"1001",
"1100",
"1101",
"0011",
"0111",
"1111",
"1010"
);

begin

process(clock)
begin
    if rising_edge(clock) then
        init: for i in 0 to 7 loop
            ROM(i) <= value(i);
        end loop init;
       if(reset = '1') then
            value_out <= ROM(0);
       elsif(READ = '1') then
            value_out <= ROM(to_integer(unsigned(addr)));
       end if;
    end if;           
end process;

end Behavioral;