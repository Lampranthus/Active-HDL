library ieee;
use ieee.std_logic_1164.all;

entity temporizador is
	port(
	
	RST,CLK : in std_logic;
	start : in std_logic;
	opc : out std_logic_vector(1 downto 0);
	EOC : in std_logic;
	y : out std_logic
	
	);
end temporizador;

architecture fsm of temporizador is	


signal qp, qn : std_logic; 

begin  
	
	c1 : process(qp,EOC,start)
	begin
		
		case(qp) is
		
		--s0
		when '0' =>
		y <= '0'; 
		opc <= "11";   --clr
		if(start='1') then
			qn <= '1';
		else
			qn <= '0';
		end if;
		
		--s1
		when others =>
		y <= '1'; 
		opc <= "00";   --asc
		if(EOC='1') then
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