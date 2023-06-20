library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity pwm is
	generic(
	
	n :	integer := 12
	
	);
	
	port(
	
	sin : in std_logic_vector(n-1 downto 0);
	trian : in std_logic_vector(n-1 downto 0);
	pwm : out std_logic
	
	);
end pwm;

architecture fsm of pwm is	


signal qp, qn : std_logic; 

begin  
	
	c1 : process(sin,trian)	
	begin
		
		pwm <= '0'; 
		if(sin > trian) then
			pwm <= '0';
		elsif (sin < trian) then
			pwm <= '1';
		else 
			pwm <= '0';
		end if;	
		
	end process;

	
end fsm;