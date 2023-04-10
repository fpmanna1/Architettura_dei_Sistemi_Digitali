library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ripple_carry_adder_tb is
end ripple_carry_adder_tb;

architecture Behavioral of ripple_carry_adder_tb is

component ripple_carry_adder is
    port(
        a : in std_logic_vector(7 downto 0);
        b : in std_logic_vector(7 downto 0);

        sub : in std_logic;
        
        res : out std_logic_vector(7 downto 0);
        cout : out std_logic
    );
end component;

signal a : std_logic_vector(7 downto 0);
signal b : std_logic_vector(7 downto 0);
signal sub : std_logic;
signal res : std_logic_vector(7 downto 0);
signal cout : std_logic;

begin
    uut : ripple_carry_adder port map(
        a=>a, b=>b , sub=>sub, res=>res, cout=>cout
    );

    process begin
        a <= x"07";
        b <= x"03";
        sub <= '0';
        wait for 10 ns;
        a<=x"6F";
        b<=x"11";
        wait for 10 ns;
        sub <= '1';
        wait;
    end process;

end Behavioral;
