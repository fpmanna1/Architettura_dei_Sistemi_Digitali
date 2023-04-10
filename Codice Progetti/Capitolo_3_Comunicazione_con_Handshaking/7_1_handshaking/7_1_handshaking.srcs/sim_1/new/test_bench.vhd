library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity System_tb is
end;

architecture bench of System_tb is

  component System
      Port(
          CLOCK : in std_logic;
          RESET : in std_logic;
          START : in std_logic
      );
  end component;

  signal CLOCK: std_logic := '0';
  signal RESET: std_logic := '0';
  signal START: std_logic := '0';
  constant CLK_period : time := 10ns; 

begin

  uut: System port map ( CLOCK => CLOCK,
                         RESET => RESET,
                         START => START );

  clk_process : process
    begin
        CLOCK <= '0';
        wait for CLK_period/2;
        CLOCK <= '1';
        wait for CLK_period/2;    
    end process;

  stimulus: process
  begin
    wait for 100ns;
    
    START <= '1';
    
    wait for 10ns;
    
    wait;
  end process;


end;