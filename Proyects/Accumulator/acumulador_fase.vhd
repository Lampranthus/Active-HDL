library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity acumulador_fase is
	
	generic(
	
	n :	integer := 12
	
	);
	
	port(
	
	RST,CLK : in std_logic;
	
	f : in std_logic_vector(n-1 downto 0);
	
	--op : in  std_logic_vector(1 downto 0); --siempre 0
	
	--Ci : in std_logic; --siempre 0
	
	Qmsb : out std_logic;
	
	Co	: out std_logic;
	
	Q : out std_logic_vector(n-1 downto 0)
	
	);	
	
end acumulador_fase;

architecture fsm of acumulador_fase is	




component registro is  
	
	generic(
	
	n : integer := 12
	
	);
	
	port(
	
	Din : in std_logic_vector(n-1 downto 0);   
	
	OPR : in std_logic_vector(1 downto 0);
	
	RST,CLK : in std_logic; 
	
	Qout : out std_logic_vector(n-1 downto 0)	
	
	);	
	
end component;

component sumador is

	generic(
	n : integer :=12
	);
	port(
	A,B :	in std_logic_vector(n-1 downto 0);
	Ci	:	in std_logic; -- siempre 0
	S	:	out std_logic_vector(n-1 downto 0);
	Co	:	out std_logic 
	);	
	
end component;	

signal suma : std_logic_vector(n-1 downto 0);
signal salida : std_logic_vector(n-1 downto 0);

begin 
	
	sc0 : sumador port map(salida,f,'0',suma,Co);
	
	sc1 : registro port map(suma,"00",RST,CLK,salida);
	
	Q <= salida;
	
	Qmsb <= salida(n-1);
	
	
end fsm;