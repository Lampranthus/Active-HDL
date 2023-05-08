library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity generador_5func is	
	
	port(
	
	RST,CLK : in std_logic;
	
	fin_dac : in std_logic;
	
	frecuencia : in std_logic_vector(11 downto 0);
	
	palabra : in std_logic_vector(7 downto 0); 
	
	salida_funcion : out std_logic_vector(11 downto 0)
	
	);	
	
end generador_5func;

architecture fsm of generador_5func is	

component signals is 
	
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
	
end component;

component fsm_toggle is
	port(
	
	RST,CLK : in std_logic;
	bt : in std_logic;
	y : out std_logic
	
	);
	
end component;


component multiplexor_4a1_n is	 
	generic(
	n	: integer := 12
	);
	port(
	A,B,C,D		: in std_logic_vector(n-1 downto 0);
	S		: in std_logic_vector(1 downto 0);
	Y		: out std_logic_vector(n-1 downto 0)
	);
	
end component;

component gen_cu_imp is
	port(
	
	RST,CLK : in std_logic;
	entrada : in std_logic;
	y : out std_logic_vector(11 downto 0)
	
	);
	
end component;

signal reloj_sig,cu,imp : std_logic;
signal sierra, seno, cuadrada, impulso : std_logic_vector(11 downto 0); 
signal funcion : std_logic_vector(1 downto 0);

begin
	
	--frecuencia <= "000000" & palabra(5 downto 0);
	funcion <=	palabra(7 downto 6); 
	
	sc0 : signals port map(RST,fin_dac,frecuencia,cu,imp,sierra,seno);  --fin dac como toggle
	--sc1 : fsm_toggle port map(RST,CLK,fin_dac,reloj_sig);
	sc2 : multiplexor_4a1_n port map(seno,sierra,cuadrada,impulso,funcion,salida_funcion);	
	sc3 : gen_cu_imp port map(RST,CLK,cu,cuadrada);
	sc4 : gen_cu_imp port map(RST,CLK,imp,impulso);
	
end fsm;