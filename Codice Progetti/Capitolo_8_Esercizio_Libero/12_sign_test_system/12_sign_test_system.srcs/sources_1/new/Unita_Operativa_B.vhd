library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Unita_Operativa_B is
    Port(
        clock       : in std_logic;
        reset       : in std_logic;
        en_count    : in std_logic;
        en_write    : in std_logic;
        en_reg      : in std_logic;
        en_comp     : in std_logic;
        sum_in      : in std_logic_vector(0 to 4)  
    );
end Unita_Operativa_B;

architecture Behavioral of Unita_Operativa_B is

signal counter_addr_out1    : std_logic_vector(0 to 2) := (others => '0');
signal counter_addr_out2    : std_logic_vector(0 to 2) := (others => '0');
signal counter_out1         : std_logic := '0';
signal counter_out2         : std_logic := '0';

signal res_comp             : std_logic := '0';

signal count_sel            : std_logic_vector(0 to 1) := (others => '0');
signal mem_sel              : std_logic_vector(0 to 1) := (others => '0');

signal en_count1            : std_logic := '0';
signal en_count2            : std_logic := '0';

signal en_mem1              : std_logic := '0';
signal en_mem2              : std_logic := '0';

signal reg_val              : std_logic_vector(0 to 4) := (others => '0');

component memory is
    Port(
        clock       : in std_logic;
        reset       : in std_logic;
        write       : in std_logic;
        addr        : in std_logic_vector(0 to 2);
        value_in    : in std_logic_vector(0 to 4) -- somma
    );    
end component memory;

component Reg is
   Port(
        clock : in std_logic;
        reset : in std_logic;
        enable : in std_Logic;
        value_in : in std_logic_vector(0 to 4);
        value_out : out std_logic_vector(0 to 4)
    );
end component Reg;

component contatore is
    Port(
        clock   :   in  std_logic;
        reset   :   in  std_logic;
        enable  :   in  std_logic;
        counter :   out std_logic_vector(0 to 2);
        uscita  :   out std_logic
    );
end component contatore;

component Demux1_2 is
    Port(
        X   : in  std_logic;
        SEL : in  std_logic;
        Y   : out std_logic_vector(0 to 1)
    );
end component Demux1_2;

component CompB is
    Port( 
        enable : in std_logic;
        sum_in : in std_logic_vector(0 to 4);
        res : out std_logic
    );
end component CompB;

begin

MEM1 : memory
    Port map(
        clock       => clock,
        reset       => reset,
        write       => en_mem1,
        addr        => counter_addr_out1,
        value_in    => reg_val
    );
    
MEM2 : memory
    Port map(
        clock       => clock,
        reset       => reset,
        write       => en_mem2,
        addr        => counter_addr_out2,
        value_in    => reg_val
    );

sum_register : Reg
    Port map(
        clock => clock,
        reset => reset,
        enable => en_reg,
        value_in => sum_in,
        value_out => reg_val
    );
    
counter1 : contatore
    Port map(
        clock   => clock,
        reset   => reset,
        enable  => en_count1,
        counter => counter_addr_out1,
        uscita  => counter_out1
    );
 
counter2 : contatore
    Port map(
        clock   => clock,
        reset   => reset,
        enable  => en_count2,
        counter => counter_addr_out2,
        uscita  => counter_out2
    );
    
demux_count : Demux1_2
    Port map(
        X   => en_count,
        SEL => res_comp,
        Y(0)   => en_count1,
        Y(1)   => en_count2
    );

demux_mem : Demux1_2
    Port map(
        X   => en_write,
        SEL => res_comp,
        Y(0)   => en_mem1,
        Y(1)   => en_mem2
    );
    
comp : CompB
    Port map(
        enable  => en_comp,
        sum_in  => sum_in,
        res     => res_comp
    );

end Behavioral;
