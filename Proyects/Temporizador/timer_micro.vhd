library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity timer_micro is	
	generic(
	n : integer :=6
	);
	port(
	
	RST,CLK : in std_logic;
	start : in std_logic;
	timer : out std_logic_vector(n-1 downto 0);
	y : out std_logic
	
	);
end timer_micro;

architecture fsm of timer_micro is	


component contador_ab_eoc_n is
	generic(
	n : integer :=6;
	c : integer := 19
	);
	port(
		RST,CLK : in std_logic;
		opc : in std_logic_vector(1 downto 0);
		Q : out std_logic_vector(n-1 downto 0);
		EOC : out std_logic
	);
end component; 

component temporizador is
	port(
	
	RST,CLK : in std_logic;
	start : in std_logic;
	opc : out std_logic_vector(1 downto 0);
	EOC : in std_logic;
	y : out std_logic
	
	);
end component;	

signal EOC, salida : std_logic;	
signal opc : std_logic_vector(1 downto 0);
signal contador : 	std_logic_vector(n-1 downto 0);

begin 
	
	sc0 : temporizador port map(RST,CLK,start,opc,EOC,salida);
	
	sc1: contador_ab_eoc_n port map(RST,CLK,opc,contador,EOC);
	
	y <= salida;
	
	timer <= contador;
	
	
end fsm;