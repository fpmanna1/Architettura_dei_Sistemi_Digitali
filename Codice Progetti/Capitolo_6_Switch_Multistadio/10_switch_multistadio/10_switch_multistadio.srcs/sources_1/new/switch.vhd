library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity switch is
    port(
        X0    : in  std_logic_vector(0 to 1);
        X1    : in  std_logic_vector(0 to 1);
        src   : in  std_logic;
        dest  : in  std_logic;
        Y0    : out std_logic_vector(0 to 1);
        Y1    : out std_logic_vector(0 to 1)
    );
end switch;

architecture Structural of switch is

component mux_2_1 is
    port(
        x0 : in  std_logic_vector(0 to 1);
        x1 : in std_logic_vector(0 to 1);
        s : in  std_logic;
        y : out std_logic_vector(0 to 1)
    );
end component mux_2_1;

component demux_1_2 is
    port(
        x : in  std_logic_vector(0 to 1);
        s : in  std_logic;
        y0 : out std_logic_vector(0 to 1);
        y1 : out std_logic_vector(0 to 1)
    );
end component demux_1_2;

signal temp : std_logic_vector(0 to 1) := "00";

begin

    mux : mux_2_1
    port map(
        x0 => X0,
        x1 => X1,
        s  => src,
        y  => temp
    );
    
    demux : demux_1_2
    port map(
        x  => temp,
        s  => dest,
        y0 => Y0,
        y1 => Y1
    );
    
end Structural;
