library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Unita_Controllo is
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
        last_digit_mux : out std_logic;
        rst : out std_logic
    );
end Unita_Controllo;

architecture Behavioral of Unita_Controllo is

type stato is (idle, init, op_ass, add, shift, inc, subtract, end_shift);
signal state : stato := idle;

begin
    state_prc : process(clk) begin
        if(rising_edge(clk)) then
            if(reset = '1') then
                state <= idle;
            elsif(state = idle and start = '1') then
                state <= init;
            elsif(state = init) then
                state <= op_ass;
            elsif(state = op_ass) then
                state <= add;
            elsif(state = add) then
                state <= shift;
            elsif(state = shift) then
                state <= inc;
            elsif(state = inc and counter_val = "110") then
                state <= subtract;
            elsif(state = inc) then
                state <= add;
            elsif(state = subtract) then
                state <= end_shift;
            elsif(state = end_shift) then
                state <= idle;
            end if;   
        end if;
    end process;
    
    out_prc : process(state) begin
    
        --default values
        load_a <= '0';
        load_q <= '0';
        load_m <= '0';
        count_inc <= '0';
        shift_enable <= '0';
        sub <= '0';
        rst <= '0';
        last_digit_mux <= '0';
        
        if(state = init) then
            rst <= '1';
        elsif(state = op_ass) then
            load_q <= '1';
            load_m <= '1';
        elsif(state = add) then
            load_a <= '1';
        elsif(state = shift) then
            shift_enable <= '1';
        elsif(state = inc) then
            count_inc <= '1';
        elsif(state = subtract) then
            sub <= '1';
            load_a <= '1';
        elsif(state = end_shift) then
            shift_enable <= '1';
            last_digit_mux <= '1';
        end if;
        
    end process;

end Behavioral;
