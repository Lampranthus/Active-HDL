library ieee;
use ieee.std_logic_1164.all;

entity fsm_PWM
	is
	port(
	
	RST,CLK : in std_logic;	
	
	btt	: in std_logic;
	bth	: in std_logic;
	
	CLRT : out std_logic;
	CLRTH : out std_logic;
	
	y : out std_logic
	
	);
end fsm_PWM;

architecture fsm of fsm_PWM is	


signal qp, qn : std_logic; 

begin  
	
	c1 : process(qp,btt,bth)
	begin
		
		case(qp) is
		
		--s0
		when '0' =>	
		
		CLRT <= '0';
		y <= '1';
		CLRTH <= '0';
		
		if(bth='1') then
			qn <= '1';
		else
			qn <= '0';
		end if;
		
		--s1
		when others =>
		
		y <= '0';
		CLRT <= '0';
		CLRTH <= '1';
		
		if(btt='1') then
			qn <= '0';
		else
			qn <= '1';
		end if;
		
		end case;
		
	end process;
	
	secuencial : process(RST,CLK)
	begin
		if(RST='0') then
			qp <= '0';
		elsif(CLK'event and CLK='1') then
			qp <= qn;
		end if;
	end process;
	
end fsm;