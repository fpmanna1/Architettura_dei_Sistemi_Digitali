----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.12.2021 18:29:21
-- Design Name: 
-- Module Name: OmegaNetwork - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity system is
 Port(
       s0 : in std_logic_vector(0 to 5);
       s1 : in std_logic_vector(0 to 5);
       s2 : in std_logic_vector(0 to 5);
       s3 : in std_logic_vector(0 to 5);
       e  : in std_logic_vector(0 to 3);
       y0 : out std_logic_vector(0 to 1);
       y1 : out std_logic_vector(0 to 1);
       y2 : out std_logic_vector(0 to 1);
       y3 : out std_logic_vector(0 to 1)
       );

end system;

architecture structural of system is

component Unita_Controllo is
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
    end component;
    
    
component Unita_Operativa is
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
end component;

signal X0, X1, X2, X3: std_logic_vector(0 to 1);
signal src, dst: std_Logic_vector(0 to 1);
begin
control_unit: Unita_Controllo
port map(S0,S1,S2,S3, E(0), E(1), E(2), E(3),X0,X1,X2,X3,src,dst);

op_unit: Unita_Operativa
port map(X0,X1,X2,X3, src, dst, Y0,Y1,Y2,Y3);

end structural;
