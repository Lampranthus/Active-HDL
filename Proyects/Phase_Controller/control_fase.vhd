library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity control_fase is
	
	generic(
	
	n :	integer := 6 
	
	);
	
	port(
	
	RST,CLK : in std_logic;
	kth	: in std_logic_vector(n-1 downto 0);
	y : out std_logic
	
	);	
	
end control_fase;

architecture fsm of control_fase is	


component contador_btt is  
	
	generic(
	
	n :	integer := 6;
	c : integer := 49
	
	);
	
	port(
	
	RST,CLK : in std_logic;
	
	CLR : in std_logic;
	
	BT : out std_logic
	
	);
	
end component; 


component contador_bth is  
	
	generic(
	
	n :	integer := 6
	);
	
	port( 
	
	RST,CLK : in std_logic;
	
	KTH	: in std_logic_vector(n-1 downto 0);
	
	CLR : in std_logic;	
	
	BT : out std_logic
	
	);
	
end component;

component fsm_fase is

	port(
	
	RST,CLK : in std_logic;	
	
	btt	: in std_logic;
	bth	: in std_logic;
	
	CLRT : out std_logic;
	CLRTH : out std_logic;
	
	y : out std_logic
	
	);
	
end component;	

signal btt : std_logic;
signal bth : std_logic;
signal CLRT : std_logic; 
signal CLRTH : std_logic;

begin 
	
	sc0 : contador_btt port map(RST,CLK,CLRT,btt);
	
	sc1 : contador_bth port map(RST,CLK,kth,CLRTH,bth);
	
	sc2: fsm_fase port map(RST,CLK,btt,bth,CLRT,CLRTH,y);
	
	
end fsm;