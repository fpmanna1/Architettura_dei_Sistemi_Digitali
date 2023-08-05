library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Unita_Operativa_B is
    port(
        clock : in std_logic;
        reset : in std_logic;
        en_read : in std_logic;
        en_counter : in std_logic;
        value_out : out std_logic_vector(0 to 7); -- stringhe da inviare agli shift reg.
        fine_loc : out std_logic -- fine lettura locazioni ROM
    );
end Unita_Operativa_B;

architecture Structural of Unita_Operativa_B is

signal count_out_temp : std_logic_vector(0 to 1) := "00";

begin

ROM : entity work.ROM
    port map(
        clock => clock,
        reset => reset,
        read => en_read,
        addr => count_out_temp,
        value_out => value_out
   
    );

counter : entity work.Counter
    generic map(
        M => 4
    )
    port map(
        clock => clock,
        reset => reset,
        enable => en_counter,
        count => count_out_temp,
        fine => fine_loc
    );
    
end Structural;
