library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity demux_4_1_tb is
end;

architecture bench of demux_4_1_tb is

  component demux_4_1
      port(
          a : in std_logic; 
          s : in std_logic_vector(1 downto 0);
          u : out std_logic_vector(0 to 3)
      );
  end component;

  signal a: std_logic;
  signal s: std_logic_vector(1 downto 0);
  signal u: std_logic_vector(0 to 3) ;

begin

  uut: demux_4_1 port map ( a => a,
                            s => s,
                            u => u );

  stimulus: process
  begin
 
    wait for 100 ns;
 
    a <= '1';
    s <= "00";
    
    wait for 100 ns;
 
    s <= "10";
 
    wait for 100 ns;
 
    s <= "01";
 
    wait for 100 ns;
 
    s <= "11";
 
    wait for 100 ns;
 
    wait;
  end process;


end;