library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity comp_bit is
    port(
        x : in std_logic;
        y : in std_logic;
        enable : in std_logic; -- enable
        enable_gt_lt : in std_logic;
        eq     : out std_logic; -- alto se x e y sono uguali
        x_gt_y : out std_logic; -- alto se x è più grande di y
        x_lt_y : out std_logic -- alto se x è più piccolo di y
    );
end comp_bit;

architecture Behavioral of comp_bit is

begin

process(enable, enable_gt_lt)
begin
    if enable = '1' then
        if enable_gt_lt = '1' then
            if x = '1' AND y = '0' then
                eq <= '0';
                x_gt_y <= '1';
                x_lt_y <= '0';
            
            elsif x = '0' AND y = '1' then
                eq <= '0';
                x_gt_y <= '0';
                x_lt_y <= '1';
            
            elsif x = y then
                eq <= '1';
                x_gt_y <= '0';
                x_lt_y <= '0';
            
        end if;
               
        elsif (x = y) then
            eq <= '1';
            x_gt_y <= '0';
            x_lt_y <= '0';
        else
            eq <= '0';
        end if;
    end if;

end process;



end Behavioral;
