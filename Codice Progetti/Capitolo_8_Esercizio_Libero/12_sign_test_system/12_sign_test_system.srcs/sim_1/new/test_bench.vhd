library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity System_tb is
end;

architecture bench of System_tb is

  component System
      Port(
          CLK : in std_logic;
          RST : in std_logic;
          START : in std_logic
      );
  end component;

  signal CLK: std_logic := '0';
  signal RST: std_logic := '0';
  signal START: std_logic := '0';
  constant CLK_period : time := 10 ns;

begin

  uut: System port map ( CLK   => CLK,
                         RST   => RST,
                         START => START );
                         
  CLK_process : process
   begin
        clk <= '0';
        wait for CLK_period/2;
        clk <= '1';
        wait for CLK_period/2;
   end process;

  stimulus: process
  begin
        wait for 100ns;
        START <= '1';
      
    wait;
  end process;


end;