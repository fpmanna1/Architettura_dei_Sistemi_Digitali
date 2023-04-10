library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Unita_Operativa_B is
    Port(
        CLK         :   in  std_logic;
        RST         :   in  std_logic;
        EN_COUNT    :   in  std_logic;                  -- enable del contatore
        EN_ADD      :   in  std_logic;                  -- enable del sommatore
        WRITE       :   in  std_logic;                  -- write per la memoria 
        READ        :   in  std_logic;                  -- read per la memoria
        DATA_A      :   in  std_logic_vector(0 to 3);   -- operando proveniente da A
        FINE        :   out std_logic                   -- segnale di fine; locazioni terminate
    );
end Unita_Operativa_B;

architecture Behavioral of Unita_Operativa_B is

signal count_addr_out   :   std_logic_vector(0 to 2) := (others => '0');
signal DATA_B           :   std_logic_vector(0 to 3) := (others => '0');
signal sum_out          :   std_logic_vector(0 to 4) := (others => '0');

component ROM_in is
     port(
        clock       :   in  std_logic;
        reset       :   in  std_logic;
        read        :   in  std_logic;
        addr        :   in  std_logic_vector(0 to 2); --la memoria è composta da 8 locazioni
        value_out   :   out std_logic_vector(0 to 3)
    );
end component ROM_in;

component memory is
    Port(
        clock       :   in  std_logic;
        reset       :   in  std_logic;
        write       :   in  std_logic;
        addr        :   in  std_logic_vector(0 to 2);
        value_in    :   in  std_logic_vector(0 to 4)
    );
end component memory;

component contatore is
    Port(
        clock   :   in  std_logic;
        reset   :   in  std_logic;
        enable  :   in  std_logic;
        counter :   out std_logic_vector(0 to 2);
        uscita  :   out std_logic
    );
end component contatore;


component adder is
    Port(
        clock   :   in  std_logic;
        reset   :   in  std_logic;
        enable  :   in  std_logic;
        op1     :   in  std_logic_vector(0 to 3);
        op2     :   in  std_logic_vector(0 to 3);
        sum     :   out std_logic_vector(0 to 4)
    );
end component adder;

begin
    
Address_counter : contatore
    Port map(
        clock   => CLK,
        reset   => RST,
        enable  => EN_COUNT,
        counter => count_addr_out,
        uscita  => FINE
    );

Adder_B : adder
    Port map(
        clock   => CLK,
        reset   => RST,
        enable  => EN_ADD,
        op1     => DATA_A,
        op2     => DATA_B,
        sum     => sum_out
    );

ROM_B: ROM_in
    Port map(
        clock       => CLK,
        reset       => RST,
        read        => READ,
        addr        => count_addr_out,
        value_out   => DATA_B
    );
    
MEM_B : memory
    Port map(
        clock       => CLK,
        reset       => RST,
        write       => WRITE,
        addr        => count_addr_out,
        value_in    => sum_out
    );


end Behavioral;







