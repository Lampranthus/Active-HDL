library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity reloj is	
	
	port(
	
	RST,CLK : in std_logic;
	start : in std_logic;
	num : in std_logic_vector(3 downto 0);
	disp : in std_logic_vector(1 downto 0);
	
	seg1,seg2,seg3,seg4 : out std_logic_vector(6 downto 0);
	desb : out std_logic
	
	);	
	
end reloj;

architecture fsm of reloj is	


component demux_1a4_n is
	
generic(
  n: integer := 4
);
port(
x				: in		std_logic_vector(n-1 downto 0);
s				: in		std_logic_vector(1 downto 0);
y0,y1,y2,y3		: out		std_logic_vector(n-1 downto 0)
); 
	
end component;

component general is	
	
	port(
	
	RST,CLK : in std_logic;
	CLR : in std_logic;
	y : out std_logic
	
	); 
	
end component;

component one_shot_soltar is
	
	port(
	
	RST, CLK : in std_logic;
	
	x : in std_logic;
	y : out std_logic
	
	); 
	
end component;

component decod_bcd_7seg is

port(
	bcd	: in		std_logic_vector (3 downto 0);
	y	: out		std_logic_vector (6 downto 0)
							   
); 
	
end component;

component FFD is

port(
RST, CLK, D : in std_logic;
Q : out std_logic
); 
	
end component;

component Contador_9 is
	port(
	CLR,CLK: in std_logic;
	Dset: in std_logic_vector(3 downto 0);
	Dcont: out std_logic_vector(3 downto 0);
	Fin: out std_logic
	); 
	
end component;


component Contador_5 is
	port(
	CLR,CLK: in std_logic;
	Dset: in std_logic_vector(3 downto 0);
	Dcont: out std_logic_vector(3 downto 0);
	Fin: out std_logic
	); 
	
	
end component;
	

signal bt,init : std_logic;
signal y1,y2,y3,y4 : std_logic_vector(3 downto 0);
signal tod1,tod2,tod3,tod4 : std_logic_vector(3 downto 0);

signal toff : std_logic;

signal fin1,fin2,fin3,fin4 : std_logic;

signal neg : std_logic;

begin
	
	neg <= not RST;
	
	sc0 : demux_1a4_n port map(num,disp,y1,y2,y3,y4);
	sc1 : general port map(RST,CLK,init,bt);
	sc2 : one_shot_soltar port map(RST, CLK,start,toff);
	sc3 : decod_bcd_7seg port map(tod1,seg1);
	sc4 : decod_bcd_7seg port map(tod2,seg2);
	sc5 : decod_bcd_7seg port map(tod3,seg3);
	sc6 : decod_bcd_7seg port map(tod4,seg4);
	sc7 : FFD port map(RST, CLK,toff,init);
	sc8 : Contador_9 port map(neg,bt,y1,tod1,fin1);	
	sc9 : Contador_5 port map(neg,fin1,y2,tod2,fin2);
	sc10 : Contador_9 port map(neg,fin2,y3,tod3,fin3);
	sc11 : Contador_5 port map(neg,fin3,y4,tod4,fin4);
	
	desb<=fin4;
	
end fsm;