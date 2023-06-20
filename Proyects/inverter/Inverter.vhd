library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;



entity Inverter is 
	
	generic(
	
	n :	integer := 12
	
	);
	
	port(
	
	RST,CLK : in std_logic;
	
	frec : in std_logic_vector(n-1 downto 0);  
	
	amp : in std_logic_vector(n-1 downto 0);
	
	pwm : out std_logic
	
	);	
	

 end Inverter;






architecture fsm of Inverter is	


component sine is 
	
	generic(
	
	n :	integer := 12
	
	);
	
	port(
	
	RST,CLK : in std_logic;
	
	f : in std_logic_vector(n-1 downto 0);
	
	Qmsb : out std_logic; --cuadrada
	
	Co	: out std_logic; --impulso
	
	--Q : out std_logic_vector(5 downto 0);	--sierra
	
	s	: 	out std_logic_vector(n-1 downto 0) --seno
	
	);		
	
end component;


component controlador_PWM is
	
	generic(
	
	n :	integer := 12 
	
	);
	
	port(
	
	RST,CLK : in std_logic;
	kth	: in std_logic_vector(n-1 downto 0);
	y : out std_logic
	
	);	
	
end component;



signal salida : std_logic_vector(n-1 downto 0);

begin 
	
	sc0 : sine port map(RST,CLK,frec,open,open,salida);
	
	sc1 : controlador_PWM port map(RST,CLK,salida,pwm);
	
	
end fsm;