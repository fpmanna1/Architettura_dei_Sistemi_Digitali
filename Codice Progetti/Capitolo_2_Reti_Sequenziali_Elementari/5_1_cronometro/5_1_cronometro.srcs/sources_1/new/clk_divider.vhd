library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity clk_divider is
    Generic(
        clk_freq_in : integer := 100000000; --100Mhz della board
        clk_freq_out: integer := 1          --1Mhz uscita desiderata
    );
    
    Port(
        clk_in : in std_logic; -- board clock
        rst : in std_logic;
        clk_out : out std_logic
    );
end clk_divider;

architecture Behavioral of clk_divider is

signal clk_temp : std_logic := '0';
constant max_count : integer := (clk_freq_in/clk_freq_out)-1;

begin
    
 clk_out <= clk_temp;
 
 count_divisions : process(clk_in)
 variable counter : integer range 0 to max_count := 0;
 begin
    if(clk_in'event AND clk_in = '1') then
    
        if(rst = '1') then
            counter := 0;
            clk_temp <= '0';
        else
            if(counter = max_count) then
                clk_temp <= '1';
                counter := 0;
            else
                clk_temp <= '0';
                counter := counter+1;
            end if;
        end if;
    end if;
 
 end process;

end Behavioral;
--