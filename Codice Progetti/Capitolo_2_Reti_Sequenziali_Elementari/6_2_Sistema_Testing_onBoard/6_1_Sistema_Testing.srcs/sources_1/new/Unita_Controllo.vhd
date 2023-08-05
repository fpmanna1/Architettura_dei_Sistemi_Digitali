library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Unita_Controllo is
    port(
        start           :   in  std_logic;
        clock           :   in  std_logic;
        reset           :   in  std_logic;
        reset_mem       :   out std_logic;
        reset_en        :   in  std_logic;
        read_rom        :   out std_logic;
        read_rom_2      :   out std_logic;
        read_en         :   in  std_logic;
        write_mem       :   out std_logic;
        enable          :   out std_logic;
        enable_counter  :   out std_logic;
        load            :   out std_logic;
        fine            :   in  std_logic --proveniente dall'unità operativa
    );
end Unita_Controllo;

architecture Behavioral of Unita_Controllo is

-- segnali puliti del bottone
signal  read_clrd   :   std_logic := '0';
signal  reset_clrd  :   std_logic := '0';

component ButtonDebouncer
    Generic(                       
        CLK_period      : integer := 10;  -- periodo del clock in nanosec
        btn_noise_time  : integer := 10000000 --durata dell'oscillazione in nanosec
    );
    Port( 
        rst         :   in  std_logic;
        clk         :   in  std_logic;
        btn         :   in  std_logic; 
        clrd_btn    :   out std_logic
    );
end component;

type stato is (idle,lettura_valori,scrittura_ris, caricamento_comp, verifica_ris, incrementa ,fine_test);
signal stato_corrente : stato := idle;

signal last_read : std_logic;
signal last_start : std_logic;

begin

read_btn : ButtonDebouncer
    Generic map(
        CLK_period      => 10,      -- periodo del clock in nanosec
        btn_noise_time  => 10000000 -- durata dell'oscillazione in nanosec
    )
    Port map(
        rst         =>  reset,
        clk         =>  clock,
        btn         =>  read_en,
        clrd_btn    =>  read_clrd
    );

reset_btn : ButtonDebouncer
    Generic map(
        CLK_period      => 10,
        btn_noise_time  => 10000000
    )
    Port map(
        rst         =>  reset,
        clk         =>  clock,
        btn         =>  reset_en,
        clrd_btn    =>  reset_clrd
    );



process(clock, reset)
begin
    if(reset = '1') then
        stato_corrente <= idle;
    end if;
    if(rising_edge(clock)) then
        case stato_corrente is
            when idle =>
                reset_mem       <= '1';
                read_rom        <= '0';
                read_rom_2      <= '0';
                write_mem       <= '0';
                enable          <= '0';
                enable_counter  <= '0';
                load            <= '0';
                if(start = '1' AND last_start = '0') then
                    last_start <= '1';
                    stato_corrente <= lettura_valori;
                else    
                    last_start <= '0';
                    stato_corrente <= idle;
                end if;
             when lettura_valori =>
                reset_mem       <= '0';
                
                write_mem       <= '0';
                enable          <= '0';
                enable_counter  <= '0';
                load            <= '0';
                if( read_en = '1' AND last_read = '0') then
                    last_read <= '1';
                    read_rom        <= '1';
                    read_rom_2      <= '1';
                    stato_corrente  <= scrittura_ris;
                else
                    last_read <= '0';
                    stato_corrente <= lettura_valori;
                end if;
             when scrittura_ris =>
                reset_mem       <= '0';
                read_rom        <= '0';
                read_rom_2      <= '0';
                write_mem       <= '1';
                enable          <= '0';
                enable_counter  <= '0';
                load            <= '0';
                stato_corrente  <= caricamento_comp;
                
             when caricamento_comp =>
                reset_mem       <= '0';
                read_rom        <= '0';
                read_rom_2      <= '0';
                write_mem       <= '0';
                enable          <= '0';
                enable_counter  <= '0';
                load            <= '1';
                stato_corrente  <= verifica_ris;
                
             when verifica_ris =>
                reset_mem       <= '0';
                read_rom        <= '0';
                read_rom_2      <= '0';
                write_mem       <= '0';
                enable          <= '1';
                enable_counter  <= '0';
                load            <= '0'; 
                stato_corrente  <= incrementa;
            
             when incrementa =>
                reset_mem       <= '0';
                read_rom        <= '0';
                read_rom_2      <= '0';
                write_mem       <= '0';
                enable          <= '0';
                enable_counter  <= '1';
                load            <= '0';
                stato_corrente  <= fine_test;
                
             when fine_test =>
                reset_mem       <= '0';
                read_rom        <= '0';
                read_rom_2      <= '0';
                write_mem       <= '0';
                enable          <= '0';
                enable_counter  <= '0';
                load            <= '0';
                if(fine = '1') then
                    stato_corrente <= idle;
                else
                    stato_corrente <= lettura_valori;
                end if;
            end case;
        end if;
       
end process;
end Behavioral;