library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Unita_Controllo_B is
    port(
        clock : in std_logic;
        reset : in std_logic;
        start : in std_logic;
        fine_loc  : in std_logic; -- proveniente dall'unità operativa
        ack   : in std_logic;
        en_counter : out std_logic;
        en_read : out std_logic;
        req : out std_logic
    );
end Unita_Controllo_B;


architecture Behavioral of Unita_Controllo_B is

type status is (idle, read, send_req, wait_ack, addr_increment, end_check);
signal curr : status := idle;


begin

fsmB : process(clock)
begin
    if reset = '1' then
        en_counter <= '0';
        en_read <= '0';
        req <= '0';
        curr  <= idle;
    end if;
    
    if rising_edge(clock) then
        case curr is
            when idle =>
                en_counter <= '0';
                en_read <= '0';
                req <= '0';
                if start = '1' then
                    curr <= read;
                else
                    curr <= idle;
                end if;
                
            when read =>
                en_counter <= '0';
                en_read <= '1';
                req <= '0';
                curr <= send_req;
                
           when send_req =>
                en_counter <= '0';
                en_read <= '0';
                req <= '1';
                curr <= wait_ack;
                
           when wait_ack =>
                en_counter <= '0';
                en_read <= '0';
                req <= '1';
                if ack = '1' then
                    curr <= addr_increment;
                else
                    curr <= wait_ack;
                end if;
               
           when addr_increment =>
                en_counter <= '1';
                en_read <= '0';
                req <= '0';
                curr <= end_check;
                
           when end_check =>
                en_counter <= '0';
                en_read <= '0';
                req <= '0';
                if fine_loc = '1' then
                    curr <= idle;
                else
                    curr <= read;
                end if;
                
        end case;
    end if;
end process;

end Behavioral;
