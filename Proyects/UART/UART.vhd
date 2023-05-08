library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Oscilloscope is
	
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
	
end Oscilloscope;

architecture fsm of Oscilloscope is	

component UART_TXD is
	
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
	
end component;

component UART_RXD is
	
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
	
end component;



begin 
	
	sc0 : UART_TXD port map(RST,CLK,DTX,start,TX,fin);
	
	sc1 : UART_RXD port map(RST,CLK,RX,DRX,pe,valido);
	
	
end fsm;