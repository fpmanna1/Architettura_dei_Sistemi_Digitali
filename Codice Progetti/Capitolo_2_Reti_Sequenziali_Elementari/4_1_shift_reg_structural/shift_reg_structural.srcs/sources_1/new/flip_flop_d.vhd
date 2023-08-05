library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity flip_flop_d is
port(
    clk : in std_logic;
    en : in std_logic;
    input : in std_logic;
    output : out std_logic;
    rst : in std_logic
    );
end flip_flop_d;

architecture Behavioral of flip_flop_d is

signal lastEn : std_logic := '0';

begin
process(clk)
begin
    if(rising_edge(clk)) then
        if(rst = '1') then
            output <= '0';
        end if;
        if( en = '1' and lastEn = '0') then 
                output <= input;
        end if;
        lastEn <= en;
    end if;
    
end process;
end Behavioral;
