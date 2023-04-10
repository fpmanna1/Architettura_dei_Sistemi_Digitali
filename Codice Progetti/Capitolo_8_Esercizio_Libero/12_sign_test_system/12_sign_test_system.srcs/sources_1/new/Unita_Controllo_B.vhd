library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Unita_Controllo_B is
    Port(
        clock       :   in  std_logic;
        reset       :   in  std_logic;
        req         :   in  std_logic;
        ack         :   out std_logic;
        load        :   out std_logic;
        en_count    :   out std_logic;
        en_write    :   out std_logic;
        en_comp     :   out std_logic
    );
end Unita_Controllo_B;

architecture Behavioral of Unita_Controllo_B is

type stato is (idle, read, compare, write, increment);
signal curr : stato := idle;


begin

fsmB : process(clock, reset)
begin
    if reset = '1' then
        ack <= '0';
        en_write <= '0';
        en_comp <= '0';
        curr <= idle;
    end if;
    
    if rising_edge(clock) then
        case curr is
            when idle =>
                ack <= '0';
                load <= '0';
                en_count <= '0';
                en_write <= '0';
                en_comp <= '0';
                if req = '1' then
                    curr <= read;
                else
                    curr <= idle;
                end if;
             when read =>
                ack <= '0';
                load <= '1';
                en_count <= '0';
                en_write <= '0';
                en_comp <= '0';
                curr <= compare;
             when compare =>
                ack <= '1'; -- ma come concetto ? 
                load <= '0';
                en_count <= '0';
                en_write <= '0';
                en_comp <= '1';
                curr <= write;
             when write =>
                ack <= '0';
                load <= '0';
                en_count <= '0';
                en_write <= '1';
                en_comp <= '0';
                curr <= increment;
             when increment =>
                ack <= '0';
                load <= '0';
                en_count <= '1';
                en_write <= '0';
                en_comp <= '0';
                curr <= idle;
        end case;
    end if;
end process;


end Behavioral;
