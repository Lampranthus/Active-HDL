library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity escuinbapa2 is
	
	generic(
	
	n :	integer := 12 
	
	);
	
	port(
	
	RST,CLK 	: 	in std_logic;

	
------------------------------------------------------------------
	
	c 		: in std_logic_vector(11 downto 0);	   --set "000000000001"
	
	test : 	in std_logic_vector(1 downto 0);--test
	
	frecuencia : in std_logic_vector(11 downto 0);
	
	--palabra_recibida : out std_logic_vector(7 downto 0);
		
	--rx 	: 	in std_logic;
	
	enable 	: 	out std_logic;
	CS 		: 	out std_logic;
	SCLK 	: 	out std_logic;
	MOSI	: 	out std_logic;
	LDAC	: 	out std_logic;
	---------------------------------------------------------------
	convst 	: 	out std_logic;
	sck 		: 	out std_logic;
	sdi		: 	out std_logic;
	sdo		: 	in std_logic;
	
	TXD		: out std_logic;
	RXD		: in std_logic;
	
	DRX	: out std_logic_Vector(7 downto 0);
	valido : out std_logic
	
	);	
	
end escuinbapa2;

architecture fsm of escuinbapa2 is	





component generador_interface_1 is
	
	port(
	
	RST,CLK : 	in std_logic;
	
	--c 		: in std_logic_vector(11 downto 0);	   --set "000000000001"
	
	test : 	in std_logic_vector(1 downto 0);--test
	
	--frecuencia : in std_logic_vector(11 downto 0);
	
	--palabra_recibida : out std_logic_vector(7 downto 0);
		
	--rx 	: 	in std_logic;
	
	enable 	: 	out std_logic;
	CS 		: 	out std_logic;
	SCLK 	: 	out std_logic;
	MOSI	: 	out std_logic;
	LDAC	: 	out std_logic
	
	);
	
end	component;


component proyecto is
	
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
	
end component;



begin 
	
	sc0 : proyecto port map(RST,CLK,convst,sck,sdi,sdo,TXD,RXD,DRX,valido);
	sc1 : generador_interface_1 port map(RST,CLK,test,enable,CS,SCLK,MOSI,LDAC);
	
end fsm;