library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity system is
    port(
        clock        : in std_logic;
        reset        : in std_logic;
        start        : in std_logic
        --bit_omologhi : out std_logic_vector(0 to 3) --poichè le stringhe sono composte da 8 bit
        -- al massimo posso avere 8 bnit omologhi, dunque uso 3 bit
    );
end system;

architecture Structural of system is

-- SEGNALI IN INGRESSO ALLA UO DI A
signal data_out : std_logic_vector(0 to 7) := "00000000";
signal load_sr_x_temp : std_logic := '0';
signal load_sr_y_temp : std_logic := '0';
signal start_comp_temp : std_logic;

-- SEGNALI UNITA DI CONTROLLO A
signal req_temp : std_logic := '0';
signal ack_temp : std_logic := '0';


-- SEGNALI UNITA OPERATIVA B
signal en_read_temp : std_logic := '0';
signal en_count_addr_temp : std_logic := '0';
signal fine_loc_temp : std_logic := '0';

signal end_op_temp : std_logic := '0';

begin

--UO_A : entity work.Unita_Operativa_A
--    port map(
--        clock => clock,
--        reset => reset,
--        value_in => data_out,
--        load_sr_x => load_sr_x_temp,
--        load_sr_y => load_sr_y_temp,
--        en_compare => en_comp_temp
    
--    );
    
UO_A : entity work.comp_string
    port map(
        clock => clock,
        reset => reset,
        value_in => data_out,
        load_sr_x => load_sr_x_temp,
        load_sr_y => load_sr_y_temp,
        start_compare => start_comp_temp,
        end_operation => end_op_temp
    
    );
    
UC_A : entity work.Unita_Controllo_A
    port map(
        clock => clock,
        reset => reset,
        req => req_temp,
        fine_shift => end_op_temp,
        ack => ack_temp,
        en_compare => start_comp_temp,
        load_sr_x => load_sr_x_temp,
        load_sr_y => load_sr_y_temp
    );
    
UO_B : entity work.Unita_Operativa_B
    port map(
        clock => clock,
        reset => reset,
        en_read => en_read_temp,
        en_counter => en_count_addr_temp,
        value_out => data_out,
        fine_loc => fine_loc_temp 
    );
    
UC_B : entity work.Unita_Controllo_B
    port map(
        clock => clock,
        reset => reset,
        start => start,
        fine_loc => fine_loc_temp,
        ack => ack_temp,
        en_counter => en_count_addr_temp,
        en_read => en_read_temp,
        req => req_temp
    );
     
end Structural;
