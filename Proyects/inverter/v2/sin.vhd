library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;



entity sin is 
	
	generic(
	
	n :	integer := 12
	
	);
	
	port(
	
	RST,CLK : in std_logic;
	
	p : in std_logic_vector(n-1 downto 0);
	
	f : in std_logic_vector(n-1 downto 0);
	
	Co	: out std_logic; --impulso
	
	s	: 	out std_logic_vector(n-1 downto 0) --seno
	
	);	
	

 end sin;






architecture fsm of sin is	


component acumulador_fase is
	
	generic(
	
	n :	integer := 12
	
	);
	
	port(
	
	RST,CLK : in std_logic;
	
	f : in std_logic_vector(n-1 downto 0);
	
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



signal salida,salidaphase : std_logic_vector(n-1 downto 0);
signal suma	:	unsigned(n downto 0);

begin
	suma <= unsigned('0' & salida) + unsigned('0' & p);
	salidaphase <=	std_logic_vector(suma(n-1 downto 0));
	
	sc0 : acumulador_fase port map(RST,CLK,f,Co,salida);
	
	sc1 : LUT_SIN_SIGNAL port map(salidaphase,s);
	
	
end fsm;