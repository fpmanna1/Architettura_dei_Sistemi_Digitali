library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity converter is
    Port (
        clk     :   in  std_logic;
        vIn     :   in  std_logic_vector(0 to 5);
        vOut    :   out std_logic_vector(7 downto 0)
    );
end converter;

architecture Behavioral of converter is

begin

process(clk)
begin

    if rising_edge(clk) then
        case to_integer(unsigned(vIn)) is
        when 0|10|20|30|40|50 => vOut(3 downto 0) <= "0000";
        when 1|11|21|31|41|51 => vOut(3 downto 0) <= "0001";
        when 2|12|22|32|42|52 => vOut(3 downto 0) <= "0010";
        when 3|13|23|33|43|53 => vOut(3 downto 0) <= "0011";
        when 4|14|24|34|44|54 => vOut(3 downto 0) <= "0100";
        when 5|15|25|35|45|55 => vOut(3 downto 0) <= "0101";
        when 6|16|26|36|46|56 => vOut(3 downto 0) <= "0110";
        when 7|17|27|37|47|57 => vOut(3 downto 0) <= "0111";
        when 8|18|28|38|48|58 => vOut(3 downto 0) <= "1000";
        when 9|19|29|39|49|59 => vOut(3 downto 0) <= "1001";
        when others => vOut(3 downto 0) <= "1111";
    end case;

    case to_integer(unsigned(vIn)) is
        when 0  to 9    => vOut(7 downto 4) <= "0000";
        when 10 to 19   => vOut(7 downto 4) <= "0001";
        when 20 to 29   => vOut(7 downto 4) <= "0010";
        when 30 to 39   => vOut(7 downto 4) <= "0011";
        when 40 to 49   => vOut(7 downto 4) <= "0100";
        when 50 to 59   => vOut(7 downto 4) <= "0101";
        when others => vOut(7 downto 4) <= "1111";
    end case;
    
    end if;

end process;


end Behavioral;
