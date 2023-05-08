library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity toggle is
	
	generic(
	
	n :	integer := 12 
	
	);
	
	port(
	
	RST,CLK : in std_logic;
	
	K : in std_logic_vector(n-1 downto 0);
	
	CLR : in std_logic;
	
	y : out std_logic
	
	);	
	
end toggle;

architecture fsm of toggle is	


component contador_bt_k is
	
	generic(
	
	n :	integer := 12

	);
	
	port(
	
	RST,CLK : in std_logic;
	
	k : in std_logic_vector(n-1 downto 0);
	
	CLR : in std_logic;
	
	BT : out std_logic
	
	);
	
end component; 

component fsm_toggle is

	port(
	
	RST,CLK : in std_logic;
	bt : in std_logic;
	y : out std_logic
	
	);
	
end component;	

signal bt : std_logic;	

begin 
	
	sc0 : contador_bt_k port map(RST,CLK,K,CLR,bt);
	
	sc1: fsm_toggle port map(RST,CLK,bt,y);
	
	
end fsm;