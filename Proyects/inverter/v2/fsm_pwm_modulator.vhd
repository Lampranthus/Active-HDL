library ieee;
use ieee.std_logic_1164.all;

entity fsm_pwm_modulator is
	port(
	
	RST,CLK : in std_logic;
	pwmi : in std_logic;
	bt : in std_logic; 
	clear : out std_logic;
	pwmo : out std_logic
	
	);
end fsm_pwm_modulator;

architecture fsm of fsm_pwm_modulator is	


signal qp, qn : std_logic_vector(1 downto 0); 

begin  
	
	c1 : process(qp,pwmi,bt)
	begin
		
		case(qp) is
		
		--s0
		when "00" =>
		pwmo <= '0'; 
		clear <= '1';
		if(pwmi='1') then
			qn <= "01";
		else
			qn <= "00";
		end if;
		
		--s1
		when "01" =>
		pwmo <= '0'; 
		clear <= '0';
		if(bt='1') then
			qn <= "10";
		elsif(pwmi='0') then
			qn <= "00";
		else
			qn <= "01";
		end if;
		
		--s2
		when others =>
		pwmo <= '1'; 
		clear <= '1';
		if(pwmi='0') then
			qn <= "00";
		else
			qn <= "10";
		end if;
		
		
		end case;
		
	end process;
	
	secuencial : process(RST,CLK)
	begin
		if(RST='0') then
			qp <= "00";
		elsif(CLK'event and CLK='1') then
			qp <= qn;
		end if;
	end process;
	
end fsm;