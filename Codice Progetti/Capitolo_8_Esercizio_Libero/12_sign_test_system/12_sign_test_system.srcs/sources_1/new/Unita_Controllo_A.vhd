library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Unita_Controllo_A is
    Port(
        clock       :   in  std_logic;
        reset       :   in  std_logic;
        start       :   in  std_logic;
        ack         :   in  std_logic;
        fine        :   in  std_logic;
        req         :   out std_logic;
        en_count    :   out std_logic;
        en_read     :   out std_logic
    );
end Unita_Controllo_A;

architecture Behavioral of Unita_Controllo_A is

type stato is (idle, read, send, wait_ack, increment, end_check);
signal curr : stato := idle;

begin

fsmA : process(clock, reset)
begin
    if reset = '1' then
        req <= '0';
        en_count <= '0';
        en_read <= '0';
        curr <= idle;
    end if;
    
    if rising_edge(clock) then
        case curr is
            when idle =>
                req <= '0';
                en_count <= '0';
                en_read <= '0';
                if start = '1' then
                    curr <= read;
                else
                    curr <= idle;
                end if;
            when read =>
                req <= '0';
                en_count <= '0';
                en_read <= '1';
                curr <= send;
            when send =>
                req <= '1';
                en_count <= '0';
                en_read <= '0';
                curr <= wait_ack;
            when wait_ack =>
                req <= '1';
                en_count <= '0';
                en_read <= '0';
                if ack = '1' then
                    curr <= increment;
                else
                    curr <= wait_ack;
                end if;
            when increment =>
                req <= '0';
                en_count <= '1';
                en_read <= '0';
                curr <= end_check;
            when end_check =>
                req <= '0';
                en_count <= '0';
                en_read <= '0';
                if fine = '1' then
                    curr <= idle;
                  else
                    curr <= read;
                end if;
        end case;
    end if;
end process;

end Behavioral;







