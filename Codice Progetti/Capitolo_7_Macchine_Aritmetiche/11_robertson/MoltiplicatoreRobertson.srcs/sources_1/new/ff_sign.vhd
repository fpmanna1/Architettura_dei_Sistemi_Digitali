library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ff_sign is
    port( 
        q0 : in std_logic;
        m7 : in std_logic;
        clk : in std_logic;
        
        rst : in std_logic;
        
        data : out std_logic
    );
end ff_sign;

architecture Behavioral of ff_sign is

signal state : std_logic := '0';

begin
    data <= state;
    process(clk) begin
        if(rising_edge(clk)) then
            if(rst = '1') then
                state <= '0';
            else 
                state <= (q0 and m7) or state;
            end if;
        end if;
    end process;

end Behavioral;
