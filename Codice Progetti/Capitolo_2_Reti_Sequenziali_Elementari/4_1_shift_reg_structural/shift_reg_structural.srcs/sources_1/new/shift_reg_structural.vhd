library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_reg_structural is
port(
        clock : in std_logic;
        rst : in std_logic;
        dir : in std_logic; --destra o sinistra
        mode : in std_logic; --shift di un bit o due bit
        ing : in std_logic;
        y : out std_logic_vector(0 to 3);
        en : in std_logic
        );
end shift_reg_structural;

architecture Structural of shift_reg_structural is

signal output_mux : std_logic_vector(0 to 3); --segnale interno che rappresenta le uscite dei mux
signal output_ff : std_logic_vector(0 to 3); --stato dei 4 flip flop

component mux_4_1 is
port(
    input_a : in std_logic_vector(0 to 3); 
    input_s : in std_logic_vector(1 downto 0); 
    output_y : out std_logic 
);
end component;

component flip_flop_d is
port(
    clk : in std_logic;
    en : in std_logic;
    input : in std_logic;
    output : out std_logic;
    rst : in std_logic
);
end component;

begin

y(0 to 3) <= output_ff(0 to 3);

mux_0 : mux_4_1
port map(
    input_a(0) => ing,
    input_a(1) => '0', --unspecified
    input_a(2) => output_ff(1),
    input_a(3) => output_ff(2),
    input_s(0) => dir,
    input_s(1) => mode,
    output_y   => output_mux(0)
);

mux_1 : mux_4_1
port map(
    input_a(0) => output_ff(0),
    input_a(1) => ing,
    input_a(2) => output_ff(1),
    input_a(3) => output_ff(3),
    input_s(0) => dir,
    input_s(1) => mode,
    output_y   => output_mux(1)
);

mux_2 : mux_4_1
port map(
    input_a(0) => output_ff(1),
    input_a(1) => output_ff(0),
    input_a(2) => output_ff(3),
    input_a(3) => ing,
    input_s(0) => dir,
    input_s(1) => mode,
    output_y   => output_mux(2)
);

mux_3 : mux_4_1
port map(
    input_a(0) => output_ff(2),
    input_a(1) => output_ff(1),
    input_a(2) => ing,
    input_a(3) => '0', --unspecified
    input_s(0) => dir,
    input_s(1) => mode,
    output_y   => output_mux(3)
);
 
ff_0 : flip_flop_d
port map(
    clk => clock,
    en => en,
    input => output_mux(0),
    output => output_ff(0),
    rst => rst
);

ff_1 : flip_flop_d
port map(
    clk => clock,
    en => en,
    input => output_mux(1),
    output => output_ff(1),
    rst => rst
);

ff_2 : flip_flop_d
port map(
    clk => clock,
    en => en,
    input => output_mux(2),
    output => output_ff(2),
    rst => rst
);

ff_3 : flip_flop_d
port map(
    clk => clock,
    en => en,
    input => output_mux(3),
    output => output_ff(3),
    rst => rst
);

end Structural;
