library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity Sistema_Testing_tb is
end;

architecture bench of Sistema_Testing_tb is

  component Sistema_Testing
      port(
          clock : in std_logic;
          reset : in std_logic;
          reset_mem : in std_logic;
          start : in std_logic;
          test : out std_logic
      );
  end component;

  signal clock: std_logic;
  signal reset: std_logic := '0';
  signal reset_mem: std_logic := '0';
  signal start: std_logic :='0';
  signal uscita_test: std_logic := '0';
  constant CLK_period : time := 10 ns;

begin

  uut: Sistema_Testing port map ( clock     => clock,
                                  reset     => reset,
                                  reset_mem => reset_mem,
                                  start     => start,
                                  test      => uscita_test );

 -- Clock process definitions
   CLK_process :process
   begin
		clock <= '0';
		wait for CLK_period/2;
		clock <= '1';
		wait for CLK_period/2;
   end process;
   
stim_proc: process
   begin		
      -- hold reset state for 100 ns.
     
      wait for 100 ns;	
      wait for CLK_period*10; 
      start <= '1';
      wait for 50 ns;
      start <= '0';
     wait;
   end process;
   
end bench;
