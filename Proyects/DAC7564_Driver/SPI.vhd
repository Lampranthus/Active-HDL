library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity SPI is
	
	generic(
	
	n :	integer := 8 
	
	);
	
	port(
	
	RST,CLK : 	in std_logic;
	
	
	DTX		: 	in std_logic_vector(n-1 downto 0);
	DRX		: 	out std_logic_Vector(n-1 downto 0);
	
	
	start 	: 	in std_logic;
	fin 	: 	out std_logic;
	valido 	: 	out std_logic;
	CPOL 	: 	in std_logic;
	CPHA 	: 	in std_logic;
	
	
	CS 		: 	out std_logic;
	SCLK 	: 	out std_logic;
	MOSI	: 	out std_logic;
	MISO	: 	in std_logic
	
	);	
	
end SPI;

architecture fsm of SPI is	


component mux_10a1_1 is
	port(
		D		:	in	std_logic_vector(7 downto 0);
		S		: 	in 	std_logic_vector(3 downto 0);
		Y		: 	out std_logic
	);
end component;
	
component contador_bt_k is
	
	generic(
	
	n :	integer := 8

	);
	
	port(
	
	RST,CLK : in std_logic;
	
	k : in std_logic_vector(n-1 downto 0);
	
	CLR : in std_logic;
	
	BT : out std_logic
	
	);
end component;
	
component SHR is 
	
	generic( 
	
	N : integer := 8
	
	);
	
	port(
	
	RST,CLK, R: in std_logic;
	OPR : in std_logic_vector(1 downto 0);
	Q : out std_logic_vector(N-1 downto 0)
	
	);
end component;


component mux_4a1_1 is
	port(
		BITSCLK	:	in	std_logic;
		S		: 	in 	std_logic_vector(1 downto 0);
		SCLK		: 	out std_logic
	);
end component;

component fsm_SCLK is
	port(
	
	RST,CLK : in std_logic;	
	
	bt	: in std_logic;
	
	bitsclk : out std_logic
	
	);
	
end component;

component fsm_SPI is
	
	generic(
	
	c : std_logic_vector := "00000001" ---10MHz
	
	);

	port(
	
	RST,CLK : in std_logic;	
	
	start 	: 	in std_logic;
	fin 	: 	out std_logic; -- out 1
	valido 	: 	out std_logic; -- out 2
	CPOL 	: 	in std_logic;
	CPHA 	: 	in std_logic;
	
	CS 		: 	out std_logic; -- out 3
	
	OP		:	out std_logic_vector(1 downto 0); -- out 4
	
	SELECT1	:	out std_logic_vector(3 downto 0); -- out 5
	SELECT2	:	out std_logic_vector(1 downto 0); -- out 6
	
	CLR		:	out std_logic; -- out 7
	K		:	out std_logic_vector(7 downto 0); -- out 8
	BT		:	in	std_logic
	
	);
end component;

signal select1 : std_logic_vector(3 downto 0);
signal k	:	std_logic_vector(7 downto 0);
signal clear : std_logic;
signal bt : std_logic;
signal op : std_logic_vector(1 downto 0);
signal bitsclk : std_logic;
signal select2 : std_logic_vector(1 downto 0);

begin 
	
	sc0 : mux_10a1_1 port map(DTX,select1,MOSI);
	sc1 : contador_bt_k port map(RST,CLK,k,clear,bt);
	sc2 : SHR port map(RST,CLK,MISO,op,DRX);
	sc3 : mux_4a1_1 port map(bitsclk,select2,SCLK);
	sc4 : fsm_SCLK port map(RST,CLK,bt,bitsclk);
	sc5 : fsm_SPI port map(RST,CLK,start,fin,valido,CPOL,CPHA,CS,op,select1,select2,clear,k,bt);
	
end fsm;