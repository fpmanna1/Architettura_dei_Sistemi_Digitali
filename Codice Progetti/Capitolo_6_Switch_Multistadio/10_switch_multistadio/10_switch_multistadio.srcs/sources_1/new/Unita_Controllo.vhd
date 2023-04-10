library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Unita_Controllo is
    Port(
        A0   : in  std_logic_vector(0 to 5);
        A1   : in  std_logic_vector(0 to 5);
        A2   : in  std_logic_vector(0 to 5);
        A3   : in  std_logic_vector(0 to 5);
        en0  : in  std_logic;
        en1  : in  std_logic;
        en2  : in  std_logic;
        en3  : in  std_logic;
        B0   : out std_logic_vector(0 to 1);
        B1   : out std_logic_vector(0 to 1);
        B2   : out std_logic_vector(0 to 1);
        B3   : out std_logic_vector(0 to 1);
        src  : out std_logic_vector(0 to 1);
        dest : out std_logic_vector(0 to 1)
        );
end Unita_Controllo;

architecture structural of Unita_Controllo is

    component mux_4_1 is
          port(
            x0 : in  std_logic_vector(0 to 1);
            x1 : in  std_logic_vector(0 to 1);
            x2 : in  std_logic_vector(0 to 1);
            x3 : in  std_logic_vector(0 to 1);
            s  : in  std_logic_vector(0 to 1);
            Y  : out std_logic_vector(0 to 1)
            );
    end component;
    
    component demux_1_4 is
        port (
            x  : in  std_logic_vector(0 to 1);
            s  : in  std_logic_vector(0 to 1);
            y0 : out std_logic_vector(0 to 1);
            y1 : out std_logic_vector(0 to 1);
            y2 : out std_logic_vector(0 to 1);
            y3 : out std_logic_vector(0 to 1)
    );
    end component;
    
    component arbitro is
         port(
            enable00 : in  std_logic;
            enable01 : in  std_logic;
            enable10 : in  std_logic;
            enable11 : in  std_logic;
            y        : out std_logic_vector(0 to 1) 
    );
    end component;
    
    signal t_sel: std_logic_vector(0 to 1);
    signal t_y: std_logic_vector(0 to 1);
begin
    mux: mux_4_1
    --DATO input
    port map(
        x0 => A0(4 to 5), 
        x1 => A1(4 to 5), 
        x2 => A2(4 to 5), 
        x3 => A3(4 to 5),
        s => t_sel, 
        Y => t_y
     );
    
    demux: demux_1_4
    --B DATO output
    port map(
        x => t_y, 
        s => t_sel, 
        y0 => B0,
        y1 => B1,
        y2 => B2,
        y3 => B3
     );
 
    arb: arbitro
    port map(
        enable00 => en0,
        enable01 => en1, 
        enable10 => en2, 
        enable11 => en3, 
        y        => t_sel
    );
    
    src  <= A0(0 to 1) when t_sel = "00" else
            A1(0 to 1) when t_sel = "01" else
            A2(0 to 1) when t_sel = "10" else
            A3(0 to 1) when t_sel = "11" else
            "--";
    --bit selezione Dest della rete Omega
    dest <= A0(2 to 3) when t_sel = "00" else
            A1(2 to 3) when t_sel = "01" else
            A2(2 to 3) when t_sel = "10" else
            A3(2 to 3) when t_sel = "11" else
            "--";
    
end structural;
