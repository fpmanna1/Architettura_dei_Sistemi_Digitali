library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity cronometro_onboard is
    Port(
        CLK         :   in  std_logic;
        RST         :   in  std_logic;
        EN          :   in  std_logic;                  -- segnale di enable per cronometro mappato su T8: sw8
        set_btn     :   in  std_logic;                  -- segnale di enable per input mappato su bottone P17
        show_btn    :   in  std_logic;                  -- segnale di enable per intertempo mappato su bottone M17
        sel_H       :   in  std_logic;                  -- selezioni per l'ora
        sel_M       :   in  std_logic;                  -- selezione per i minuti
        sel_S       :   in  std_logic;                  -- selezione per i secondi
        value_in    :   in  std_logic_vector(0 to 5);   -- input buffer
        cathodes    :   out std_logic_vector(7 downto 0);
        anodes      :   out std_logic_vector(7 downto 0)
    );
end cronometro_onboard;

architecture Structural of cronometro_onboard is

-- segnale pulito del bottone
signal  set_clrd        :   std_logic := '0';

-- segnali per le uscite della control unit
signal  cu_h_out        :   std_logic_vector(0 to 4) := (others => '0');
signal  cu_m_out        :   std_logic_vector(0 to 5) := (others => '0');
signal  cu_s_out        :   std_logic_vector(0 to 5) := (others => '0');

-- segnali per le uscite del cronometro
signal  cronos_h_out    :   std_logic_vector(0 to 4) := (others => '0');
signal  cronos_m_out    :   std_logic_vector(0 to 5) := (others => '0');
signal  cronos_s_out    :   std_logic_vector(0 to 5) := (others => '0');

-- segnali per le uscite del cronometro convertite in decimale
signal  cronos_h_dec    :   std_logic_vector(0 to 7) := (others => '0');
signal  cronos_m_dec    :   std_logic_vector(0 to 7) := (others => '0');
signal  cronos_s_dec    :   std_logic_vector(0 to 7) := (others => '0');

component cronometro
    Port(
    CLK     :   in  std_logic;
    RST     :   in  std_logic;
    EN      :   in  std_logic;               -- abilitazione cronometro
    set_EN  :   in  std_logic;               -- abilitazione per il caricamento
    set_h   :   in  std_logic_vector(0 to 4);
    set_m   :   in  std_logic_vector(0 to 5);
    set_s   :   in  std_logic_vector(0 to 5);
    h       :   out std_logic_vector(0 to 4);
    m       :   out std_logic_vector(0 to 5);
    s       :   out std_logic_vector(0 to 5)
  );
end component;

    
component display_seven_segments
    Generic( 
        clock_frequency_in  : integer := 100000000; 
		clock_frequency_out : integer := 500
	);
    Port( 
        clock       :   in  std_logic;
        reset       :   in  std_logic;
        value32_in  :   in  std_logic_vector(31 downto  0);
        enable      :   in  std_logic_vector(7  downto  0);
        dots        :   in  std_logic_vector(7  downto  0);
        anodes      :   out std_logic_vector(7  downto  0);
        cathodes    :   out std_logic_vector(7  downto  0)
    );
end component;

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

component control_unit
    Port(
        clk         :   in  std_logic;
        rst         :   in  std_logic;
        set_btn     :   in  std_logic;
        sel_h       :   in  std_logic;
        sel_m       :   in  std_logic;
        sel_s       :   in  std_logic;
        set_h       :   out std_logic_vector(0 to 4);
        set_m       :   out std_logic_vector(0 to 5);
        set_s       :   out std_logic_vector(0 to 5);
        value_in    :   in  std_logic_vector(0 to 5)
      );
end component;

component converter
    Port(
        clk     :   in  std_logic;
        vIn     :   in  std_logic_vector(0 to 5);
        vOut    :   out std_logic_vector(7 downto 0)
    );
end component converter;

begin
    
set : ButtonDebouncer
    Generic map(
        CLK_period      => 10,      -- periodo del clock in nanosec
        btn_noise_time  => 10000000 -- durata dell'oscillazione in nanosec
    )
    Port map(
        rst         =>  RST,
        clk         =>  CLK,
        btn         =>  set_btn,
        clrd_btn    =>  set_clrd
    );

cu : control_unit
    Port map(
        clk         =>  CLK,
        rst         =>  RST,
        set_btn     =>  set_clrd,
        sel_h       =>  sel_H,
        sel_m       =>  sel_M,
        sel_s       =>  sel_S,
        set_h       =>  cu_h_out,
        set_m       =>  cu_m_out,
        set_s       =>  cu_s_out,
        value_in    =>  value_in
    );

cronos : cronometro -- cronos come concetto
    Port map(
        CLK     =>  CLK,
        RST     =>  RST,
        EN      =>  EN,
        set_EN  =>  set_clrd,   --il bottone funge da segnale di enable, alla sua pressione vengnono caricati il valori h, m ed s
        set_h   =>  cu_h_out,
        set_m   =>  cu_m_out,
        set_s   =>  cu_s_out,
        h       =>  cronos_h_out,
        m       =>  cronos_m_out,
        s       =>  cronos_s_out
    );


watch : display_seven_segments
    Generic map(
        clock_frequency_in  => 100000000,
        clock_frequency_out => 500
    )
    Port map(
        clock                       =>  CLK,
        reset                       =>  RST,
        value32_in(7    downto  0)  =>  cronos_s_dec,
        value32_in(15   downto  8)  =>  cronos_m_dec,
        value32_in(23   downto  16) =>  cronos_h_dec,
        value32_in(31   downto  24) =>  (others => '0'),
        enable                      =>  "00111111", -- le prime due cifre vengono spente
        dots                        =>  "00000000",
        cathodes                    =>  cathodes,
        anodes                      =>  anodes
    );

conv_s : converter
    Port map(
        clk     => clk,
        vIn     => cronos_s_out,
        vOut    => cronos_s_dec
    );
    
conv_m : converter
    Port map(
        clk     => clk,
        vIn     => cronos_m_out,
        vOut    => cronos_m_dec
    );   

conv_h : converter
    Port map(
        clk         => clk,
        vIn(1 to 5) => cronos_h_out,
        vIn(0)      => '0',
        vOut        => cronos_h_dec
    );
    
    
    
end Structural;
