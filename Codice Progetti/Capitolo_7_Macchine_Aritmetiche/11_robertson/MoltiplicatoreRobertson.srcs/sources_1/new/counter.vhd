library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;
use ieee.std_logic_unsigned.all;

entity counter is
    generic(
        M : integer := 8
    );
    port(
        clk, rst, count, load : in std_logic;
        parallel_input : in std_logic_vector(integer(ceil(log2(real(M))))-1 downto 0);
        clk_out : out std_logic;
        Y : out std_logic_vector(integer(ceil(log2(real(M))))-1 downto 0)
    );
end counter;

architecture Behavioral of counter is

signal TY : std_logic_vector(integer(ceil(log2(real(M))))-1 downto 0);

begin
    Y <= TY;

    output : process(TY) begin
        if(conv_integer(TY) = M-1) then
            clk_out <= '1';
        else
            clk_out <= '0';
        end if;
    end process;

    process(clk) begin
        if(rising_edge(clk)) then
            if(rst = '1') then
                TY <= (others => '0');
            elsif(load = '1') then
                TY <= parallel_input;
            elsif(count = '1') then
                if(conv_integer(TY) >= M-1) then
                    TY <= (others => '0');
                else
                    TY <= TY + "1";
                end if; 
            end if;
        end if;    
    end process;

end Behavioral;

