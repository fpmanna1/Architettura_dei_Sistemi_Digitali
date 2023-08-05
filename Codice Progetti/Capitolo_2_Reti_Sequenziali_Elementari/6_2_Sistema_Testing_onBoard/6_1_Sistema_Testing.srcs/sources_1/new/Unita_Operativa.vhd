library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Unita_Operativa is
    port(
        CLOCK           : in std_logic;
        RESET           : in std_logic;
        reset_mem       : in std_logic;
        read_rom        : in std_logic;
        read_rom_2      : in std_logic; --rom con i risultati giusti
        write_mem       : in std_logic;
        enable          : in std_logic;
        enable_counter  : in std_logic;
        load            : in std_logic;
        fine            : out std_logic;
        test            : out std_logic
    );
end Unita_Operativa;

architecture Structural of Unita_Operativa is

signal count_out_tmp : std_logic_vector(0 to 2) := "000";
signal data_in       : std_logic_vector(0 to 3) := "0000";
signal data_out      : std_logic_vector(0 to 2) := "000";
signal data_out_temp : std_logic_vector(0 to 2) := "000";
signal data_out_exp  : std_logic_vector(0 to 2) := "000";

component counter is
    Port( 
        clock   : in   STD_LOGIC;
        reset   : in   STD_LOGIC;
		enable  : in   STD_LOGIC; 
        counter : out  STD_LOGIC_VECTOR (0 to 2);
        uscita  : out  STD_LOGIC
        );
end component;

component ROM_in is
    port(
        clock : in std_logic;
        reset : in std_logic;
        read  : in std_logic;
        addr  : in std_logic_vector(0 to 2); 
        y     : out std_logic_vector(0 to 3)
    );
end component;

component m_comb is
    port(
        input  : in std_logic_vector(0 to 3);
        output : out std_logic_vector(0 to 2)
    );
end component;

component MEM_out is
    port(
        clock : in std_logic;
        reset : in std_logic;
        write : in std_logic;
        addr  : in std_logic_vector(0 to 2);
        value : in std_logic_vector(0 to 2)
    );
end component;

component ROM_results is
    port(
        clock : in std_logic;
        reset : in std_logic;
        read : in std_logic;
        addr : in std_logic_vector(0 to 2);
        y : out std_logic_vector(0 to 2)
    );
end component;

component comparatore is
    port(
        clock : in std_logic;
        en    : in std_logic;
        val1  : in std_logic_vector(0 to 2);
        val2  : in std_logic_vector(0 to 2);
        load  : in std_logic;
        y     : out std_logic
    );
end component;

begin

cont : counter
    port map(
        clock => CLOCK,
        reset => RESET,
        enable => enable_counter,
        counter => count_out_tmp,
        uscita => fine
    );
    
rom_input : ROM_in
    port map(
        clock => CLOCK,
        reset => RESET,
        read  => read_rom,
        addr => count_out_tmp,
        y => data_in
    );

comb : m_comb
    port map(
        input => data_in,
        output => data_out
    );
    
mem_output : MEM_out
    port map(
        clock => CLOCK,
        reset => reset_mem,
        write => write_mem,
        addr => count_out_tmp,
        value => data_out --valore da memorizzare
    );
       
rom_expected_results : ROM_results
    port map(
        clock => CLOCK,
        reset => RESET,
        read => read_rom_2,
        addr => count_out_tmp,
        y => data_out_exp
    );
       
comp : comparatore
    port map(
        clock => CLOCK,
        en => enable,
        val1 => data_out, -- dato in uscita dalla macchina combinatoria
        val2 => data_out_exp,
        load => load,
        y => test
    );    

end Structural;
