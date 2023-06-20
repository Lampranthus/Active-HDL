library ieee;
use ieee.std_logic_1164.all;

entity pulso is
	port(
	pwm1 : in std_logic; 
	pwm2 : in std_logic;
	y1 : out std_logic;
	y2 : out std_logic
	
	);
end pulso;

architecture fsm of pulso is	


begin  
	
	c1 : process(pwm1,pwm2)
	begin
		
		if((pwm1='0' and pwm2='0') and (pwm1='1' and pwm2='1')) then
			y1 <= '0';
			y2 <= '0';
		elsif (pwm1='1' and pwm2='0') then
			y1 <= '1';
			y2 <= '0'; 
		elsif(pwm1='0' and pwm2='1') then
			y1 <= '0';
			y2 <= '1';
		else 
			y1 <= '0';
			y2 <= '0';
		end if;
		
	end process;
	
	
end fsm;