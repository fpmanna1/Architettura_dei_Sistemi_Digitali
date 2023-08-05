library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity cronometro_tb is
end;

architecture bench of cronometro_tb is

  component cronometro
    Port(
      CLK     :   in std_logic;
      RST     :   in std_logic;
      EN      :   in std_logic;
      set_EN  :   in std_logic;
      set_h   :   in std_logic_vector(0 to 4);
      set_m   :   in std_logic_vector(0 to 5);
      set_s   :   in std_logic_vector(0 to 5);
      h       :   out std_logic_vector(0 to 4);
      m       :   out std_logic_vector(0 to 5);
      s       :   out std_logic_vector(0 to 5)
    );
  end component;

  signal CLK: std_logic;
  signal RST: std_logic;
  signal EN: std_logic;
  signal set_EN: std_logic;
  signal set_h: std_logic_vector(0 to 4);
  signal set_m: std_logic_vector(0 to 5);
  signal set_s: std_logic_vector(0 to 5);
  signal h: std_logic_vector(0 to 4);
  signal m: std_logic_vector(0 to 5);
  signal s: std_logic_vector(0 to 5) ;
  constant CLK_period : time := 0.1ns;
begin

  uut: cronometro port map ( CLK    => CLK,
                             RST    => RST,
                             EN     => EN,
                             set_EN => set_EN,
                             set_h  => set_h,
                             set_m  => set_m,
                             set_s  => set_s,
                             h      => h,
                             m      => m,
                             s      => s );

    clk_process : process
    begin
        CLK <= '0';
        wait for CLK_period/2;
        CLK <= '1';
        wait for CLK_period/2;    
    end process;

  stimulus: process
  begin
        
        wait for 10ns;
        RST <= '1';
        
        wait for 10ns;
        RST <= '0';
        
        
        wait for 10ns;
        set_EN <= '1';
        
        wait for 10ns;
        set_s <= "111010";
        set_m <= "111010";
        set_h <= "00010";
        
        wait for 10ns;
        set_EN <= '0';
        
        wait for 10ns;
        EN <= '1'; 

        wait;
  end process;


end;

--