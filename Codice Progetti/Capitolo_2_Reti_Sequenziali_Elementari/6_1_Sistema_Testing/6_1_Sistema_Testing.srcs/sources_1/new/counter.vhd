library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
		   enable : in STD_LOGIC; --questo è l'enable del clock, insieme danno l'impulso di conteggio
           counter : out  STD_LOGIC_VECTOR (0 to 2);
           uscita : out STD_LOGIC
           );
end counter;

architecture Behavioral of counter is

begin

process(clock,reset,enable)
variable count: integer  := 0;
    begin
        if(reset = '1') then
            count := 0;
            uscita <= '0';
        end if;
        if falling_edge(clock) then
            if(enable = '1') then
                if(count = 7) then
                    count := 0;
                    uscita <= '1';
                else 
                    count := count +1;
                    uscita <= '0';
                end if;
          end if;
       end if;
       counter <= std_logic_vector(to_unsigned(count, 3)); -- casting da decimale a binario
end process;
end Behavioral;


