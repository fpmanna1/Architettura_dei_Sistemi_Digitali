library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SysB is
    Port(
        clock       :   in  std_logic;
        reset       :   in  std_logic;
        rxd_in      :   in  std_logic;
        data_p_out  :   out std_logic_vector(7 downto 0)
    );
end SysB;

architecture Structural of SysB is

signal counter_out      : std_logic_vector(0 to 2) := (others => '0');

signal en_wr_cu     : std_logic := '0';
signal en_rd_cu     : std_logic := '0';
signal en_count_cu  : std_logic := '0';
signal rd_from_cu   : std_logic := '0';

signal dbin_tmp         : std_logic_vector(7 downto 0) := (others => '0');
signal dbout_out_uart   : std_logic_vector(7 downto 0) := (others => '0');
signal rda_out_uart     : std_logic := '0';
signal tbe_tmp          : std_logic := '0';
signal wr_tmp           : std_logic := '0';
signal pe_tmp           : std_logic := '0';
signal fe_tmp           : std_logic := '0';
signal oe_tmp           : std_logic := '0';

component memory is
    Port(
        clock       :   in  std_logic;
        reset       :   in  std_logic;
        write       :   in  std_logic;
        read        :   in  std_logic;
        addr        :   in  std_logic_vector(0 to 2);
        value_in    :   in  std_logic_vector(7 downto 0);
        value_out   :   out std_logic_vector(7 downto 0)
    );
end component memory;

component Counter is
    Port(
        clock       :   in  std_logic;
        reset       :   in  std_logic;
        enable      :   in  std_logic;
        count_out   :   out std_logic_vector(0 to 2)
    );
end component Counter;

component Receiver is
    Port(
        clock       :   in  std_logic;
        reset       :   in  std_logic;
        en_wr       :   out std_logic;
        en_rd       :   out std_logic;
        en_count    :   out std_logic;
        rda         :   in  std_logic;
        rd          :   out std_logic
    );
end component Receiver;

component UARTcomponent is
    Generic(
    BAUD_DIVIDE_G : integer := 14;  --115200 baud
    BAUD_RATE_G   : integer := 231
  );
  Port (  
    TXD   : out   std_logic   := '1';     -- Transmitted serial data output
    RXD   : in    std_logic;              -- Received serial data input
    CLK   : in    std_logic;              -- Clock signal
    DBIN  : in    std_logic_vector (7 downto 0);    -- Input parallel data to be transmitted
    DBOUT : out   std_logic_vector (7 downto 0);    -- Recevived parallel data output
    RDA   : inout std_logic;              -- Read Data Available
    TBE   : out   std_logic   := '1';     -- Transfer Buffer Emty
    RD    : in    std_logic;              -- Read Strobe
    WR    : in    std_logic;              -- Write Strobe
    PE    : out   std_logic;              -- Parity error   
    FE    : out   std_logic;              -- Frame error
    OE    : out   std_logic;              -- Overwrite error
    RST   : in    std_logic := '0');      -- Reset signal
end component;

begin

mem : memory
    Port map(
        clock       => clock,
        reset       => reset,
        write       => en_wr_cu,
        read        => en_rd_cu,
        addr        => counter_out,
        value_in    => dbout_out_uart,
        value_out   => data_p_out
    );

addr_counter : Counter
    Port map(
        clock       => clock,
        reset       => reset,
        enable      => en_count_cu,
        count_out   => counter_out
    );
    
cu : Receiver
    Port map(
        clock       => CLOCK,
        reset       => RESET,
        en_wr       => en_wr_cu,
        en_rd       => en_rd_cu,
        en_count    => en_count_cu,
        rda         => rda_out_uart,
        rd          => rd_from_cu
    ); 

uart : UARTcomponent 
    Port map(
        RXD     => rxd_in,
        CLK     => clock,
        DBIN    => dbin_tmp,
        DBOUT   => dbout_out_uart,
        RDA     => rda_out_uart,
        TBE     => tbe_tmp,
        RD      => rd_from_cu,
        WR      => wr_tmp,
        PE      => pe_tmp,
        FE      => fe_tmp,
        OE      => oe_tmp
    );

end Structural;
