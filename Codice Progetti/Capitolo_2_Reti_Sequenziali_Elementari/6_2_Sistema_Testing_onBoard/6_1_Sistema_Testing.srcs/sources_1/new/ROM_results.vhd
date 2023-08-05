library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity ROM_results is

--questo componente contiene i risultati attesi dalla macchina combinatoria
--andranno confrontati con i reali valori di uscita della macchina comb.

    port(
        clock : in std_logic;
        reset : in std_logic;
        read : in std_logic;
        addr : in std_logic_vector(0 to 2);
        y : out std_logic_vector(0 to 2)
    );

end ROM_results;

architecture Behavioral of ROM_results is

type rom_type is array (0 to 7) of std_logic_vector(0 to 2);
type init_rom is array (0 to 7) of std_logic_vector(0 to 2);


signal ROM : rom_type;
signal value : init_rom := (
"000", 
"111", -- 010
"010",
"011", 
"010",
"011",
"110",
"010"
);

begin

process(clock)
begin
    if rising_edge(clock) then
        init: for i in 0 to 7 loop
                ROM(i) <= value(i);
         end loop init;
       if(read = '1') then
            y <= ROM(to_integer(unsigned(addr)));
       end if;
    end if;           
end process;
end Behavioral;
