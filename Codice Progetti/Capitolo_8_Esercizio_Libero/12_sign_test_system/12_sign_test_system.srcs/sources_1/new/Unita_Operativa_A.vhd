library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Unita_Operativa_A is
    Port(
        clock       : in std_logic;
        reset       : in std_logic;
        en_count    : in std_logic;
        en_read     : in std_logic;
        fine        : out std_logic;
        sum_out     : out std_logic_vector(0 to 4)
    );
end Unita_Operativa_A;

architecture Behavioral of Unita_Operativa_A is

-- segnali uscita contatore
signal counter_addr_out : std_logic_vector(0 to 2) := (others => '0');

-- segnali uscita delle ro
signal rom1_out         : std_logic_vector(0 to 3) := (others => '0');
signal rom2_out         : std_logic_vector(0 to 3) := (others => '0');

component ROM_in is
    port(
        clock       : in  std_logic;
        reset       : in  std_logic;
        read        : in  std_logic;
        addr        : in  std_logic_vector(0 to 2); --la memoria è composta da 8 locazioni
        value_out   : out std_logic_vector(0 to 3)
    );
end component ROM_in;

component contatore is
       Port(
        clock   : in  std_logic;
        reset   : in  std_logic;
        enable  : in  std_logic;
        counter : out std_logic_vector(0 to 2);
        uscita  : out std_logic
    );
end component contatore;

component RippleCarryAdder is
Port(
    a: in std_logic_vector (0 to 3);
    b: in std_logic_vector (0 to 3);
    c_in: in std_logic;
    c_out: out std_logic;
    s: out std_logic_vector (0 to 3)
  );
end component RippleCarryAdder;

begin

ROM_A1 : ROM_in 
    Port map(
        clock       => clock,
        reset       => reset,
        read        => en_read,
        addr        => counter_addr_out,
        value_out   => rom1_out
    );
    
 ROM_A2 : ROM_in 
    Port map(
        clock       => clock,
        reset       => reset,
        read        => en_read,
        addr        => counter_addr_out,
        value_out   => rom2_out
    );

counter : contatore
    Port map(
        clock   =>  clock,
        reset   =>  reset,
        enable  =>  en_count,
        counter =>  counter_addr_out,
        uscita  =>  fine
    );


adder : RippleCarryAdder
    Port map(
        a       => rom1_out,
        b       => rom2_out,
        c_in    => '0',
        c_out   => sum_out(0),
        s       => sum_out(1 to 4)
    );


end Behavioral;
