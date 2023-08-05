library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;
use ieee.std_logic_unsigned.all;


entity Unita_Controllo_Comp is
    port(
        clock : in std_logic;
        reset : in std_logic;
        start_comp : in std_logic; -- start proveniente dalla UC di A
        fine_cifre : in std_logic; -- in ingresso dal contatore del numero di shift
        
        x_gt_y : in std_logic;
        x_lt_y : in std_logic;
        eq : in std_logic;
        
        en_shift : out std_logic;
        en_comp : out std_logic; -- abilita il confronto globale del comparatore di bit
        en_comp_gt_lt : out std_logic; -- abilita il confronto del tipo > o <
        en_count_shift : out std_logic;
        en_count_bit_omol : out std_logic;
        en_count_interno : out std_logic;
        
        reset_cont_bit_omol : out std_logic;
        reset_cont_cifre : out std_logic;
        
        count_value_bit_omol : in std_logic_vector(0 to 2)
    
    );
end Unita_Controllo_Comp;

architecture Behavioral of Unita_Controllo_Comp is

type status is (idle, shift, compare_bit, wait_compare, bit_omol_increment, shift_increment, end_check);
signal curr : status := idle;

signal stop_gt_lt : std_logic := '0';
-- una volta inizializzato a 0, se transita nello stato di 1 non tornerà
-- più a 0, per conseg

begin


fsmComp : process(clock)
begin

    if reset = '1' then
        en_shift <= '0';
        en_comp <= '0';
        en_comp_gt_lt <= '0';
        en_count_shift <= '0';
        en_count_bit_omol <= '0';
        reset_cont_bit_omol <= '1';
        reset_cont_cifre <= '1';
        
        en_count_interno <= '0';
    
    end if;
    
    
    if rising_edge(clock) then
        case curr is
            when idle =>
                en_shift <= '0';
                en_comp <= '0';
                en_comp_gt_lt <= '0';
                en_count_shift <= '0';
                en_count_bit_omol <= '0';
                en_count_interno <= '0';
                reset_cont_bit_omol <= '1';
                reset_cont_cifre <= '1';
                -- resetto contatore delle cifre per poter lavorare
                -- sulle due nuove stringhe
               
                if(start_comp = '1') then
                    curr <= compare_bit;
                else
                    curr <= idle;
                end if;
                
             when compare_bit =>
                reset_cont_bit_omol <= '0';
                en_shift <= '0';
                en_comp <= '1';
                en_comp_gt_lt <= '1' and not stop_gt_lt;
                en_count_shift <= '0';
                en_count_bit_omol <= '0';
                en_count_interno <= '0';
                
                if( x_gt_y = '1' OR x_lt_y = '1') then
                    stop_gt_lt <= '1'; -- voglio disattivare il < o >
                    -- significa che ho capito quale stringa è maggiore,
                    -- quindi posso abbassare l'abilitazione della modalità
                    -- di confronto < o >
                    -- per farlo sfrutto una and del segnale di abilitazione
                    -- del modo < o > con il segnale stop_gt_lt
                    
                end if;
                curr <= wait_compare;
                
             when wait_compare =>
                en_shift <= '0';
                en_comp <= '1';
                en_comp_gt_lt <= '1' and not stop_gt_lt;
                en_count_shift <= '0';
                en_count_bit_omol <= '0';
                en_count_interno <= '0';
                if eq = '1' then
                    curr <= bit_omol_increment;
                else
                    curr <= shift;
                end if;
                
             when bit_omol_increment =>
                en_shift <= '0';
                en_comp <= '0';
                en_comp_gt_lt <= '0';
                en_count_shift <= '0';
                en_count_bit_omol <= '1';
                en_count_interno <= '0';
                curr <= shift;
                
             when shift =>
                reset_cont_bit_omol <= '0';
                reset_cont_cifre <= '0';
                en_shift <= '1';
                en_comp <= '0';
                --en_comp_gt_lt <= '0';
                en_count_shift <= '0';
                en_count_bit_omol <= '0';
                en_count_interno <= '0';
                curr <= shift_increment;
                
             when shift_increment =>
                en_shift <= '0';
                en_comp <= '0';
                en_comp_gt_lt <= '0';
                en_count_shift <= '1';
                en_count_bit_omol <= '0';
                en_count_interno <= '0';
                curr <= end_check;
                
             when end_check =>
                en_shift <= '0';
                en_comp <= '0';
                en_comp_gt_lt <= '0';
                en_count_shift <= '0';
                en_count_bit_omol <= '0';
                if fine_cifre = '1' then
                   if to_integer(unsigned(count_value_bit_omol)) > 4 then
                        en_count_interno <= '1';
                   else
                        en_count_interno <= '0';
                   end if;
                   curr <= idle;
                else
                    curr <= compare_bit;
                end if;
           end case;
       end if;
end process;

end Behavioral;
