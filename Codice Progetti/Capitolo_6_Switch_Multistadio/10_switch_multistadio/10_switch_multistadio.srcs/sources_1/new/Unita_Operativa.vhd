library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Unita_Operativa is
    port(
        x0   : in  std_logic_vector(0 to 1); -- il dato è su due bit
        x1   : in  std_logic_vector(0 to 1);
        x2   : in  std_logic_vector(0 to 1);
        x3   : in  std_logic_vector(0 to 1);
        src  : in  std_logic_vector(0 to 1); -- ho 4 ingressi, dunque è su due bit
        dest : in  std_logic_vector(0 to 1); -- ho 4 uscite, dunque è su due bit
        y0   : out std_logic_vector(0 to 1);
        y1   : out std_logic_vector(0 to 1);
        y2   : out std_logic_vector(0 to 1);
        y3   : out std_logic_vector(0 to 1)
    );
end Unita_Operativa;

architecture Structural of Unita_Operativa is

component switch is
    port(
        X0    : in  std_logic_vector(0 to 1);
        X1    : in  std_logic_vector(0 to 1);
        src   : in  std_logic;
        dest  : in  std_logic;
        Y0    : out std_logic_vector(0 to 1);
        Y1    : out std_logic_vector(0 to 1)
    );
end component switch;

--uscite degli switch del primo stadio
signal temp0 : std_logic_vector(0 to 1) := "00";
signal temp1 : std_logic_vector(0 to 1) := "00";
signal temp2 : std_logic_vector(0 to 1) := "00";
signal temp3 : std_logic_vector(0 to 1) := "00";

begin

    s0 : switch
    port map(
        X0   => x0,
        X1   => x1,
        src  => src(1),
        dest => dest(0),
        Y0   => temp0,
        Y1   => temp1
    );
    
    s1 : switch
    port map(
        X0   => x2,
        X1   => x3,
        src  => src(1),
        dest => dest(0),
        Y0   => temp2,
        Y1   => temp3 
    );
    
    s2 : switch
    port map(
        X0   => temp0,
        X1   => temp2,
        src  => src(0),
        dest => dest(1),
        Y0   => y0,
        Y1   => y1 
    );
    
    s3 : switch
    port map(
        X0   => temp1,
        X1   => temp3,
        src  => src(0),
        dest => dest(1),       
        Y0   => y2,
        Y1   => y3 
    );
 
end Structural;
