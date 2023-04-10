library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity adder is
    Port(
        clock   :   in  std_logic;
        reset   :   in  std_logic;
        enable  :   in  std_logic;
        op1     :   in  std_logic_vector(0 to 3);
        op2     :   in  std_logic_vector(0 to 3);
        sum     :   out std_logic_vector(0 to 4)
    );
end adder;

architecture Behavioral of adder is

begin

process(clock, reset)
variable a : integer := 0;
variable b : integer := 0;
variable z : integer := 0;
begin
    if rising_edge(clock) then
        if reset = '1' then
            sum <= (others => '0');
        end if;
        if enable = '1' then
            a := to_integer(unsigned(op1));
            b := to_integer(unsigned(op2));
            z := a+b;
            sum <= std_logic_vector(to_unsigned(z, 5));
        end if;
    end if;
    
end process;


end Behavioral;
