library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity contatore is
Generic(
    bits : integer := 100; -- n bits per rappresentare il risultato 
    modulo : integer := 60 -- modulo del contatore
);

Port(
    clk : in std_logic;
    rst : in std_logic;
    en : in std_logic;
    set_en : in std_logic;
    set : in std_logic_vector(0 to bits-1); -- 2^6 
    uscita : out std_logic;
    numero : out std_logic_vector(0 to bits-1)
    );
end contatore;

architecture Behavioral of contatore is

begin

    process(clk)
    variable count : integer := 0;

    begin
        if(rst = '1') then -- reset asincrono
            count := 0;
            numero <= std_logic_vector(to_unsigned(0, bits));
        elsif(set_en = '1') then
            count := to_integer(unsigned(set));
        elsif(falling_edge(clk)) then
            if(en = '1') then 
                uscita <= '0';
                if(count = modulo-2) then -- sottrae 1 per via del prossimo fronte di discesa del clock
                    uscita <= '1';
                end if;
                if(count = modulo-1) then -- azzera quando il conteggio arriva a 59
                    count := 0;
                else
                    count := count+1;
                end if;
            end if;
        end if;
        
        numero <= std_logic_vector(to_unsigned(count, bits));
    
    end process;

end Behavioral;
--


