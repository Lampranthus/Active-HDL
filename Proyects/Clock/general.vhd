library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity general is	
	
	port(
	
	RST,CLK : in std_logic;
	CLR : in std_logic;
	y : out std_logic
	
	);	
	
end general;

architecture fsm of general is	


component contador_bt_clear is  
	
	generic(
	
	n :	integer := 28;
	c : integer := 24999999
	
	);
	
	port(
	
	RST,CLK : in std_logic;
	
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
	
	sc0 : contador_bt_clear port map(RST,CLK,CLR,bt);
	
	sc1: fsm_toggle port map(RST,CLK,bt,y);
	
	
end fsm;