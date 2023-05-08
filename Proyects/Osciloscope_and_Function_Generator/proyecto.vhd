library ieee;
use ieee.std_logic_1164.all;

entity proyecto is
	
	generic(
	
	n :	integer := 12 
	
	);
	
	port(
	
	RST,CLK 	: 	in std_logic;
	
	convst 	: 	out std_logic;
	sck 		: 	out std_logic;
	sdi		: 	out std_logic;
	sdo		: 	in std_logic;
	
	TXD		: out std_logic;
	RXD		: in std_logic;
	
	DRX	: out std_logic_Vector(7 downto 0);
	valido : out std_logic
	
	);	
	
end proyecto;

architecture fsm of proyecto is	


component adc_ip is
	port (
		CLOCK    : in  std_logic                     := '0'; --                clk.clk
		ADC_SCLK : out std_logic;                            -- external_interface.SCLK
		ADC_CS_N : out std_logic;                            --                   .CS_N
		ADC_DOUT : in  std_logic                     := '0'; --                   .DOUT
		ADC_DIN  : out std_logic;                            --                   .DIN
		CH0      : out std_logic_vector(11 downto 0);        --           readings.CH0
		CH1      : out std_logic_vector(11 downto 0);        --                   .CH1
		CH2      : out std_logic_vector(11 downto 0);        --                   .CH2
		CH3      : out std_logic_vector(11 downto 0);        --                   .CH3
		CH4      : out std_logic_vector(11 downto 0);        --                   .CH4
		CH5      : out std_logic_vector(11 downto 0);        --                   .CH5
		CH6      : out std_logic_vector(11 downto 0);        --                   .CH6
		CH7      : out std_logic_vector(11 downto 0);        --                   .CH7
		RESET    : in  std_logic                     := '0'  --              reset.reset
	);
	
end component;

component UART_2Bytes is
	
	generic(
	
	n :	integer := 12
	
	);
	
	port(
	
	RST,CLK : in std_logic;
	TXD	: out std_logic;
	RXD	: in std_logic;
	DRX	: out std_logic_Vector(7 downto 0);
	value0	: in std_logic_Vector(n-1 downto 0); 
	valido : out std_logic
	
	
	);	
	
end component;

signal valor : std_logic_vector(11 downto 0);


begin 

	sc0 : adc_ip port map(CLK,sck,convst,sdo,sdi,valor,open,open,open,open,open,open,open,not RST);
	
	sc1 : UART_2Bytes port map(RST,CLK,TXD,RXD,DRX,valor,valido);
	
end fsm;