library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_register_tb is
end shift_register_tb;

architecture Behavioral of shift_register_tb is

component shift_register is
    port(
        clk : in std_logic;
        shift : in std_logic;
        reset : in std_logic;
        load : in std_logic;
        
        serial_in : in std_logic;
        parallel_in : in std_logic_vector(7 downto 0);
        
        serial_out : out std_logic;
        parallel_out : out std_logic_vector(7 downto 0)
    );
end component;

signal clk : std_logic;
signal shift : std_logic;
signal reset : std_logic;
signal load : std_logic;
        
signal serial_in : std_logic;
signal parallel_in : std_logic_vector(7 downto 0);
        
signal serial_out :  std_logic;
signal parallel_out : std_logic_vector(7 downto 0);

begin
    clk_prc : process begin
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end process;
    
    uut : shift_register port map(
        clk => clk, shift => shift, reset => reset, load => load, serial_in => serial_in, parallel_in => parallel_in, 
        serial_out=>serial_out, parallel_out => parallel_out
    );
    
    in_prc : process begin
        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        serial_in <= '1';
        shift<='1';
        wait for 60 ns;
        shift <= '0';
        parallel_in <= x"0a";
        load <= '1';
        wait;
    end process;

end Behavioral;
