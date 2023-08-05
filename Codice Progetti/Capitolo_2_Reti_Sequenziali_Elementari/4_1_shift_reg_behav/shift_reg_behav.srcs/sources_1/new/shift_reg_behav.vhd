library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_reg_behav is
    port(
        clock : in std_logic;
        rst : in std_logic;
        dir : in std_logic; --destra o sinistra
        mode : in std_logic; --shift di un bit o due bit
        ing : in std_logic;
        y : out std_logic_vector(0 to 3);
        en : in std_logic
        );

end shift_reg_behav;

architecture Behavioral of shift_reg_behav is 

signal lastEn : std_logic := '0';
signal temp : std_logic_vector(0 to 3) := "0000";

begin
process(clock)
    begin
        
    if rising_edge(clock) then
        if(rst = '1') then
            y(0 to 3) <= "0000";
        elsif(en = '1' and lastEn = '0') then
            if (dir = '0' and mode = '0') then --shift di un bit verso destra
            temp(0) <= ing;
            temp(1) <= temp(0);
            temp(2) <= temp(1);
            temp(3) <= temp(2);
        elsif(dir = '0' and mode = '1') then --shift di due bit verso destra
            temp(0) <= '0';
            temp(1) <= ing;
            temp(2) <= temp(1);
            temp(3) <= temp(2);
        elsif(dir = '1' and mode = '0') then --shift di un bit verso sx
            temp(3) <= ing;
            temp(2) <= temp(3);
            temp(1) <= temp(2);
            temp(0) <= temp(1);
        elsif(dir = '1' and mode ='1') then --shift di due bit verso sx
            temp(3) <= '0';
            temp(2) <= ing;
            temp(1) <= temp(2);
            temp(0) <= temp(1);           
        end if;
     end if;
     
     lastEn <= en;
     
     end if;
     
     y(0 to 3) <= temp(0 to 3);

end process;

--y(0 to 3) <= temp(0 to 3);

    
end Behavioral;
