library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity UART_TXD is
	
	generic(
	
	n :	integer := 8 
	
	);
	
	port(
	
	RST,CLK : in std_logic;
	D	: in std_logic_vector(n-1 downto 0);
	start : in std_logic;
	
	TXD	: out std_logic;
	fin : out std_logic
	
	);	
	
end UART_TXD;

architecture fsm of UART_TXD is	


component paridad_8 is  

	port( 
	
	D	:	in	std_logic_vector(7 downto 0);
	Y	:	out	std_logic 
	
	);

end component; 


component mux_11a1_1 is
	
	port(
	D	:	in	std_logic_vector(7 downto 0);
	P 	: 	in std_logic;
	S		: in 	std_logic_vector(3 downto 0);
	Y		: out 	std_logic
	);	

end component;


component contador_bt is

	generic(
	
	n :	integer := 16;
	k : integer := 5208
	
	);
	
	port(
	
	RST,CLK : in std_logic;
	
	CLR : in std_logic;
	
	BT : out std_logic
	
	);	
	
end component;


component fsm_TXD is

	port(
	
	RST,CLK : in std_logic;	
	
	start	: in std_logic;
	bt	: in std_logic;	
	
	CLR : out std_logic;
	OPC : out std_logic_vector(3 downto 0);
	fin : out std_logic
	
	);	
	
end component;

component one_shot_soltar is
	
	port(
	
	RST, CLK : in std_logic;
	
	x : in std_logic;
	y : out std_logic
	
	);
	
end component;


	

signal bt : std_logic;
signal opc : std_logic_vector(3 downto 0);
signal p : std_logic;
signal clr : std_logic;
signal st :std_logic;

begin 
	
	sc0 : fsm_TXD port map(RST,CLK,st,bt,clr,opc,fin);
	
	sc1 : contador_bt port map(RST,CLK,clr,bt);
	
	sc2 : mux_11a1_1 port map(D,p,opc,TXD);
	
	sc3	: paridad_8 port map(D,p);
	
	sc4 : one_shot_soltar port map(RST,CLK,start,st);
	
	
end fsm;