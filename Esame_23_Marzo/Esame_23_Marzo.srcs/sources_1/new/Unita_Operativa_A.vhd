--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;


--entity Unita_Operativa_A is
--    port(
--        clock : in std_logic;
--        reset : in std_logic;
--        value_in : std_logic_vector(0 to 7); -- stringa in ingresso allo shift register
--        load_sr_x : in std_logic;
--        load_sr_y : in std_logic;
--        en_compare : in std_logic
--        --x : in std_logic_vector(0 to 7);
--        --y : in std_logic_vector(0 to 7)
--    );
--end Unita_Operativa_A;

--architecture Structural of Unita_Operativa_A is

--signal shift_temp : std_logic := '0';
--signal out_x : std_logic := '0';
--signal out_y : std_logic := '0';

--begin

--sr_x : entity work.shift_reg
--    port map(
--        clock => clock,
--        reset => reset,
--        load => load_sr_x,
--        shift => shift_temp,
--        p_in => value_in,
--        s_out => out_x
--    );
    
--sr_y : entity work.shift_reg
--    port map(
--        clock => clock,
--        reset => reset,
--        load => load_sr_y,
--        shift => shift_temp,
--        p_in => value_in,
--        s_out => out_y
--    );
    
----cont_bit_omol : entity work.counter
----    generic map(
----        M => 8
----    )
----    port map(
    
    
----    )


--end Structural;
