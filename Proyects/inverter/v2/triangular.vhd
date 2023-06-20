library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity triangular is
	
	generic(
	
	n :	integer := 12
	
	);
	
	port(
	
	RST,CLK : in std_logic;
	
	f : in std_logic_vector(n-1 downto 0);
	
	--op : in  std_logic_vector(1 downto 0); --siempre 0
	
	--Ci : in std_logic; --siempre 0
	
	Q : out std_logic_vector(n-1 downto 0)
	
	);	
	
end triangular;

architecture fsm of triangular is	




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

component restador_n is
	generic(
	n	:	integer	:= 12
	);
	
	port(
	A,B	:	in	std_logic_vector(n-1 downto 0);
	R	:	out std_logic_vector(n-1 downto 0)
	); 
	
end component;

component multiplexor_2a1_n is	 
	generic(
	n	: integer := 12
	);
	port(
	A,B		: in std_logic_vector(n-1 downto 0);
	S		: in std_logic;
	Y		: out std_logic_vector(n-1 downto 0)
	);
end component;	

component if_triangular is
	generic(
	
	n :	integer := 12
	
	);
	
	port(
	RST,CLK	:	in std_logic;
	entrada : in std_logic_vector(n-1 downto 0);
	f : in std_logic_vector(n-1 downto 0);
	op : out std_logic
	
	);
	
end component;


signal suma,resta,senal : std_logic_vector(n-1 downto 0);
signal salida : std_logic_vector(n-1 downto 0);	
signal op,Co : std_logic;

begin 
	
	sc0 : sumador port map(salida,f,'0',suma,Co);
	
	sc1 : registro port map(senal,"00",RST,CLK,salida); 
	
	sc2 : restador_n port map(salida,f,resta);
	
	sc3 : multiplexor_2a1_n port map(suma,resta,op,senal);	 
	
	sc4 : if_triangular port map(RST,CLK,salida,f,op);
	
	Q <= salida;
	
	
end fsm;