library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Inverter is	
	
	generic(
	
	n :	integer := 12
	
	);
	
	port(
	
	RST,CLK : in std_logic;	
	
	a1 : in std_logic;
	
	b1 : in std_logic;
	
	a2 : in std_logic;
	
	b2 : in std_logic;
	
	p1 : out std_logic;
	
	p2 : out std_logic
	
	
	);	
	
end Inverter;

architecture fsm of Inverter is	


component sin is 
	
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
	
end component;	

component triangular is
	
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
	
end component;

component pwm is
	generic(
	
	n :	integer := 12
	
	);
	
	port(

	
	sin : in std_logic_vector(n-1 downto 0);
	trian : in std_logic_vector(n-1 downto 0);
	pwm : out std_logic
	
	);
	
end component; 


component pulso is
	port(
	pwm1 : in std_logic; 
	pwm2 : in std_logic;
	y1 : out std_logic;
	y2 : out std_logic
	
	);
	
end component;


component pwm_modulator is
	
	generic(
	
	n :	integer := 12
	
	);
	
	port(
	
	RST,CLK : in std_logic;	
	
	pwmi : in std_logic;
	
	c : in std_logic_vector(n-1 downto 0);
	
	pwm : out std_logic
	
	);
	
end component; 

component toggle is
	
	generic(
	
	n :	integer := 12
	
	);
	
	port(
	
	RST,CLK : in std_logic;	 
	frecuencia : in std_logic_vector(n-1 downto 0);
	y : out std_logic
	
	);		
	
end component;	 

component encoder is
	
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
	
end component;


signal seno,senophase,triangulo, amplitud, frecuencia : std_logic_vector(11 downto 0); 
signal pwm1,pwm2,s1,s2,y : std_logic;	
--signal frectraing : std_logic_vector(7 downto 0); 

begin	
	
	--frecseno <= frecuencia;   
	--frect <= "0000" & frectraing; 
	
	sc0 : sin port map(RST,y,"000000000000", "000000000001",open,seno);
	sc1 : triangular port map(RST,y,"000000111111",triangulo);
	sc2 : pwm port map (seno,triangulo,pwm1);
	sc3 : sin port map(RST,y,"011111111111","000000000001",open,senophase);
	sc4 : pwm port map (senophase,triangulo,pwm2); 
	sc5 : pulso port map (pwm1,pwm2,s1,s2);	
	sc6 : pwm_modulator port map(RST,y,s1,amplitud,p1);
	sc7 : pwm_modulator port map(RST,y,s2,amplitud,p2);
	--sc8 : multiplicador_n port map("0111",frecuencia,frectraing);	
	sc8 : toggle port map (RST,CLK,frecuencia,y); 
	sc9 : encoder port map(RST,CLK,"111111111111","000000000000",a1,b1,frecuencia);
	sc10 : encoder port map(RST,CLK,"111111111111","000000000000",a2,b2,amplitud);
	
	
	
end fsm;