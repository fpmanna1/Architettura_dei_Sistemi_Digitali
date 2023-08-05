library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity comp_string is
    port(
        clock : in std_logic;
        reset : in std_logic;
        value_in : std_logic_vector(0 to 7); -- stringa in ingresso allo shift register
        load_sr_x : in std_logic;
        load_sr_y : in std_logic;
        start_compare : in std_logic;
        end_operation : out std_logic -- uscita del contatore delle cifre/shift
        --reset_cont_bit_omol : out std_logic
    );
end comp_string;

architecture Structural of comp_string is

signal en_shift_temp : std_logic := '0';
signal out_x : std_logic := '0';
signal out_y : std_logic := '0';
signal en_comp_bit_temp : std_logic := '0';
signal en_comp_gt_lt_temp : std_logic := '0';
signal en_count_shift_temp : std_logic := '0';
signal en_count_bit_omol_temp : std_logic := '0'; 
signal en_count_interno_temp : std_logic := '0';

signal reset_cont_bit_omol : std_logic := '0';
signal reset_cont_cifre : std_logic := '0';

signal count_out_shift : std_logic_vector(0 to 2) := "000";
signal count_out_bit_omol : std_logic_vector(0 to 2) := "000";
signal count_out_interno : std_logic_vector(0 to 2) := "000";

signal fine_bit_omol : std_logic := '0';
signal fine_cifre_temp : std_logic := '0';
signal fine_interno_temp : std_logic := '0';


signal eq_temp : std_logic := '0';
signal x_gt_y_temp : std_logic := '0';
signal x_lt_y_temp : std_logic := '0';

begin

sr_x : entity work.shift_reg
    port map(
        clock => clock,
        reset => reset,
        load => load_sr_x,
        shift => en_shift_temp,
        p_in => value_in,
        s_out => out_x
    );
    
sr_y : entity work.shift_reg
    port map(
        clock => clock,
        reset => reset,
        load => load_sr_y,
        shift => en_shift_temp,
        p_in => value_in,
        s_out => out_y
    );
    
cont_bit_omol : entity work.counter
    generic map(
        M => 8
    )
    port map(
        clock => clock,
        reset => reset_cont_bit_omol,
        enable => en_count_bit_omol_temp,
        count => count_out_bit_omol,
        fine => fine_bit_omol
    );

cont_cifre : entity work.counter
    generic map(
        M => 8
    )
    port map(
        clock => clock,
        reset => reset_cont_cifre,
        enable => en_count_shift_temp,
        count => count_out_shift,
        fine => fine_cifre_temp
    );
    
cont_interno : entity work.counter
    generic map(
        M => 8
    )
    port map(
        clock => clock,
        reset => reset,
        enable => en_count_interno_temp,
        count => count_out_interno,
        fine => fine_interno_temp
    );
 

comp_bit : entity work.comp_bit
    port map(
        x => out_x,
        y => out_y,
        enable => en_comp_bit_temp,
        enable_gt_lt => en_comp_gt_lt_temp,
        eq => eq_temp,
        x_gt_y => x_gt_y_temp,
        x_lt_y => x_lt_y_temp
    );
    
    
UC_comp_string : entity work.Unita_Controllo_Comp
    port map(
        clock => clock,
        reset => reset,
        start_comp => start_compare, -- proveniente dall'unità di controllo di A
        fine_cifre => fine_cifre_temp,
        x_gt_y => x_gt_y_temp,
        x_lt_y => x_lt_y_temp,
        eq => eq_temp,
        en_shift => en_shift_temp,
        en_comp => en_comp_bit_temp,
        en_comp_gt_lt => en_comp_gt_lt_temp,
        en_count_shift => en_count_shift_temp,
        en_count_bit_omol => en_count_bit_omol_temp,
        en_count_interno => en_count_interno_temp,
        reset_cont_bit_omol => reset_cont_bit_omol,
        reset_cont_cifre => reset_cont_cifre,
        count_value_bit_omol => count_out_bit_omol
        --count_value_cifre => count_out_shift
    );
    
    
    end_operation <= fine_cifre_temp;
    
end Structural;
