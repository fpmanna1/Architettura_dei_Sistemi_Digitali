library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity mux_4_1_tb is
end;

architecture bench of mux_4_1_tb is

  component mux_4_1
      port(
          a : in std_logic_vector(0 to 3);
          s : in std_logic_vector(1 downto 0);
          y : out std_logic
      );
  end component;

  signal input_a: std_logic_vector(0 to 3);
  signal input_s: std_logic_vector(1 downto 0);
  signal output_y: std_logic ;

begin

  uut: mux_4_1 port map ( a => input_a,
                          s => input_s,
                          y => output_y );

  stimulus: process
  begin
        wait for 4ns;
        input_a <= "0101";
        input_s <= "01";
        wait for 10ns;
        assert output_y = '1'
        report "errore0"
        severity failure;
        input_a <= "0000";
        input_s <= "01";
        wait for 10ns;
        assert output_y = '0'
        report "errore1"
        severity failure;
        
  
    wait;
  end process;


end bench;