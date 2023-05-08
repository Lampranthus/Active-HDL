library ieee;
use ieee.std_logic_1164.all;

entity fsm_tinaco is
	port(
	
	RST,CLK : in std_logic;
	T,F : in std_logic;
	M : out std_logic
	
	);
end fsm_tinaco;

architecture fsm of fsm_tinaco is	 
signal qp,qn : std_logic;
begin  
	
	c1 : process(qp,T,F)
	begin
		
		if(qp = '0') then
			M <= '0';
			if(T='0' and F='0') then
				qn <= '1';
			else
				qn <= qp;
			end if;
		else
			M <= '1';
			if(T='0') then
				qn <= qp;
			else
				qn <= '0';
			end if;
		end if;
		
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