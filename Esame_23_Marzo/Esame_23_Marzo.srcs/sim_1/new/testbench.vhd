library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity system_tb is
end;

architecture bench of system_tb is

  component system
      port(
          clock        : in std_logic;
          reset        : in std_logic;
          start        : in std_logic
      );
  end component;

  signal clock: std_logic;
  signal reset: std_logic;
  signal start: std_logic;
  constant CLK_period : time := 10 ns;

begin

  uut: system port map ( clock => clock,
                         reset => reset,
                         start => start );
                         

  CLK_process : process
   begin
        clock <= '0';
        wait for CLK_period/2;
        clock <= '1';
        wait for CLK_period/2;
   end process;

  stimulus: process
  begin
    reset <= '1';
    wait for 20 ns;
    reset <= '0';
    wait for 50ns;
    START <= '1';
    wait for 50ns;
    START <= '0';
    wait;
  

    wait;
  end process;


end;