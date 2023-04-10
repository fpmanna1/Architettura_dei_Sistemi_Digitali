library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FullAdder is
  Port ( 
      a         :   in  std_logic;
      b         :   in  std_logic;
      carry_in  :   in  std_logic;
      carry_out :   out std_logic;
      ris       :   out std_logic
  );
end FullAdder;
architecture Dataflow of FullAdder is 
begin
    ris         <= ((a xor b) xor carry_in);
    carry_out   <= ((a and b) or (carry_in and (a xor b)));
end Dataflow;

