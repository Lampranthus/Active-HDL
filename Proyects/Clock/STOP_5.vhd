library ieee;
use ieee.std_logic_1164.all;

entity STOP_5 is
	port( 
	Dcont: in std_logic_vector(3 downto 0);
	CLR: out std_logic 
	);
end STOP_5;

architecture stop of STOP_5 is
signal s_d10: std_logic;
begin
	s_d10 <= (not Dcont(1)) or Dcont(0);
	CLR	<=	not(s_d10 or (not Dcont(2)));	
end stop;