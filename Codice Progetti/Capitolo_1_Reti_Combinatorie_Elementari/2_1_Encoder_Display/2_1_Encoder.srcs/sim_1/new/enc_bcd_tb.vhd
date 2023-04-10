library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity enc_bcd_tb is

end enc_bcd_tb;

architecture Behavioral of enc_bcd_tb is

component enc_bcd
    port(
        x: in std_logic_vector(0 to 9);
        y: out std_logic_vector(0 to 3)
        );
end component;

signal input: std_logic_vector(0 to 9);
signal output: std_logic_vector(0 to 3);

begin

    uut: enc_bcd
        Port map ( 
            x => input,
            y => output
        );

stim_proc: process

begin

    wait for 50 ns;
    input <= "0000100000";
    wait for 10 ns;
    assert output <= "0101"
    report "errore0"
    severity failure;

    wait;
end process;

end Behavioral;
