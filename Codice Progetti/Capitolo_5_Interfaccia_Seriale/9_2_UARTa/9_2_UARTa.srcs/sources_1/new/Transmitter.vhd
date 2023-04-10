library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Transmitter is
    Port(
        clock       :   in  std_logic;
        reset       :   in  std_logic;
        start       :   in  std_logic;
        count       :   in  std_logic_vector(0 to 2);
        load        :   in  std_logic;
        en_rom      :   out std_logic;
        en_count    :   out std_logic;
        wr          :   out std_logic -- uart write strobe signal
    );
end Transmitter;

architecture Behavioral of Transmitter is

type state is (idle, pLoad, sSend, stopWR, increment, endCheck);

signal curr : state := idle;
signal count_val : integer := 0;

begin

count_val <= to_integer(unsigned(count));

fsmA : process(clock)
begin
    if reset = '1' then
        en_rom      <= '0';
        en_count    <= '0';
        wr          <= '0';
        curr        <= idle;
    end if;
    
    if rising_edge(clock) then
        case curr is
            when idle =>
                en_rom      <= '0';
                en_count    <= '0';
                wr          <= '0';
                if start = '1' then
                    curr <= pLoad;
                else
                    curr <= idle;
                end if;
            when pLoad =>   -- read (parralel) data from ROM
                en_rom      <= '0';
                en_count    <= '0';
                wr          <= '0'; -- uart write strobe
                if load = '1' then
                    en_rom <= '1';
                    curr <= sSend;
                else
                    en_rom <= '0';
                    curr <= pLoad;
                end if;
            when sSend =>
                en_rom   <= '0';
                en_count    <= '0';
                wr          <= '1'; -- begin trasmission of (serial) data
                curr        <= stopWR;
            when stopWR =>
                en_rom      <= '0';
                en_count    <= '0';
                wr          <= '0';
                curr        <= increment;
            --when waitTBE =>
              --  en_rom_rd   <= '0';
                --en_count    <= '0';
                --wr          <= '0';
                --led_out     <= '0';
                --if tbe_in = '1' then
                    --wr <= '0';
                  --  curr <= increment;
                --else
                    --wr <= '1';
                    --curr <= waitTBE;
                --end if;
             when increment =>
                en_rom      <= '0';
                en_count    <= '1';
                wr          <= '0';
                curr        <= endCheck;
             when endCheck =>
                en_rom      <= '0';
                en_count    <= '0';
                wr          <= '0';
                if count_val = 7 then
                    curr <= idle;
                else
                    curr <= pLoad;
                end if;
        end case;
    end if;
end process;


end Behavioral;






