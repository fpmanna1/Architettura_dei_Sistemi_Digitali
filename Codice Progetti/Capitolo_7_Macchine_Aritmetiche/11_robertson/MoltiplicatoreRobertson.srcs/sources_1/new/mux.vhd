library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity mux is
    port(
        a : in std_logic_vector(7 downto 0);
        b : in std_logic_vector(7 downto 0);
        s : in std_logic;
        out_d : out std_logic_vector(7 downto 0) 
    );
end mux;

architecture Dataflow of mux is
begin

with s select
    out_d <= a when '0',
             b when '1',
             (others => '0') when others;

end Dataflow;
