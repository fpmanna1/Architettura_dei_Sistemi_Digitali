library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ric_seq_onboard is
    port
    (
        ing : in std_logic; --S1
        mode : in std_logic; --S1
        ing_en : in std_logic; -- B1
        mode_en : in std_logic; -- B2
        rst, clk : in std_logic;
        yled : out std_logic
    );
end ric_seq_onboard;

architecture Structural of ric_seq_onboard is
    
    component ric_seq
        port
        (
            i : in std_logic;
            M : in std_logic;
            RST, CLK : in std_logic;
            enable : in std_logic;
            y : out std_logic
        );
    end component;
    
    component ButtonDebouncer
    generic (                       
        CLK_period: integer := 10;  -- periodo del clock in nanosec
        btn_noise_time: integer := 10000000 --durata dell'oscillazione in nanosec
    );
    Port ( RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           BTN : in STD_LOGIC; 
           CLRD_BTN : out STD_LOGIC);
    end component ButtonDebouncer;
    
   
    signal ytemp: std_logic := '0';
    signal clrd_ing : std_logic := '0'; -- input di ingresso pulito
    signal clrd_mode : std_logic := '0'; -- input di modo pulito
    signal reset_temp : std_logic := '0';
    
    
    begin
    
    reset_temp <= clrd_mode OR rst; 


    btn_ing : ButtonDebouncer port map ( 
           RST => rst,
           CLK => clk, 
           BTN => ing_en,  -- ingresso con rumore
           CLRD_BTN => clrd_ing -- ingresso effettivo, pulito
     );
     
     btn_mode : ButtonDebouncer port map (
           RST => rst,
           CLK => clk, 
           BTN => mode_en,  -- ingresso con rumore
           CLRD_BTN => clrd_mode -- ingresso effettivo, pulito
     );
    
    riconoscitore : ric_seq port map
    (
        i => ing,  -- ingresso fisico dello switch, del bottone di ingresso
        M => mode, -- " "
        RST => reset_temp,   -- ingresso fisico del bottone, del bottone di modo
        CLK => clk,
        enable => clrd_ing,  -- " "
        y => yled
    );
    --begin
    
    
	
    --end process;

end Structural;
