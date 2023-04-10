library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity enc_bcd is
    Port(
        x : in STD_LOGIC_VECTOR(0 to 9);
        y : out STD_LOGIC_VECTOR(0 to 3)
    );
end enc_bcd;

architecture Behavioral of enc_bcd is

begin
    process(x)
    begin
        case x is
            when "0000000001" => y <= "0000";
            when "0000000010" => y <= "0001";
            when "0000000100" => y <= "0010";
            when "0000001000" => y <= "0011";
            when "0000010000" => y <= "0100";
            when "0000100000" => y <= "0101";
            when "0001000000" => y <= "0110";
            when "0010000000" => y <= "0111";
            when "0100000000" => y <= "1000";
            when "1000000000" => y <= "1001";
            when others => y <= "1111";

        end case;
    end process;


end Behavioral;
