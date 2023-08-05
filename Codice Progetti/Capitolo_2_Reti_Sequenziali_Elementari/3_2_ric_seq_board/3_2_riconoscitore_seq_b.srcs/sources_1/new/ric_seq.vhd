library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ric_seq is
	port( i: in std_logic;
	      M: in std_logic;
		  RST : in std_logic; -- Reset segnale di modo
		  CLK : in std_logic;
		  enable : in std_logic; -- abilitazione bottone ingresso
		  y: out std_logic
	);
end ric_seq;

architecture Behavioral of ric_seq is

    type stato is (QM, Q0, Q1A, Q1B, Q2A, Q2B, Q3A, Q3B, Q4, Q5, Q6, Q7);
    
    signal stato_corrente : stato := QM;
    signal last_enable : std_logic := '0';
  
begin
    stato_uscita : process(clk)
    begin   
        if rising_edge (CLK) then
            if RST = '1' then
                stato_corrente <= QM;
                y <= '0';
                if M = '0'then
                    stato_corrente <= Q0;
                else
                    stato_corrente <= Q4;
                end if;
            end if; --end if reset 
        
        if(enable = '1' and last_enable = '0') then -- all'inizio enable è zero poichè il tasto non è ancora premuto... abbiamo rimosso last enable poiche essendo il bottone impulsivo non c'è bisogno
        if(M = '0') then --riconoscitore sequenze ogni 4 bit
            case stato_corrente is
               when Q0 =>
                    if(i = '0') then 
                        stato_corrente <= Q1A;
                        y <= '0';
                    else
                        stato_corrente <= Q1B;
                        y <= '0';
                    end if;
                when Q1A =>
                    if(i = '0' or i = '1') then 
                        stato_corrente <= Q2A;
                        y <= '0';
                    end if;
                when Q2A =>
                     if(i = '0' or i = '1') then 
                        stato_corrente <= Q3A;
                        y <= '0';
                    end if;
                when Q3A =>
                    if(i = '0' or i = '1') then 
                        stato_corrente <= Q0;
                        y <= '0';
                    end if;
                when Q1B =>
                    if(i = '1') then
                        stato_corrente <= Q2A;
                        y <= '0';
                    else
                        stato_corrente <= Q2B;
                        y <= '0';
                    end if;
                when Q2B =>
                    if(i = '0') then
                        stato_corrente <= Q3B;
                        y <= '0';
                    else
                        stato_corrente <= Q3A;
                        y <= '0';
                    end if;
                 when Q3B =>
                    if(i = '0') then
                        stato_corrente <= Q0;
                        y <= '0';
                    else
                        stato_corrente <= Q0;
                        y <= '1';
                    end if;
                  when others =>
                    stato_corrente <= Q0;
                    y <= '0';
            end case;
         elsif(M = '1') then --riconoscitore sequenza ogni bit
            case stato_corrente is
                when Q4 =>
                    if(i = '0') then
                        stato_corrente <= Q4;
                        y <= '0';
                    else
                        stato_corrente <= Q5;
                        y <= '0';
                    end if;
                when Q5 =>
                    if(i = '0') then
                        stato_corrente <= Q6;
                        y <= '0';
                    else
                        stato_corrente <= Q5;
                        y <= '0';
                    end if;
                 when Q6 =>
                    if(i = '0') then
                        stato_corrente <= Q7;
                        y <= '0';
                    else
                        stato_corrente <= Q5;
                        y <= '0';
                    end if;
                 when Q7 =>
                    if(i = '0') then
                        stato_corrente <= Q4;
                        y <= '0';
                    else
                        stato_corrente <= Q4;
                        y <= '1';
                    end if;
                  when others =>
                        stato_corrente <= Q4;
                        y <= '0';
              end case; 
          end if;   -- end if e alse if per il valore M
        end if;     -- end if enable
        last_enable <= '0';
        end if;      -- end if clock             
    end process;
  
end Behavioral;
