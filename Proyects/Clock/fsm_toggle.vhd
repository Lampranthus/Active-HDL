library ieee;
use ieee.std_logic_1164.all;

entity fsm_toggle is
	port(
	
	RST,CLK : in std_logic;
	bt : in std_logic;
	y : out std_logic
	
	);
end fsm_toggle;

architecture fsm of fsm_toggle is	


signal qp, qn : std_logic; 

begin  
	
	c1 : process(qp,bt)
	begin
		
		case(qp) is
		
		--s0
		when '0' =>
		y <= '0'; 
		if(bt='1') then
			qn <= '1';
		else
			qn <= '0';
		end if;
		
		--s1
		when others =>
		y <= '1'; 
		if(bt='1') then
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