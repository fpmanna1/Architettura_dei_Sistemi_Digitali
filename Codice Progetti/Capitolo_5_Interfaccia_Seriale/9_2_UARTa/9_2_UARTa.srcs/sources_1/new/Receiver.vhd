library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Receiver is
    Port(
        clock       :   in  std_logic;
        reset       :   in  std_logic;
        en_wr       :   out std_logic;
        en_rd       :   out std_logic;
        en_count    :   out std_logic;
        rda         :   in  std_logic;
        rd          :   out std_logic
    );
end Receiver;

architecture Behavioral of Receiver is

type state is (idle, store, display, increment);

signal curr : state := idle;


begin

fsmB : process(clock)
begin
    if reset = '1' then
        rd          <= '0';
        en_wr       <= '0';
        en_rd       <= '0';
        en_count    <= '0';
        curr        <= idle;
    end if;
    
    if rising_edge(clock) then
        case curr is
            when idle =>
                rd          <= '0';
                en_wr       <= '0';
                en_rd       <= '0';
                en_count    <= '0';
                if rda = '1' then
                    --rd <= '1'; --??
                    curr <= store;
                else
                    --rd <= '0'; --??
                    curr <= idle;
                end if;
            when store =>
                rd          <= '1';
                en_wr       <= '1'; -- scrivi in memoria
                en_rd       <= '0';
                en_count    <= '0';
                curr        <= display;
            when display =>
                rd          <= '0';
                en_wr       <= '0';
                en_rd       <= '1'; -- leggi dalla memoria
                en_count    <= '0';
                curr        <= increment;
            when increment =>
                rd          <= '0';
                en_wr       <= '0';
                en_rd       <= '0';
                en_count    <= '1';
                curr        <= idle;
        end case;
    end if;
    
end process;

end Behavioral;
