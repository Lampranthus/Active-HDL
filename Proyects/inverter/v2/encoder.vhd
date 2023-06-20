library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity encoder is
	
	generic(
	
	n :	integer := 12
	);
	
	port(
	
	RST,CLK : in std_logic;	   
	
	sup : in std_logic_vector(n-1 downto 0);
	inf : in std_logic_vector(n-1 downto 0);
	
	s1 : in std_logic;	
	
	s2 : in std_logic;
	
	salida : out std_logic_vector(n-1 downto 0)
	
	);	
	
end encoder;

architecture fsm of encoder is	


component contador_adhb_n is
	generic(
		n : integer :=12
	);
	port(
		RST,CLK : in std_logic;
		opc : in std_logic_vector(1 downto 0); 
		Q : out std_logic_vector(n-1 downto 0)
	);
	
end component;	

component fsm_encoder	is 
	
	generic(
		n : integer :=12
	);
	
	port(
	
	RST, CLK : in std_logic;
	
	sup : in std_logic_vector(n-1 downto 0);
	inf : in std_logic_vector(n-1 downto 0);
	
	s1 : in std_logic;
	s2 : in std_logic; 
	Q : in std_logic_vector(n-1 downto 0);
	opc : out std_logic_vector(1 downto 0)
	
	);
	
end component;

signal Q : std_logic_vector(n-1 downto 0);	
signal opc : std_logic_vector(1 downto 0);

begin 
	
	sc0 : fsm_encoder port map(RST, CLK, sup, inf, s1, s2, Q, opc); 
	
	sc1 : contador_adhb_n port map(RST, CLK,opc,Q);	
	
	salida <=Q;
	
	
end fsm;