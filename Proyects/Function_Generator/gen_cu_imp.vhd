library ieee;
use ieee.std_logic_1164.all;

entity gen_cu_imp is
	port(
	
	RST,CLK : in std_logic;
	entrada : in std_logic;
	y : out std_logic_vector(11 downto 0)
	
	);
end gen_cu_imp;

architecture fsm of gen_cu_imp is	


signal qp, qn : std_logic; 

begin  
	
	c1 : process(qp,entrada)
	begin
		
		case(qp) is
		
		--s0
		when '0' =>
		y <= "000000000000"; 
		if(entrada='1') then
			qn <= '1';
		else
			qn <= '0';
		end if;
		
		--s1
		when others =>
		y <= "111111111111";  
		if(entrada='0') then
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