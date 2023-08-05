library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity flip_flop_d_tb is
end;

architecture bench of flip_flop_d_tb is

  component flip_flop_d
  port(
      clk : in std_logic;
      en : in std_logic;
      input : in std_logic;
      output : out std_logic;
      rst : in std_logic
      );
  end component;

  signal clk: std_logic :='0';
  signal en: std_logic :='0';
  signal input: std_logic :='0';
  signal output: std_logic := '0';
  signal rst: std_logic := '1';

constant CLK_period : time := 10 ns;

begin

  uut: flip_flop_d port map ( clk    => clk,
                              en     => en,
                              input  => input,
                              output => output,
                              rst    => rst );
                              
  CLK_process : process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;                            

  stimulus: process
  begin
  
  wait for 100 ns;	

 wait for CLK_period*10;
 
    en <= '0';
    
    wait for 10 ns;
    
    rst <= '0';
  
    wait for 10 ns;
		input <= '1';
        
        wait for 10 ns;
        en <= '1';
        wait for 10 ns;
        en <= '0';
        
        wait for 10 ns;
		input <= '0';
        wait for 10 ns;
        en <= '1';
        wait for 10 ns;
        en <= '0';
  
    wait;
  end process;

end;