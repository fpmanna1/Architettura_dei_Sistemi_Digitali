library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Unita_Controllo_A is
    port(
        clock : in std_logic;
        reset : in std_logic;
        req : in std_logic;
        fine_shift : in std_logic;
        ack : out std_logic;
        en_compare : out std_logic;
        load_sr_x : out std_logic;
        load_sr_y : out std_logic
       
    );
end Unita_Controllo_A;

architecture Behavioral of Unita_Controllo_A is

type status is (wait_for_x, send_ack_x, load_x, wait_load_x, wait_for_y, send_ack_y, load_y, wait_load_y, compare, wait_compare);
signal curr : status := wait_for_x;


begin
fsmA : process(clock)
begin

    if reset = '1' then
        ack <= '0';
        en_compare <= '0';
        load_sr_x <= '0';
        load_sr_y <= '0';
    end if;

    if rising_edge(clock) then
        case curr is
            when wait_for_x =>
                ack <= '0';
                en_compare <= '0';
                load_sr_x <= '0';
                load_sr_y <= '0';
                if req = '1' then
                    curr <= send_ack_x;
                else
                    curr <= wait_for_x;
                end if;
                
             when send_ack_x =>
                ack <= '1';
                en_compare <= '0';
                load_sr_x <= '0';
                load_sr_y <= '0';
                curr <= load_x;
                
             when load_x => 
                ack <= '0';
                en_compare <= '0';
                load_sr_x <= '1';
                load_sr_y <= '0';
                --curr <= wait_for_y;
                curr <= wait_load_x;
                
             when wait_load_x =>
                ack <= '0';
                en_compare <= '0';
                load_sr_x <= '0';
                load_sr_y <= '0';
                curr <= wait_for_y;
                
                
             when wait_for_y =>
                ack <= '0';
                en_compare <= '0';
                load_sr_x <= '0';
                load_sr_y <= '0';
                if req = '1' then
                    curr <= send_ack_y;
                else
                    curr <= wait_for_y;
                end if;
                
             when send_ack_y =>
                ack <= '1';
                en_compare <= '0';
                load_sr_x <= '0';
                load_sr_y <= '0';
                curr <= load_y;
                
                
             when load_y => 
                ack <= '0';
                en_compare <= '0';
                load_sr_x <= '0';
                load_sr_y <= '1';
                --curr <= compare;
                curr <= wait_load_y;
                
             when wait_load_y =>
                ack <= '0';
                en_compare <= '0';
                load_sr_x <= '0';
                load_sr_y <= '0';
                curr <= compare;
                
             when compare =>
                ack <= '0';
                en_compare <= '1';
                load_sr_x <= '0';
                load_sr_y <= '0';
                curr <= wait_compare; 
                --curr <= wait_for_x; 
                
             when wait_compare =>
                ack <= '0';
                en_compare <= '0';
                load_sr_x <= '0';
                load_sr_y <= '0';
                
                if fine_shift = '1' then
                    curr <= wait_for_x;
                else
                    curr <= wait_compare;
                end if; 
        end case;
     end if;
end process;

end Behavioral;
