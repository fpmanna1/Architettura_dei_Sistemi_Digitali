library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Unita_Controllo_B is
    Port(
        clock       :   in  std_logic;
        reset       :   in  std_logic;
        req         :   in  std_logic;  -- request to send
        fine_in     :   in  std_logic;
        fine_out    :   out std_logic;
        ack         :   out std_logic;
        write_mem   :   out std_logic;
        read_mem    :   out std_logic;
        en_count    :   out std_logic;
        en_add      :   out std_logic
    );
end Unita_Controllo_B;

architecture Behavioral of Unita_Controllo_B is

type stato is (idle, read, add, write, increment, end_check);
signal current : stato := idle;

begin

fsm_B : process(clock)
begin
    if reset = '1' then
        current <= idle;
    end if;
    
    if rising_edge(clock) then
        case current is
            when idle =>
                ack         <= '0';
                write_mem   <= '0';
                read_mem    <= '0';
                en_count    <= '0';
                en_add      <= '0';
                fine_out    <= '0';
                if req = '1' then
                    current <= read;
                else
                    current <= idle;
                end if;
            when read =>
                ack         <= '1';
                read_mem    <= '1';
                write_mem   <= '0';
                en_count    <= '0';
                en_add      <= '0';
                fine_out    <= '0';
                current     <= add;
            when add =>
                ack         <= '0';
                en_add      <= '1';
                read_mem    <= '0';
                write_mem   <= '0';
                en_count    <= '0';
                fine_out    <= '0';
                current     <= write;
            when write =>
                ack         <= '0';
                read_mem    <= '0';
                write_mem   <= '1';
                en_count    <= '0';
                en_add      <= '0';
                fine_out    <= '0';
                current     <= increment;
            when increment =>
                ack         <= '0';
                write_mem   <= '0';
                read_mem    <= '0';
                en_count    <= '1';
                en_add      <= '0';
                fine_out    <= '0';
                current     <= end_check;
            when end_check =>
                ack         <= '0';
                write_mem   <= '0';
                read_mem    <= '0';
                en_count    <= '0';
                en_add      <= '0';
                if fine_in = '1' OR req = '0' then
                    fine_out <= '1';
                    current <= idle;
                elsif (fine_in = '0' AND req = '1') then
                    fine_out <= '0';
                    current <= read;
                end if;
          end case;
    end if;
    
end process fsm_B;

end Behavioral;










