library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity generador_interface_1 is
	
	port(
	
	RST,CLK : 	in std_logic;
	
	--c 		: in std_logic_vector(3 downto 0);	   --set "000000000001"
	
	test : 	in std_logic_vector(1 downto 0);--test
	
	--frecuencia : in std_logic_vector(3 downto 0);
	
	--palabra_recibida : out std_logic_vector(7 downto 0);
		
	--rx 	: 	in std_logic;
	
	enable 	: 	out std_logic;
	CS 		: 	out std_logic;
	SCLK 	: 	out std_logic;
	MOSI	: 	out std_logic;
	LDAC	: 	out std_logic
	
	);	
	
end generador_interface_1;

architecture fsm of generador_interface_1 is	



component generador_5func is	
	
	port(
	
	RST,CLK : in std_logic;
	
	fin_dac : in std_logic;
	
	frecuencia : in std_logic_vector(11 downto 0);
	
	palabra : in std_logic_vector(7 downto 0); 
	
	salida_funcion : out std_logic_vector(11 downto 0)
	
	);		

end component;	


component DAC7564 is
	
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
	
	
end	component;


component registro_paralelo_multifuncion is
	
	generic(
	
	n : integer := 8
	
	);
	
	port(
	
	Din : in std_logic_vector(n-1 downto 0);   
	
	OPR : in std_logic_vector(1 downto 0);
	
	RST,CLK : in std_logic; 
	
	Qout : out std_logic_vector(n-1 downto 0)	
	
	);
	
end component;


signal valor,f,k : std_logic_vector(11 downto 0);
signal rxd,q,qr,prueba_aux : std_logic_vector(7 downto 0);
signal val,fin_dac,pari : std_logic;  
signal op,prueba : std_logic_vector(1 downto 0);
	
begin 
	
	prueba_aux <= test & "000001";
	
	op <= '0' & val;
	
	qr<=q;
	
	f<= "000000001111"; --& frecuencia(3 downto 0);	
	k<= "000000001111"; --& c(3 downto 0);
	
	--palabra_recibida <= qr;
	
	sc0 : DAC7564 port map(RST,CLK,k,valor,"00",'1',fin_dac,enable,CS,SCLK,MOSI,LDAC);
	sc1 : generador_5func port map(RST,CLK,fin_dac,f,prueba_aux,valor); --test prueba_aux
	--sc2 : UART_RXD port map(RST,CLK,rx,rxd,pari,val);
	sc3 : registro_paralelo_multifuncion port map(rxd,op,RST,CLK,q);
	
end fsm;