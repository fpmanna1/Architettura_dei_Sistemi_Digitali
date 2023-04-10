library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity mux_16_1 is
    Port (
        a: in std_logic_vector(0 to 15); 
        s: in std_logic_vector(3 downto 0); 
        y: out std_logic 
    );
end mux_16_1;



architecture Structural of mux_16_1 is


signal u: std_logic_vector(0 to 3);

component mux_4_1
    port(
        input_a: in std_logic_vector(0 to 3); --inputx
        input_s: in std_logic_vector(1 downto 0); --inputs
        output_y: out std_logic --output_y
    );
end component;



begin
    mux_0_3: for i in 0 to 3 generate m: mux_4_1
        port map(
            input_a(0 to 3) => a(i*4 to i*4+3),
            input_s(1 downto 0) => s(1 downto 0),
            output_y => u(i)
    );
    end generate;

    mux_4: mux_4_1
        port map(
            input_a(0 to 3) => u(0 to 3),
            input_s(1 downto 0) => s(3 downto 2),
            output_y => y
        );
end Structural;