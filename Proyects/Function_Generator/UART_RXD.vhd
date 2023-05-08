library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity UART_RXD is
	
	generic(
	
	n :	integer := 8 
	
	);
	
	port(
	
	RST,CLK : in std_logic;
	TXD	: in std_logic;
	
	RXD	: out std_logic_Vector(n-1 downto 0);
	pe : out std_logic;
	valido : out std_logic
	
	);	
	
end UART_RXD;

architecture fsm of UART_RXD is	


component bit_paridad_par is  

	port( 
	
	D	:	in	std_logic_vector(7 downto 0);
	pr	:	in std_logic;
	salida	:	out	std_logic 
	
	);

end component; 


component SHR1 is
	
	generic( 
	N : integer := 9
	);
	
	port(
	
	RST,CLK, R: in std_logic;
	OPR : in std_logic_vector(1 downto 0);
	Q : out std_logic_vector(N-2 downto 0);
	pr : out std_logic
	
	);	

end component;


component contador_bt_k is

	generic(
	n :	integer := 16
	);
	
	port(
	RST,CLK : in std_logic;
	k : in std_logic_vector(n-1 downto 0);
	CLR : in std_logic;
	BT : out std_logic
	);	
	
end component;


component fsm_RXD is

	port(
	
	RST,CLK : in std_logic;	
	
	RXD	: in std_logic;
	bt : in std_logic;
	
	CLR : out std_logic;
	OPC : out std_logic_vector(1 downto 0);
	k : out std_logic_vector(15 downto 0);
	valido : out std_logic
	
	);	
	
end component;
	

signal bt : std_logic;
signal opc : std_logic_vector(1 downto 0);
signal pr : std_logic;
signal clr : std_logic;
signal k : std_logic_vector(15 downto 0);
signal rx : std_logic_vector(7 downto 0);
signal tx : std_logic;

begin 
	
	tx <= TXD;
	
	sc0 : fsm_RXD port map(RST,CLK,tx,bt,clr,opc,k,valido);
	
	sc1 : contador_bt_k port map(RST,CLK,k,clr,bt);
	
	sc2 : SHR1 port map(RST,CLK,tx,opc,rx,pr);
	
	sc3	: bit_paridad_par port map(rx,pr,pe);
	
	RXD <= rx;
	
	
end fsm;