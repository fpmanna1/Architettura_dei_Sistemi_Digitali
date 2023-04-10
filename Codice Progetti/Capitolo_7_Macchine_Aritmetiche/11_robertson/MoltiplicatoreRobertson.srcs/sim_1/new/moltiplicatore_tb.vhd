library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity moltiplicatore_tb is
end moltiplicatore_tb;

architecture Behavioral of moltiplicatore_tb is

component moltiplicatore_robertson is
    port(
        X : in std_logic_vector(7 downto 0);
        Y : in std_logic_vector(7 downto 0);
        rst : in std_logic;
        start : in std_logic;
        clk : in std_logic;
        RES : out std_logic_vector(15 downto 0)
    );
end component;

signal X : std_logic_vector(7 downto 0);
signal Y : std_logic_vector(7 downto 0);
signal rst : std_logic;
signal start : std_logic;
signal clk : std_logic;
signal RES : std_logic_vector(15 downto 0);

begin

    uut : moltiplicatore_robertson 
    port map(
        X => X, 
        Y => Y, 
        rst => rst, 
        start => start, 
        clk => clk, 
        Res => res
    );
    clk_prc : process begin
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end process;
    
    in_prc : process begin
        rst <= '0';
--        X <= "01101100"; -- 108
--        Y <= "01110110"; -- 118
        start <= '1';
--        wait for 20 ns;
--        start <= '0';
--        wait for 300 ns;
--        start <= '1';
        X <= "01101100";  -- 108
        Y <= "11110110";  -- -10
        wait for 300 ns;
        start <= '0';
--        X <= "11110110"; -- -10
--        Y <= "11110110"; -- -10
--        start <= '1';
--        wait for 20 ns;
--        start <= '0';
--        wait for 300 ns;
--        X <= "11110110"; -- -10
--        Y <= "01110110"; -- 118
--        start <= '1';
--        wait for 20 ns;
--        start <= '0';
   
        wait;
    end process;
    
end Behavioral;
