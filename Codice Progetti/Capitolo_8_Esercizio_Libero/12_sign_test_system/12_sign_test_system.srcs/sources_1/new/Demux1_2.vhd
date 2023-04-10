library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Demux1_2 is
  Port (
        X: in std_logic;
        SEL: in std_logic;
        Y: out std_logic_vector(1 downto 0)
        );
end Demux1_2; 

architecture bhv of Demux1_2 is

begin
process(X, SEL)
begin
    if(SEL = '0') then
        Y(0) <= X;
        Y(1) <= '0';
    elsif(SEL = '1') then
        Y(0) <= '0';
        Y(1) <= X;
    end if;
end process;

end bhv;