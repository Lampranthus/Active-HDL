library ieee;
use ieee.std_logic_1164.all;

entity STOP_9 is
	port( 
	Dcont: in std_logic_vector(3 downto 0);
	CLR: out std_logic 
	);
end STOP_9;

architecture stop of STOP_9 is
signal s_d10,s_d32: std_logic;
begin
	s_d32 <= (not Dcont(3)) or Dcont(2);
	s_d10 <= (not Dcont(1)) or Dcont(0);
	CLR	<=	not(s_d10 or s_d32);	
end stop;