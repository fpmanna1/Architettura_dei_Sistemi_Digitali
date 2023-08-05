library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity ric_seq_tb is
end;

architecture bench of ric_seq_tb is

  component ric_seq
  	port( i: in std_logic;
  	      M: in std_logic;
  		  RST, CLK: in std_logic;
  		  Y: out std_logic
  	);
  end component;

  signal i: std_logic := '0';
  signal M: std_logic := '0';
  signal RST: std_logic := '0';
  signal CLK: std_logic := '0';
  signal Y: std_logic;

  constant CLK_period : time := 10 ns;
  
begin

  uut: ric_seq port map ( i   => i,
                          M   => M,
                          RST => RST,
                          CLK => CLK,
                          Y   => Y );
                          
                          
     CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;                      

   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;
      
      wait for CLK_period*10;	

      
      -- insert stimulus here 
		i <= '1';
		wait for 10 ns;
		i <= '0';
		wait for 10 ns;
		i <= '1';
		wait for 10 ns;
		i <= '0';
		wait for 10 ns;
		i <= '1';
		wait for 10 ns;
		i <= '0';
		wait for 10 ns;
		i <= '0';
		wait for 10 ns;
		i <= '1';
		
		
      wait;
   end process;

end;