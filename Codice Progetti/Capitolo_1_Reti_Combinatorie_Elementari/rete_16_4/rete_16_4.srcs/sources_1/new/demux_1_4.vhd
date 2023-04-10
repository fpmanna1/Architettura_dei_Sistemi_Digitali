----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.01.2023 17:13:14
-- Design Name: 
-- Module Name: demux_4_1 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity demux_1_4 is
    port(
        x : in std_logic; 
        k : in std_logic_vector(1 downto 0);
        z : out std_logic_vector(0 to 3)
    );

end demux_1_4;

architecture Behavioral of demux_1_4 is

begin
    process(x, k)
    begin
        if(k = "00") then 
        z(0) <= x;
        z(1) <= '0';
        z(2) <= '0';
        z(3) <= '0';
        elsif(k = "01") then
        z(0) <= '0';
        z(1) <= x;
        z(2) <= '0';
        z(3) <= '0';
        elsif(k = "10") then
        z(0) <= '0';
        z(1) <= '0';
        z(2) <= x; 
        z(3) <= '0';
        elsif(k = "11") then
        z(0) <= '0';
        z(1) <= '0';
        z(2) <= '0';
        z(3) <= x;
        end if;

    end process;
end Behavioral;
