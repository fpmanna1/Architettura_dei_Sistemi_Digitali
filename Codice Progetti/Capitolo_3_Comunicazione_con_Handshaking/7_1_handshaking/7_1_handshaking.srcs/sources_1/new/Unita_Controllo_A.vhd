library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Unita_Controllo_A is
    Port(
        clock       :   in  std_logic;
        reset       :   in  std_logic;
        start       :   in  std_logic;
        fine        :   in  std_logic;
        ack         :   in  std_logic;
        req         :   out std_logic;  -- request to send
        read_mem    :   out std_logic;
        en_count    :   out std_logic
    );
end Unita_Controllo_A;

architecture Behavioral of Unita_Controllo_A is

type stato is (idle, read, wait_1, increment, end_check);
signal current : stato := idle;

begin

fsm_A : process(clock)
begin
    if reset = '1' then
        current <= idle;
    end if;
    
    if rising_edge(clock) then
        case current is
            when idle =>
                req <= '0';
                read_mem <= '0';
                en_count <= '0';
                if start = '1' then
                    current <= read;
                else
                    current <= idle;
                end if;
            when read =>
                read_mem    <= '1';
                req         <= '1';  
                en_count    <= '0';
                current <= wait_1;
            when wait_1 =>
                if ack = '1' then
                    current <= increment;
                else 
                    current <= wait_1;
                end if;
            when increment =>
                en_count    <= '1';
                req         <= '0';
                read_mem    <= '0';
                current     <= end_check;
            when end_check =>
                en_count    <= '0';
                req         <= '0';
                read_mem    <= '0';
                if fine = '1' then
                    current <= idle; -- finite le locazioni di memoria, termina...
                else
                    current <= read; -- ...altrimenti continua a leggere
                end if;
        end case;
    end if;

end process fsm_A;


end Behavioral;
