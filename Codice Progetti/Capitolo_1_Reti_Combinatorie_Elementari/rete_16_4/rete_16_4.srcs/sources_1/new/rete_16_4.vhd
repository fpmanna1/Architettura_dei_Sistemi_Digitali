----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.01.2023 18:18:15
-- Design Name: 
-- Module Name: rete_16_4 - structural
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


entity rete_16_4 is
    port(
        a : in std_logic_vector(0 to 15);
        s : in std_logic_vector(5 downto 0); 
        y : out std_logic_vector(0 to 3)
    );

end rete_16_4;

architecture structural of rete_16_4 is

    signal f: std_logic;

    component mux_16_1 is
        port(
            a : in std_logic_vector(0 to 15);
            s : in std_logic_vector(3 downto 0);
            y : out std_logic
        );
     end component;
     
     component demux_1_4 is
        port(
            x : in std_logic;
            k : in std_logic_vector(1 downto 0);
            z : out std_logic_vector(0 to 3)
        );
     end component;
        
     begin
        mux : mux_16_1
        port map(
            a(0 to 15) => a(0 to 15), --a sinistra mux 16:1, a dx rete 16:4
            s(3 downto 0) => s(5 downto 2),
            y => f
        );
        
        demux : demux_1_4
        port map(
            x => f,
            k(1 downto 0) => s(1 downto 0),
            z(0 to 3) => y(0 to 3)
        );
            
            
     end structural;
                       
    
