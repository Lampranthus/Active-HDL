library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity pwm_modulator is
	
	generic(
	
	n :	integer := 12
	
	);
	
	port(
	
	RST,CLK : in std_logic;	
	
	pwmi : in std_logic;
	
	c : in std_logic_vector(n-1 downto 0);
	
	pwm : out std_logic
	
	);	
	
end pwm_modulator;

architecture fsm of pwm_modulator is	




component contador_bt_clear is
	
	generic(
	
	n :	integer := 12
	
	);
	
	port(
	
	RST,CLK : in std_logic;	 
	
	c : in std_logic_vector(n-1 downto 0);
	
	CLR : in std_logic;
	
	BT : out std_logic
	
	);
	
end component;

component fsm_pwm_modulator is
	port(
	
	RST,CLK : in std_logic;
	pwmi : in std_logic;
	bt : in std_logic; 
	clear : out std_logic;
	pwmo : out std_logic
	
	);
	
end component;	

signal clear,bt : std_logic;

begin 
	
	sc0 : contador_bt_clear port map(RST,CLK,c,clear,bt);
	
	sc1 : fsm_pwm_modulator port map(RST,CLK,pwmi,bt,clear,pwm); 
	
	
end fsm;