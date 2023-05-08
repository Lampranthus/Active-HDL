library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;



entity signals is 
	
	generic(
	
	n :	integer := 12
	
	);
	
	port(
	
	RST,CLK : in std_logic;
	
	f : in std_logic_vector(n-1 downto 0);
	
	Qmsb : out std_logic; --cuadrada
	
	Co	: out std_logic; --impulso
	
	Q : out std_logic_vector(n-1 downto 0);	--sierra
	
	s	: 	out std_logic_vector(n-1 downto 0) --seno
	
	);	
	

 end signals;






architecture fsm of signals is	


component acumulador_fase is
	
	generic(
	
	n :	integer := 12
	
	);
	
	port(
	
	RST,CLK : in std_logic;
	
	f : in std_logic_vector(n-1 downto 0);
	
	Qmsb : out std_logic;
	
	Co	: out std_logic;
	
	Q : out std_logic_vector(n-1 downto 0)
	
	);	
	
end component;


component LUT_SIN_SIGNAL is 
	
	port (
    	F	:	in std_logic_vector(11 downto 0);
    	s	: 	out std_logic_vector(11 downto 0)
    );
	
end component;



signal salida,aux : std_logic_vector(n-1 downto 0);
signal aux1 : std_logic;

begin

	aux <= salida;
	
	sc0 : acumulador_fase port map(RST,CLK,f,Qmsb,Co,salida);
	
	sc1 : LUT_SIN_SIGNAL port map(salida,s);
	
	Q <= aux;
	
	
end fsm;