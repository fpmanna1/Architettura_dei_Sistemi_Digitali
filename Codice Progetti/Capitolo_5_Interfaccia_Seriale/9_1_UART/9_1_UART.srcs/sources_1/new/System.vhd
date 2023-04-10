library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity System is
    Port(
        CLK : in std_logic;
        RST : in std_logic;
        EN_WR : in std_logic;
        EN_RD : in std_logic;
        DATA_IN : in std_logic_vector(7 downto 0);
        DATA_OUT : out std_logic_vector(7 downto 0)
    );
end System;

architecture Structural of System is

signal data_s_out_a : std_logic;
signal RST_N : std_logic;
signal EN_RD_N : std_logic;

component SysA is 
    Port(
        clock       :   in  std_logic;
        reset       :   in  std_logic;
        data_p_in   :   in  std_logic_vector(7 downto 0);
        en_wr       :   in  std_logic;
        data_s_out  :   out std_logic
    );
end component;

component SysB is
    Port(
        clock : in std_logic;
        reset : in std_logic;
        data_s_in : in std_logic;
        en_rd : in std_logic;
        data_p_out : out std_logic_vector(7 downto 0)
    );
end component;

begin 

RST_N <= not RST;
EN_RD_N <= not EN_RD;


nodeA : SysA
    Port map(
        clock => CLK,
        reset => RST_N,
        data_p_in => DATA_IN,
        en_wr => EN_WR,
        data_s_out => data_s_out_a
    );

nodeB : SysB
    Port map(
        clock => CLK,
        reset => RST_N,
        data_s_in => data_s_out_a,
        en_rd => EN_RD_N,
        data_p_out => DATA_OUT
    );

end Structural;
