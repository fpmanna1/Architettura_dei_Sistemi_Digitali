library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity testbench is
--  Port ( );
end testbench;

architecture Behavioral of testbench is
component system is
 Port(
       s0 : in std_logic_vector(0 to 5);
       s1 : in std_logic_vector(0 to 5);
       s2 : in std_logic_vector(0 to 5);
       s3 : in std_logic_vector(0 to 5);
       e  : in std_logic_vector(0 to 3);
       y0 : out std_logic_vector(0 to 1);
       y1 : out std_logic_vector(0 to 1);
       y2 : out std_logic_vector(0 to 1);
       y3 : out std_logic_vector(0 to 1)
       );
end component;

signal start: std_logic;
signal S0: std_logic_vector(0 to 5);
signal S1: std_logic_vector(0 to 5);
signal S2: std_logic_vector(0 to 5);
signal S3: std_logic_vector(0 to 5);
signal Y0: std_logic_vector(0 to 1);
signal Y1: std_logic_vector(0 to 1);
signal Y2: std_logic_vector(0 to 1);
signal Y3: std_logic_vector(0 to 1);
signal E: std_logic_vector(0 to 3);
begin

uut: system
port map(
    S0,S1,S2,S3,
    E,
    Y0,Y1,Y2,Y3
);

proc: process
begin
wait for 10 ns;
-----s0,s1,d0,d1
S0 <= "001011";
S1 <= "011010";
S2 <= "101001";
S3 <= "111101";
--S0 <= "110100";
--S1 <= "010110";
--S2 <= "100101";
--S3 <= "101111";
E <= "1001"; --da SX-DX il X3,X2,X1,X0
wait;
end process;
end Behavioral;
