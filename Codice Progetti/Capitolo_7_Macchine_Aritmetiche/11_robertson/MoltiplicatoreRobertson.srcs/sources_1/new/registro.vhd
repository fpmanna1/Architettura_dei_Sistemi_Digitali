library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity registro is
    port(
        clk : in std_logic;
        reset : in std_logic;
        load : in std_logic;
        
        parallel_in : in std_logic_vector(7 downto 0);
        
        parallel_out : out std_logic_vector(7 downto 0)
    );
end registro;

architecture Behavioral of registro is

signal state : std_logic_vector(7 downto 0);

begin
    parallel_out <= state;
    
    process(clk) begin
        if(rising_edge(clk)) then
            if(reset = '1') then
                state <= (others => '0');
            elsif(load = '1') then
                state <= parallel_in;
            end if;
        end if;
    end process;

end Behavioral;
