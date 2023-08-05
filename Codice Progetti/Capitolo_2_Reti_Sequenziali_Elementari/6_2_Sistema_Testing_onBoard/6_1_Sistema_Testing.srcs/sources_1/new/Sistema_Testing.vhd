library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Sistema_Testing is
    port(
        clock : in std_logic;
        reset : in std_logic;
        reset_mem : in std_logic;
        start_sw : in std_logic;
        read_btn  : in std_logic;
        test : out std_logic
    );

end Sistema_Testing;

architecture Structural of Sistema_Testing is

component Unita_Operativa is
        port(
        CLOCK           : in std_logic;
        RESET           : in std_logic;
        reset_mem       : in std_logic;
        read_rom        : in std_logic;
        read_rom_2      : in std_logic; --rom con i risultati giusti
        write_mem       : in std_logic;
        enable          : in std_logic;
        enable_counter  : in std_logic;
        load            : in std_logic;
        fine            : out std_logic;
        test            : out std_logic
        );
end component;

component Unita_Controllo is
        port(
        start          : in std_logic;
        clock          : in std_logic;
        reset          : in std_logic;
        reset_mem      : out std_logic;
        reset_en       : in std_logic;
        read_rom       : out std_logic;
        read_rom_2     : out std_logic;
        read_en        : in std_logic;
        write_mem      : out std_logic;
        enable         : out std_logic;
        enable_counter : out std_logic;
        load           : out std_logic;
        fine           : in std_logic
        );
end component;

signal read_rom_temp: std_logic;
signal read_rom_2_temp: std_logic;
signal write_mem_out_temp: std_logic;
signal load_temp: std_logic;
signal enable_temp: std_logic;
signal reset_temp: std_logic;
signal enCount_temp: std_logic;
signal fine_temp: std_logic;

begin

    UO : Unita_Operativa
        port map(
            CLOCK => clock,
            RESET => reset_temp,
            reset_mem => reset_mem, 
            read_rom => read_rom_temp,       
            read_rom_2 => read_rom_2_temp,
            write_mem => write_mem_out_temp,      
            enable => enable_temp,         
            enable_counter => enCount_temp,
            load => load_temp,            
            fine => fine_temp,        
            test => test            
        );
        
     UC : Unita_Controllo
        port map(
            start => start_sw,          
            clock => clock,         
            reset => reset,          
            reset_mem => reset_temp,   -- vedere se modificare  
            -- reset_mem => reset_mem
            reset_en => reset, 
            read_rom => read_rom_temp,
            read_rom_2 => read_rom_2_temp,
            read_en  => read_btn,
            write_mem => write_mem_out_temp,
            enable => enable_temp,        
            enable_counter => enCount_temp,
            load => load_temp,         
            fine => fine_temp           
        );
end Structural;
