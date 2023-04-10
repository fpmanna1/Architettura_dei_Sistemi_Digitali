library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity System is
    Port(
        CLOCK : in std_logic;
        RESET : in std_logic;
        START : in std_logic;
        LOAD : in std_logic;
        DATA_OUT : out std_logic_vector(7 downto 0)
    );
end System;

architecture Structural of System is

component SysA is
    Port(
        clock       :   in  std_logic;
        reset       :   in  std_logic;
        startA      :   in  std_logic;
        btn_load    :   in  std_logic;
        txd_out     :   out std_logic --data s out
        --data_p_out  :   out std_logic_vector(7 downto 0) -- led
    );
end component SysA;

component SysB is
    Port(
        clock : in std_logic;
        reset : in std_logic;
        rxd_in : in std_logic;
        --data_p_in : in std_logic_vector(7 downto 0);
        data_p_out : out std_logic_vector(7 downto 0)
    );
end component SysB;

component ButtonDebouncer is
    Generic(                       
        CLK_period      : integer := 10;
        btn_noise_time  : integer := 10000000
    );
    Port( 
        rst         :   in  std_logic;
        clk         :   in  std_logic;
        btn         :   in  std_logic; 
        clrd_btn    :   out std_logic
    );
end component ButtonDebouncer;

-- segnale temporaneo mappato con l'uscita del nodo A, e posto in ingresso rxd al nodo B
-- in modo che a sua volta venga mappato con la porta RXD della UART usata dal nodo B
signal txd_tmp      : std_logic;

-- segnali ripulititi dei bottoni mappati per lo START e il LOAD
signal clrd_start   : std_logic := '0';
signal clrd_load    : std_logic := '0';

begin

nodeA : SysA
    Port map(
        clock => CLOCK,
        reset => RESET,
        startA => clrd_start,
        btn_load => clrd_load,
        txd_out => txd_tmp
        --data_p_out => DATA_OUT
    );
    
nodeB : SysB
    Port map(
        clock => CLOCK,
        reset => RESET,
        rxd_in => txd_tmp,
        data_p_out => DATA_OUT
    );

start_btn : ButtonDebouncer
    Generic map(
       CLK_period => 10,
       btn_noise_time  => 650000000 
    )
    Port map(
        rst => RESET,
        clk => CLOCK,
        btn => START,
        clrd_btn => clrd_start
    );

load_btn : ButtonDebouncer
    Generic map(
       CLK_period => 10,
       btn_noise_time  => 650000000 
    )
    Port map(
        rst => RESET,
        clk => CLOCK,
        btn => LOAD,
        clrd_btn => clrd_load
    );

end Structural;
