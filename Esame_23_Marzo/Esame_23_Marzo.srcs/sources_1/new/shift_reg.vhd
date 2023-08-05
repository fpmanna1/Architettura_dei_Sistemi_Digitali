library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Shift_reg is
    Port(
        clock   : in std_logic;
        reset   : in std_logic;
        load    : in std_logic;
        shift   : in std_logic;
        p_in    : in std_logic_vector(0 to 7); -- stringa a 8 bit, ingresso parallelo
        s_out   : out std_logic -- uscita seriale
    );
end Shift_reg;

architecture Behavioral of Shift_reg is

signal tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, tmp8 : std_logic := '0';

begin

shift_reg : process(clock)
begin

    if reset = '1' then
        tmp1 <= '0';
        tmp2 <= '0';
        tmp3 <= '0';
        tmp4 <= '0';
        tmp5 <= '0';
        tmp6 <= '0';
        tmp7 <= '0';
        tmp8 <= '0';
        
    elsif falling_edge(clock) then
        if load = '1' then
--            tmp1 <= p_in(0);
--            tmp2 <= p_in(1);
--            tmp3 <= p_in(2);
--            tmp4 <= p_in(3);
--            tmp5 <= p_in(4);
--            tmp6 <= p_in(5);
--            tmp7 <= p_in(6);
--            tmp8 <= p_in(7);
           tmp1 <= p_in(7);
           tmp2 <= p_in(6);
           tmp3 <= p_in(5);
           tmp4 <= p_in(4);
           tmp5 <= p_in(3);
           tmp6 <= p_in(2);
           tmp7 <= p_in(1);
           tmp8 <= p_in(0);
        elsif shift = '1' then
            tmp1 <= '0';
            tmp2 <= tmp1;
            tmp3 <= tmp2;
            tmp4 <= tmp3;
            tmp5 <= tmp4;
            tmp6 <= tmp5;
            tmp7 <= tmp6;
            tmp8 <= tmp7;
    end if;
end if;  
end process;

s_out <= tmp8;

end Behavioral;

