library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity DAC7564 is
	
	generic(
	
	n :	integer := 12 
	
	);
	
	port(
	
	RST,CLK : 	in std_logic; 
	
	c 		: in std_logic_vector(11 downto 0);
	

	value	: 	in std_logic_vector(n-1 downto 0);
	chan	: 	in std_logic_vector(1 downto 0);
	
	
	start 	: 	in std_logic;
	fin 	: 	out std_logic;
	
	enable 	: 	out std_logic;
	CS 		: 	out std_logic;
	SCLK 	: 	out std_logic;
	MOSI	: 	out std_logic;
	LDAC	: 	out std_logic
	
	);	
	
end DAC7564;

architecture fsm of DAC7564 is	


component mux_3a1_8 is
	port(
		D0		:	in	std_logic_vector(7 downto 0);
		D1		:	in	std_logic_vector(7 downto 0);
		D2		:	in	std_logic_vector(7 downto 0);
		S		: 	in 	std_logic_vector(1 downto 0);
		Y		: 	out std_logic_vector(7 downto 0)
	);
	
end component;

	
component contador_bt_k is
	
	generic(
	
	n :	integer := 12

	);
	
	port(
	
	RST,CLK : in std_logic;
	
	k : in std_logic_vector(n-1 downto 0);
	
	CLR : in std_logic;
	
	BT : out std_logic
	
	);
end component; 

component SPI is
	
	generic(
	
	n :	integer := 8 
	
	);
	
	port(
	
	RST,CLK : 	in std_logic;
	
	c 		: in std_logic_vector(11 downto 0);
	
	
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
	
end component;


component fsm_DAC7564 is 
	
	port(
	
	RST,CLK : in std_logic;	
	--entradas
	init	: in std_logic;							--in1
	bt		: in std_logic;							--in2
	valid	: in std_logic;							--in3
	--salidas
	mux		: out std_logic_vector(1 downto 0);		--out1
	start	: out std_logic;						--out2
	ldac	: out std_logic;						--out3
	clr		: out std_logic;						--out4
	fin		: out std_logic							--out5
	
	
	);
	
end component;


signal clear : std_logic;
signal bt : std_logic;
signal valid : std_logic;
signal init : std_logic;
signal end_spi : std_logic;
signal mux : std_logic_vector(1 downto 0);
signal dr : std_logic_vector(7 downto 0);
signal dato : std_logic_vector(7 downto 0);
signal MISO : std_logic;
signal p1 : std_logic_vector(7 downto 0);
signal p2 : std_logic_vector(7 downto 0); 
signal p3 : std_logic_vector(7 downto 0);


begin 
	
	p1 <= '0' & chan(0) & chan(1) & "01000";
	p2 <= value(4) & value(5) & value(6) & value(7) & value(8) & value(9) & value(10) & value(11);
	p3 <= "1111" & value(0) & value (1) & value(2) & value (3);
	
	enable <='0';
	
	sc0 : mux_3a1_8 port map(p1,p2,p3,mux,dato);
	sc1 : contador_bt_k port map(RST,CLK,"000000000110",clear,bt);--c hasta
	sc2 : SPI port map(RST,CLK,c,dato,dr,init,end_spi,valid,'1','0',CS,SCLK,MOSI,MISO);--pol pha
	sc3 : fsm_DAC7564 port map(RST,CLK,start,bt,valid,mux,init,LDAC,clear,fin);
	
end fsm;