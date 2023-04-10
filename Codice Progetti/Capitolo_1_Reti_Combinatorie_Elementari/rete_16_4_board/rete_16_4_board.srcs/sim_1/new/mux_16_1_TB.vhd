library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity mux_16_1_TB is

end mux_16_1_TB;

architecture bench of mux_16_1_TB is

    component mux_16_1 is
        Port (
            a: in std_logic_vector(0 to 15);
            s: in std_logic_vector(3 downto 0);
            y: out std_logic
    );
    end component;

    signal input_x: STD_LOGIC_VECTOR(0 to 15);
    signal input_s: STD_LOGIC_VECTOR(3 downto 0);
    signal output_y: STD_LOGIC;

    begin
        mux: mux_16_1
        port map (
            a => input_x,
            s => input_s,
            y => output_y
    );

    stim_proc: process

    begin

    --selezione linea
    wait for 10 ns;
    input_x <= "1001000001011011";
    input_s <= "0011";
    wait for 10 ns;
    assert output_y = '1'
    report "errore0"
    severity failure;
    wait for 10 ns;
    input_x <= "1001000001011011";
    input_s <= "1110";
    wait for 10 ns;
    assert output_y = '1'
    report "errore0"
    severity failure;
    wait for 10 ns;
    input_x <= "0010100010010100";
    input_s <= "0000";
    wait for 10 ns;
    assert output_y = '0'
    report "errore0"
    severity failure;
    wait;

end process;

end bench;
