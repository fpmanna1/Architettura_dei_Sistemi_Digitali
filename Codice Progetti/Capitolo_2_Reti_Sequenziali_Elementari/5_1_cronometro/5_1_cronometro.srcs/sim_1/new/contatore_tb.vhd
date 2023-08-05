library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity contatore_tb is
end;

architecture bench of contatore_tb is

  component contatore
  Port(
      clk : in std_logic;
      rst : in std_logic;
      en : in std_logic;
      set_en : in std_logic;
      set : in std_logic_vector(0 to 5);
      uscita : out std_logic
      );
  end component;

  signal clk: std_logic := '0';
  signal rst: std_logic := '0';
  signal en: std_logic := '0';
  signal set_en: std_logic := '0';
  signal set: std_logic_vector(0 to 5)  := "101010";
  signal uscita: std_logic := '0';

  constant CLK_period: time := 10ns;

begin

  uut: contatore port map ( clk    => clk,
                            rst    => rst,
                            en     => en,
                            set_en => set_en,
                            set    => set,
                            uscita => uscita );

   CLK_process :process
      
   begin
        CLK <= '0';
        wait for CLK_period/2;
        CLK <= '1';
        wait for CLK_period/2;
   end process;                          
   
   stim_proc: process
   begin        
      wait for 100 ns;
      wait for CLK_period*10;           
      
      rst <= '1';
      wait for 10ns;
      
      rst <= '0';
      wait for 10ns;
      
      set_en <= '1';
      
      wait for 10ns;
      
      set <= "000010";

      wait for 10ns;
      
      set_en <= '0';
      
      wait for 10ns;
      
      en <= '1';
     
      wait;
   end process;
 

end;

--