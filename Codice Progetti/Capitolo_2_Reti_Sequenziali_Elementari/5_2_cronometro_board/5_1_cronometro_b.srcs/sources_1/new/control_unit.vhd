library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_unit is
    Port(
        clk      :  in  std_logic;
        rst      :  in  std_logic;
        set_btn  :  in  std_logic;
        sel_h    :  in  std_logic;
        sel_m    :  in  std_logic;
        sel_s    :  in  std_logic;
        set_h    :  out std_logic_vector(0 to 4);
        set_m    :  out std_logic_vector(0 to 5);
        set_s    :  out std_logic_vector(0 to 5);
        value_in :  in  std_logic_vector(0 to 5)
    );
end control_unit;

architecture Behavioral of control_unit is

begin

    
    input : process(clk, rst)
    begin
        if rst = '1' then
            set_h <= (others => '0');
            set_m <= (others => '0');
            set_s <= (others => '0');
        end if;
        
        if clk'event AND clk = '1' then
            if set_btn = '1' then
                if sel_h = '1' then
                    set_h(0 to 4) <= value_in(0 to 4);
                elsif sel_m = '1' then
                    set_m <= value_in;
                elsif sel_s = '1' then
                    set_s <= value_in;
                end if;
            end if;
        end if;
    end process;

end Behavioral;
