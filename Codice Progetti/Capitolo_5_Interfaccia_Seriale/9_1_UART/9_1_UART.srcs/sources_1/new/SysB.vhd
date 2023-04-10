library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SysB is
    Port(
        clock       :   in  std_logic;
        reset       :   in  std_logic;
        data_s_in   :   in  std_logic;
        en_rd       :   in  std_logic;
        data_p_out  :   out std_logic_vector(7 downto 0)
    );
end SysB;

architecture Structural of SysB is

signal txd_tmp : std_logic;
signal dbin_tmp : std_logic_vector(7 downto 0);
signal rda_tmp : std_logic;
signal tbe_tmp : std_logic;
signal wr_tmp : std_logic;
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
    Port map(
        TXD => txd_tmp,
        RXD => data_s_in,
        CLK => clock,
        DBIN => dbin_tmp,
        DBOUT => data_p_out,
        RDA => rda_tmp,
        TBE => tbe_tmp,
        RD => en_rd,
        WR => wr_tmp,
        PE => pe_tmp,
        FE => fe_tmp,
        OE => oe_tmp,
        RST => reset
    );

end Structural;
