library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity moltiplicatore_robertson is
    port(
        X : in std_logic_vector(7 downto 0);
        Y : in std_logic_vector(7 downto 0);
        rst : in std_logic;
        start : in std_logic;
        clk : in std_logic;
        RES : out std_logic_vector(15 downto 0)
    );
end moltiplicatore_robertson;

architecture structural of moltiplicatore_robertson is

component Unita_Operativa is
    port(
        clk : in std_logic;
        
        X : in std_logic_vector(7 downto 0);
        Y : in std_logic_vector(7 downto 0);
        
        load_a : in std_logic;
        load_q : in std_logic;
        load_m : in std_logic;
        count_inc : in std_logic;
        shift_enable : in std_logic;
        sub : in std_logic;
        rst : in std_logic;
        last_digit_mux : in std_logic;
        
        counter_val : out std_logic_vector(2 downto 0);
        result : out std_logic_vector(15 downto 0)     
    );
end component;

component Unita_Controllo is
    port(
        clk : in std_logic;
        counter_val : in std_logic_vector(2 downto 0);
        start : in std_logic;
        reset : in std_logic;
        
        load_a : out std_logic;
        load_q : out std_logic;
        load_m : out std_logic;
        count_inc : out std_logic;
        shift_enable : out std_logic;
        sub : out std_logic;
        rst : out std_logic;
        
        last_digit_mux : out std_logic
    );
end component;

signal counter_val : std_logic_vector(2 downto 0);
signal load_a : std_logic;
signal load_q : std_logic;
signal load_m : std_logic;
signal count_inc : std_logic;
signal shift_enable : std_logic;
signal sub : std_logic;
signal reset_datapath : std_logic;
signal last_digit_mux : std_logic;

begin   
 
    UC : Unita_Controllo port map(
        clk => clk, 
        counter_val => counter_val, 
        start => start, 
        reset => rst, 
        sub => sub, 
        load_a => load_a, 
        load_q => load_q, 
        load_m => load_m, 
        count_inc => count_inc, 
        shift_enable => shift_enable, 
        rst => reset_datapath, 
        last_digit_mux => last_digit_mux
    );
    
    UO : Unita_Operativa port map(
        clk => clk, 
        X => X, 
        Y => Y, 
        load_a => load_a, 
        load_q => load_q,
        load_m => load_m,
        count_inc => count_inc, 
        shift_enable => shift_enable, 
        sub => sub,
        rst => reset_datapath, 
        counter_val => counter_val, 
        result => res,
        last_digit_mux => last_digit_mux
    );
    
end structural;
