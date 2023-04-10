library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SysA is
    Port(
        clock       :   in  std_logic;
        reset       :   in  std_logic;
        startA      :   in  std_logic;
        btn_load    :   in  std_logic;
        txd_out     :   out std_logic -- serial data out
        --data_p_out  :   out std_logic_vector(7 downto 0)
    );
end SysA;

architecture Structural of SysA is

component ROM is
    port(
        clock       :   in  std_logic;
        reset       :   in  std_logic;
        read        :   in  std_logic;
        addr        :   in  std_logic_vector(0 to 2); --la memoria è composta da 8 locazioni
        value_out   :   out std_logic_vector(0 to 7)
    );
end component ROM;

component Counter is
    Port(
        clock       :   in  std_logic;
        reset       :   in  std_logic;
        enable      :   in  std_logic;
        count_out   :   out std_logic_vector(0 to 2)
    );
end component Counter;

component Transmitter is
    Port(
        clock       :   in  std_logic;
        reset       :   in  std_logic;
        start       :   in  std_logic;
        count       :   in  std_logic_vector(0 to 2);
        load        :   in  std_logic;
        en_rom      :   out std_logic;
        en_count    :   out std_logic;
        wr          :   out std_logic; -- uart signal in order to star trasmission
        led_out     :   out std_logic
    );
end component Transmitter;

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

signal counter_out      : std_logic_vector(0 to 2);
signal rom_value_out    : std_logic_vector(0 to 7); -- Parrallel data A (read from ROM)

-- signal from control unit
signal en_rom_cu    : std_logic := '0';
signal en_count_cu  : std_logic := '0';
signal wr_cu        : std_logic := '0';

-- uart signal
signal rxd_tmp      : std_logic := '0';
signal dbout_tmp    : std_logic_vector(7 downto 0) := (others => '0');
signal rda_tmp      : std_logic := '0';
signal tbe_tmp      : std_logic := '0';
signal rd_tmp       : std_logic := '0';
signal pe_tmp       : std_logic := '0';
signal fe_tmp       : std_logic := '0';
signal oe_tmp       : std_logic := '0';

begin

addr_counter : Counter
    Port map(
        clock       => clock,
        reset       => reset,
        enable      => en_count_cu,
        count_out   => counter_out
    );

romMem : ROM
    Port map(
        clock       => clock,
        reset       => reset,
        read        => en_rom_cu,
        addr        => counter_out,
        value_out   => rom_value_out
    );
    
cu_a : Transmitter
    Port map(
        clock       => clock,
        reset       => reset,
        start       => startA,
        count       => counter_out,
        load        => btn_load,
        en_rom      => en_rom_cu,
        en_count    => en_count_cu,
        wr          => wr_cu
    );
    
uart : UARTcomponent 
    Port map(
        TXD     => txd_out,
        RXD     => rxd_tmp,
        CLK     => clock,
        DBIN    => rom_value_out,
        DBOUT   => dbout_tmp,
        RDA     => rda_tmp,
        TBE     => tbe_tmp,
        RD      => rd_tmp,
        WR      => wr_cu,
        PE      => pe_tmp,
        FE      => fe_tmp,
        OE      => oe_tmp
    );


end Structural;

