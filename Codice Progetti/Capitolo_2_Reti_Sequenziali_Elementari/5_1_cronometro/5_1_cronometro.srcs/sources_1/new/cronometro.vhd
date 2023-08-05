library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity cronometro is
  Port(
    CLK     :   in std_logic;
    RST     :   in std_logic;
    EN      :   in std_logic;
    set_EN  :   in std_logic;              -- abilitazione del preset
    set_h   :   in std_logic_vector(0 to 4);
    set_m   :   in std_logic_vector(0 to 5);
    set_s   :   in std_logic_vector(0 to 5);
    h       :   out std_logic_vector(0 to 4);
    m       :   out std_logic_vector(0 to 5);
    s       :   out std_logic_vector(0 to 5)
  );
end cronometro;


architecture Structural of cronometro is

component clk_divider is
    Generic(
        clk_freq_in : integer := 100000000; --100Mhz della board
        clk_freq_out: integer := 1          --1Mhz uscita desiderata
    );
    
    Port(
        clk_in : in std_logic; -- board clock
        rst : in std_logic;
        clk_out : out std_logic
    );
end component clk_divider;

component contatore is
Generic(
    bits : integer := 100; -- n bits per rappresentare il risultato 
    modulo : integer := 60 -- modulo del contatore
);

Port(
    clk : in std_logic;
    rst : in std_logic;
    en : in std_logic;
    set_en : in std_logic;
    set : in std_logic_vector(0 to bits-1); -- 2^6 
    uscita : out std_logic;
    numero : out std_logic_vector(0 to bits-1)
    );
end component contatore;

signal y : std_logic_vector(0 to 2) := "000";
signal clk_out_tmp : std_logic := '0';
signal temp : std_logic_vector(0 to 1);
begin


    div : clk_divider
        generic map(
            clk_freq_in => 100000000,
            clk_freq_out => 1
        )
        port map(
            clk_in => CLK,
            rst => RST,
            clk_out => clk_out_tmp
        );
        
    sec : contatore
        generic map(
            bits => 6,
            modulo => 60
        )
        port map(
            clk => clk_out_tmp,
            rst => RST,
            en => EN,
            set_en => set_EN,
            set => set_s,
            uscita => y(0),
            numero => s
        );
        
        temp(0) <= y(0);
        
    min : contatore
        generic map(
            bits => 6,
            modulo => 60
        )
        port map(
            clk => clk_out_tmp,
            rst => RST,
            en => temp(0),
            set_en => set_EN,
            set => set_m,
            uscita => y(1),
            numero => m
        );
        
        temp(1) <= y(1) and y(0);
        
    ore : contatore
        generic map(
            bits => 5,
            modulo => 24
        )
        port map(
            clk => clk_out_tmp,
            rst => RST,
            en => temp(1),
            set_en => set_EN,
            set => set_h,
            uscita => y(2),
            numero => h
        );
        

        
end Structural;

--
