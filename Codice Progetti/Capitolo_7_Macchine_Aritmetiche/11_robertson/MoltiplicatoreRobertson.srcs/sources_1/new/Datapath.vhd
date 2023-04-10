library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;
use ieee.std_logic_unsigned.all;

entity Unita_Operativa is
    port(
        clk             : in  std_logic;
        rst             : in  std_logic;
        X               : in  std_logic_vector(7 downto 0);
        Y               : in  std_logic_vector(7 downto 0);
        load_a          : in  std_logic;
        load_q          : in  std_logic;
        load_m          : in  std_logic;
        count_inc       : in  std_logic;
        shift_enable    : in  std_logic;
        sub             : in  std_logic;
        last_digit_mux  : in  std_logic;
        counter_val     : out std_logic_vector(2 downto 0);
        result          : out std_logic_vector(15 downto 0)     
    );
end Unita_Operativa;

architecture Structural of Unita_Operativa is

component ripple_carry_adder is
    port(
        a    : in  std_logic_vector(7 downto 0);
        b    : in  std_logic_vector(7 downto 0);
        sub  : in  std_logic;
        res  : out std_logic_vector(7 downto 0);
        cout : out std_logic
    );
end component;

component counter is
    generic(
        M : integer := 8
    );
    port(
        clk : in std_logic;
        rst : in std_logic;
        count : in std_logic; 
        load : in std_logic;
        parallel_input : in std_logic_vector(integer(ceil(log2(real(M))))-1 downto 0);
        clk_out : out std_logic;
        Y : out std_logic_vector(integer(ceil(log2(real(M))))-1 downto 0)
    );
end component;

component ff_sign is
    port( 
        q0 : in std_logic;
        m7 : in std_logic;
        clk : in std_logic;
        rst : in std_logic;
        data : out std_logic
    );
end component;

component mux is
    port(
        a : in std_logic_vector(7 downto 0);
        b : in std_logic_vector(7 downto 0);
        s : in std_logic;
        out_d : out std_logic_vector(7 downto 0) 
    );
end component;

component registro is
    port(
        clk : in std_logic;
        reset : in std_logic;
        load : in std_logic;
        parallel_in : in std_logic_vector(7 downto 0);
        parallel_out : out std_logic_vector(7 downto 0)
    );
end component;

component shift_register is
    port(
        clk : in std_logic;
        shift : in std_logic;
        reset : in std_logic;
        load : in std_logic;
        
        serial_in : in std_logic;
        parallel_in : in std_logic_vector(7 downto 0);
        
        serial_out : out std_logic;
        parallel_out : out std_logic_vector(7 downto 0)
    );
end component;

signal ff_out : std_logic;
signal adder_out : std_logic_vector(7 downto 0);
signal a_parallel_out : std_logic_vector(7 downto 0);
signal a_serial_out : std_logic;

signal q_parallel_out : std_logic_vector(7 downto 0);
signal q_serial_out : std_logic;

signal m_parallel_out : std_logic_vector(7 downto 0);

signal mux_out : std_logic_vector(7 downto 0);

signal a_in : std_logic;

begin
    
    result <= a_parallel_out & q_parallel_out; -- concatenazione registri A e Q
    
    a_in <= ff_out when  last_digit_mux = '0' else
            a_parallel_out(7) when last_digit_mux = '1';
    
    A : shift_register 
    port map(
        clk   => clk, 
        shift => shift_enable, 
        reset => rst, 
        load  => load_a, 
        serial_in => a_in, 
        parallel_in => adder_out, 
        parallel_out => a_parallel_out, 
        serial_out => a_serial_out
    );
    
    Q : shift_register 
    port map(
        clk => clk, 
        shift => shift_enable, 
        reset => rst, 
        load => load_q, 
        serial_in => a_serial_out, 
        parallel_in => X, 
        parallel_out => q_parallel_out, 
        serial_out => q_serial_out
    );
    
    M : registro 
    port map(
        clk => clk, 
        reset => rst, 
        load => load_m, 
        parallel_in => Y, 
        parallel_out => m_parallel_out
    );
    
    addr : ripple_carry_adder 
    port map(
        a => a_parallel_out, 
        b => mux_out, 
        sub => sub, 
        res => adder_out
    );
    
    cnt : counter generic map(
        M => 8
    ) port map(
        clk => clk, 
        rst => rst, 
        count => count_inc, 
        load => '0', 
        y => counter_val, 
        parallel_input => (others => '0')
    );
    
    mu : mux port map(
        b => m_parallel_out, 
        a => (others=>'0'), 
        s => q_serial_out, 
        out_d => mux_out
    );
    
    ff : ff_sign port map(
        q0 => q_serial_out, 
        m7 => m_parallel_out(7), 
        clk => clk, 
        rst => rst, 
        data => ff_out
    );
    
end Structural;
