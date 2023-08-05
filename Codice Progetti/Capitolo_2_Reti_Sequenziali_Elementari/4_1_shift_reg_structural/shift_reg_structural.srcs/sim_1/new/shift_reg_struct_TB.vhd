library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_shift_structural is

end TB_shift_structural;

architecture Behavioral of TB_shift_structural is

component shift_reg_structural is 
     Port (
        clock : in std_logic;
        rst : in std_logic;
        dir : in std_logic; --0(destra), 1(sinistra)
        mode : in std_logic; --0(un bit), 1 (due bit)
        ing : in std_logic;
        y : out std_logic_vector(0 to 3);
        en : in std_logic
     );
end component;

signal CLOCK: std_logic;
signal RST : std_logic := '0';
signal DIR : std_logic := '0';
signal MODE : std_logic := '0';
signal ING : std_logic := '0';
signal Y : std_logic_vector(0 to 3) := "0000";
signal EN : std_logic := '0';

constant CLK_period : time := 10 ns;

begin
uut: shift_reg_structural
port map(
    clock => CLOCK,
    rst => RST,
    dir => DIR,
    mode => MODE,
    ing => ING,
    y => Y,
    en => EN
);

CLK_process :process
   begin
		CLOCK <= '0';
		wait for CLK_period/2;
		CLOCK <= '1';
		wait for CLK_period/2;
   end process;
  
  stim_proc: process
   begin		
        wait for 100 ns;	
        wait for CLK_period*10;
		
		--1011, dunque lo stato finale dovrà essere 1101
        EN <= '0';
        DIR <= '0';
        MODE <= '0';
        
		wait for 10 ns;
		ING <= '1';
        wait for 10 ns;
        EN <= '1';
        wait for 10 ns;
        
        EN <= '0';
		wait for 10 ns;
		ING <= '0';
        wait for 10 ns;
        EN <= '1';
        wait for 10 ns;
        
        EN <= '0';
		wait for 10 ns;
		ING <= '1';
        wait for 10 ns;
        EN <= '1';
        wait for 10 ns;
        
        EN <= '0';
		wait for 10 ns;
		ING <= '1';
        wait for 10 ns;
        EN <= '1';
        
      wait;
   end process;
end Behavioral;
