library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity System is
    Port(
        CLOCK : in std_logic;
        RESET : in std_logic;
        START : in std_logic
    );
end System;

architecture Structural of System is

-- segnali uscita di A
signal req_out          : std_logic := '0';
signal read_rom_out     : std_logic := '0';
signal en_count_a_out   : std_logic := '0';
signal DATA_A_OUT       : std_logic_vector(0 to 3) := (others => '0');

signal fine_tmp         : std_logic := '0';
signal fine_b         : std_logic := '0';


-- segnali uscita di B
signal ack_out          : std_logic := '0';
signal write_mem_out    : std_logic := '0';
signal read_mem_out     : std_logic := '0';
signal en_count_b_out   : std_logic := '0';
signal en_add_out       : std_logic := '0';

component Unita_Operativa_A is
    Port(
        CLK         :   in  std_logic;
        RST         :   in  std_logic;
        EN_COUNT    :   in  std_logic;   -- enable del contatore
        READ        :   in  std_logic;   -- read per la memoria
        FINE        :   out std_logic;    -- segnale di fine, locazioni terminate
        DATA_A      :   out std_logic_vector(0 to 3)
    );
end component Unita_Operativa_A;

component Unita_Operativa_B is
    Port(
        CLK         :   in  std_logic;
        RST         :   in  std_logic;
        EN_COUNT    :   in  std_logic;   -- enable del contatore
        EN_ADD      :   in  std_logic;
        WRITE       :   in  std_logic;   -- write per la memoria 
        READ        :   in  std_logic;   -- read per la memoria
        DATA_A      :   in  std_logic_vector(0 to 3);
        FINE        :   out std_logic    -- segnale di fine, locazioni terminate
    );
end component Unita_Operativa_B;

component Unita_Controllo_A is
    Port(
        clock       :   in  std_logic;
        reset       :   in  std_logic;
        start       :   in  std_logic;
        fine        :   in  std_logic;
        ack         :   in  std_logic;
        req         :   out std_logic;  -- request to send
        read_mem    :   out std_logic;
        en_count    :   out std_logic
    );
end component Unita_Controllo_A;


component Unita_Controllo_B is
    Port(
        clock       :   in  std_logic;
        reset       :   in  std_logic;
        req         :   in  std_logic;  -- request to send
        fine_in     :   in  std_logic;
        fine_out    :   out std_logic;
        ack         :   out std_logic;
        write_mem   :   out std_logic;
        read_mem    :   out std_logic;
        en_count    :   out std_logic;
        en_add      :   out std_logic
    );
end component Unita_Controllo_B;

begin

UC_A : Unita_Controllo_A
    Port map(
        clock       => CLOCK,
        reset       => RESET,
        start       => START,
        fine        => fine_tmp,
        ack         => ack_out,
        req         => req_out,   
        read_mem    => read_rom_out,
        en_count    => en_count_a_out
    );

UC_B : Unita_Controllo_B
    Port map(
        clock       => CLOCK,
        reset       => RESET,
        req         => req_out,
        fine_in     => fine_tmp,
        fine_out    => fine_b,
        ack         => ack_out,
        write_mem   => write_mem_out,
        read_mem    => read_mem_out,
        en_count    => en_count_b_out,
        en_add      => en_add_out
    );

UO_A : Unita_Operativa_A 
    Port map(
        CLK         => CLOCK,
        RST         => RESET,
        EN_COUNT    => en_count_a_out,
        READ        => read_rom_out,
        FINE        => fine_b,
        DATA_A      => DATA_A_OUT
    );

UO_B : Unita_Operativa_B
    Port map(
        CLK         => CLOCK,
        RST         => RESET,
        EN_COUNT    => en_count_b_out,
        EN_ADD      => en_add_out,
        WRITE       => write_mem_out,
        READ        => read_mem_out,
        DATA_A      => DATA_A_OUT,
        FINE        => fine_tmp    -- segnale del contatore
    );

end Structural;
