library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity rete_16_4_tb is
end;

architecture bench of rete_16_4_tb is

  component rete_16_4
      port(
          a : in std_logic_vector(0 to 15);
          s : in std_logic_vector(5 downto 0); 
          y : out std_logic_vector(0 to 3)
      );
  end component;

  signal a: std_logic_vector(0 to 15);
  signal s: std_logic_vector(5 downto 0);
  signal y: std_logic_vector(0 to 3) ;

begin

  uut: rete_16_4 port map ( a => a,
                            s => s,
                            y => y );

  stimulus: process
  begin
  
    
    wait for 10 ns;
    a <= "0000000001000000";
    s <= "100100";
    wait for 10 ns;
    assert y <= "1000"
    report "errore0"
    severity failure;
    wait for 10 ns;
    a <= "0100010001001100";
    s <= "000110";
    wait for 10 ns;
    assert y <= "0100"
    report "errore0"
    severity failure;

    wait;
  
    
 
    wait;
  end process;


end;