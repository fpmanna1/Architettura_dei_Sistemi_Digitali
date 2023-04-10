library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity System is
    Port(
        CLK : in std_logic;
        RST : in std_logic;
        START : in std_logic
    );
end System;

architecture Behavioral of System is

-- sengali uscita di A
signal en_count_a : std_logic := '0';
signal en_read_a : std_logic := '0';
signal fine_out : std_logic := '0';
signal sum_tmp  : std_logic_vector(0 to 4) := (others => '0');
signal req_tmp  : std_logic := '0';

-- segnali uscita di B
signal en_count_b : std_logic := '0';
signal en_write_b : std_logic := '0';
signal load_out : std_logic := '0'; -- enable register
signal en_comp_b : std_logic := '0';
signal ack_tmp : std_logic := '0';

component Unita_Operativa_A is
Port(
        clock       : in std_logic;
        reset       : in std_logic;
        en_count    : in std_logic;
        en_read     : in std_logic;
        fine        : out std_logic;
        sum_out     : out std_logic_vector(0 to 4)
    );
end component Unita_Operativa_A;

component Unita_Controllo_A is
    Port(
        clock       :   in  std_logic;
        reset       :   in  std_logic;
        start       :   in  std_logic;
        ack         :   in  std_logic;
        fine        :   in  std_logic;
        req         :   out std_logic;
        en_count    :   out std_logic;
        en_read     :   out std_logic
    );
end component Unita_Controllo_A;

component Unita_Operativa_B is
    Port(
        clock       : in std_logic;
        reset       : in std_logic;
        en_count    : in std_logic;
        en_write    : in std_logic;
        en_reg      : in std_logic;
        en_comp     : in std_logic;
        sum_in      : in std_logic_vector(0 to 4)  
    );
end component Unita_Operativa_B;

component Unita_Controllo_B is
    Port(
        clock       :   in  std_logic;
        reset       :   in  std_logic;
        req         :   in  std_logic;
        ack         :   out std_logic;
        load        :   out std_logic;
        en_count    :   out std_logic;
        en_write    :   out std_logic;
        en_comp     :   out std_logic
    );
end component Unita_Controllo_B;

begin

UO_A : Unita_Operativa_A 
    Port map(
        clock       => CLK,
        reset       => RST,
        en_count    => en_count_a,
        en_read     => en_read_a,
        fine        => fine_out,
        sum_out     => sum_tmp
    );

UC_A : Unita_Controllo_A
    Port map(
        clock       => CLK,
        reset       => RST,
        start       => START,
        ack         => ack_tmp,
        fine        => fine_out,
        req         => req_tmp,
        en_count    => en_count_a,
        en_read     => en_read_a
    );


UO_B : Unita_Operativa_B
    Port map(
        clock       => CLK,
        reset       => RST,
        en_count    => en_count_b,
        en_write    => en_write_b,
        en_reg      => load_out,
        en_comp     => en_comp_b,
        sum_in      => sum_tmp
    );
    
    
UC_B : Unita_Controllo_B
    Port map(
        clock       => CLK,
        reset       => RST,
        req         => req_tmp,
        ack         => ack_tmp,
        load        => load_out,
        en_count    => en_count_b,
        en_write    => en_write_b,
        en_comp     => en_comp_b
    );
    
end Behavioral;
