library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SysA is
    Port(
        clock       :   in  std_logic;
        reset       :   in  std_logic;
        data_p_in   :   in  std_logic_vector(7 downto 0);
        en_wr       :   in  std_logic;
        data_s_out  :   out std_logic
    );
end SysA;

architecture Structural of SysA is

signal rxd_tmp : std_logic;
signal dbout_tmp : std_logic_vector(7 downto 0) := (others => '0');
signal rd_tmp : std_logic;
signal rda_tmp : std_logic;
signal tbe_tmp : std_logic;
signal pe_tmp : std_logic;
signal fe_tmp : std_logic;
signal oe_tmp : std_logic;

component UARTcomponent is
    Generic (
		--@48MHz
--		BAUD_DIVIDE_G : integer := 26; 	--115200 baud
--		BAUD_RATE_G   : integer := 417

		--@26.6MHz
		BAUD_DIVIDE_G : integer := 14; 	--115200 baud
		BAUD_RATE_G   : integer := 231
	);
	Port (	
		TXD 	: out 	std_logic  	:= '1';					-- Transmitted serial data output
		RXD 	: in  	std_logic;							-- Received serial data input
		CLK 	: in  	std_logic;							-- Clock signal
		DBIN 	: in  	std_logic_vector (7 downto 0);		-- Input parallel data to be transmitted
		DBOUT 	: out 	std_logic_vector (7 downto 0);		-- Recevived parallel data output
		RDA		: inout  std_logic;							-- Read Data Available
		TBE		: out 	std_logic 	:= '1';					-- Transfer Buffer Emty
		RD		: in  	std_logic;							-- Read Strobe
		WR		: in  	std_logic;							-- Write Strobe
		PE		: out 	std_logic;							-- Parity error		
		FE		: out 	std_logic;							-- Frame error
		OE		: out 	std_logic;							-- Overwrite error
		RST		: in  	std_logic	:= '0');				-- Reset signal
 end component;

begin

uart : UARTcomponent
    Generic map(
        BAUD_DIVIDE_G => 14,	--115200 baud
		BAUD_RATE_G => 231    
    )
    Port map(
        TXD => data_s_out,
        RXD => rxd_tmp,
        CLK => clock,
        DBIN => data_p_in,
        DBOUT => dbout_tmp,
        RDA => rda_tmp,
        TBE => tbe_tmp,
        RD => rd_tmp,
        WR => en_wr,
        PE => pe_tmp,
        FE => fe_tmp,
        OE => oe_tmp,
        RST => reset
    );


end Structural;
