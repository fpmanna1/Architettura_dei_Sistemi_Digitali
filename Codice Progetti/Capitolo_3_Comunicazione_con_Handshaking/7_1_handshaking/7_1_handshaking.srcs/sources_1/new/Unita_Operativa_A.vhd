library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Unita_Operativa_A is
    Port(
        CLK     :   in  std_logic;
        RST     :   in  std_logic;
        EN_COUNT:   in  std_logic;   -- enable del contatore
        READ    :   in  std_logic;   -- read per la memoria
        FINE    :   out std_logic;    -- segnale di fine, locazioni terminate
        DATA_A  :   out std_logic_vector(0 to 3)
    );
end Unita_Operativa_A;

architecture Structural of Unita_Operativa_A is

signal count_addr_out   :   std_logic_vector(0 to 2) := (others => '0');
signal rom_a_out        :   std_logic_vector(0 to 3) := (others => '0');

component ROM_in is
     port(
        clock       :   in  std_logic;
        reset       :   in  std_logic;
        read        :   in  std_logic;
        addr        :   in  std_logic_vector(0 to 2); --la memoria è composta da 8 locazioni
        value_out   :   out std_logic_vector(0 to 3)
    );
end component ROM_in;

component contatore is
    Port(
        clock   :   in  std_logic;
        reset   :   in  std_logic;
        enable  :   in  std_logic;
        counter :   out std_logic_vector(0 to 2);
        uscita  :   out std_logic
    );
end component contatore;

begin

Address_counter : contatore
    Port map(
        clock   => CLK,
        reset   => RST,
        enable  => EN_COUNT,
        counter => count_addr_out,
        uscita  => FINE
    );

ROM_A : ROM_in
    Port map(
        clock       => CLK,
        reset       => RST,
        read        => READ,
        addr        => count_addr_out,
        value_out   => DATA_A
    );
    

end Structural;

























