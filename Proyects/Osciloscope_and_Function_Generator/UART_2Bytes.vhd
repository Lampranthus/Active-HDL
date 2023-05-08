library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity UART_2Bytes is
	
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
	
end UART_2Bytes;

architecture fsm of UART_2Bytes is	


component registro is
	
	generic(
	
	n : integer := 12
	
	);
	
	port(
	
	Din : in std_logic_vector(n-1 downto 0);   
	
	OPR : in std_logic_vector(1 downto 0);
	
	RST,CLK : in std_logic; 
	
	Qout : out std_logic_vector(n-1 downto 0)	
	
	);	

end component;



component mux_2a1_n is
	generic(
	n	:	integer := 8
	);
	port(
	x0,x1		: in std_logic_vector(n-1 downto 0);
	s			: in std_logic;
	y			: out std_logic_vector(n-1 downto 0)
	);	

end component;


component fsm_uart_2bytes is
	port(
	
	RST,CLK : in std_logic;	
	
	start	: out std_logic;
	fin 	: in std_logic;
	
	op		: out std_logic_vector(1 downto 0);
	
	mux 	: out std_logic
	
	);
	
end component;


component UART is
	
	generic(
	
	n :	integer := 8 
	
	);
	
	port(
	
	RST,CLK : in std_logic;
	
	DTX	: in std_logic_vector(n-1 downto 0);
	start : in std_logic;
	
	TX	: out std_logic;
	fin : out std_logic;
	

	RX	: in std_logic;
	
	DRX	: out std_logic_Vector(n-1 downto 0);
	pe : out std_logic;
	valido : out std_logic
	
	); 
	
end component;

signal st,fin,mux : std_logic;
signal b,b1,b2 : std_logic_vector(7 downto 0); 
signal op : std_logic_vector(1 downto 0);
signal valor : std_logic_vector(11 downto 0);

begin 
	
	b2 <= valor(7 downto 0);
	b1 <=  "0000" & valor(11) & valor(10) &  valor(9) & valor(8)  ;
	
	sc0 : mux_2a1_n port map(b1,b2,mux,b);
	
	sc1 : fsm_uart_2bytes port map(RST,CLK,st,fin,op,mux);
	
	sc2 : UART port map(RST,CLK,b,st,TXD,fin,RXD,DRX,open,valido);
	
	sc3 : registro port map(value0,op,RST,CLK,valor);
	
	
	
end fsm;