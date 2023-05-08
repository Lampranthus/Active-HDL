library ieee;
use ieee.std_logic_1164.all;

entity fsm_contador_m4 is
	port(
	
	RST,CLK : in std_logic;
	opc : in std_logic;
	Q : out std_logic_vector(1 downto 0)
	
	);
end fsm_contador_m4;

architecture fsm of fsm_contador_m4 is	 

signal qp, qn : std_logic_vector(1 downto 0);
begin  
	
	c1 : process(qp,opc)
	begin
		
		case(qp) is
		
		--s0
		when "00" =>
		Q <= "00";
		if(opc='0') then
			qn <= "01";
		else
			qn <= "11";
		end if;
		
		--s1
		when "01" =>
		Q <= "01";
		if(opc='0') then
			qn <= "10";
		else
			qn <= "00";
		end if;
		
		--s2
		when "10" =>
		Q <= "10";
		if(opc='0') then
			qn <= "11";
		else
			qn <= "01";
		end if;
		
		--s3
		when others =>
		Q <= "11";
		if(opc='0') then
			qn <= "00";
		else
			qn <= "10";
		end if;
		
		end case;
		
	end process;
	
	secuencial : process(RST,CLK)
	begin
		if(RST='0') then
			qp <= (others => '0');
		elsif(CLK'event and CLK='1') then
			qp <= qn;
		end if;
	end process;
	
end fsm;