library ieee;
use ieee.std_logic_1164.all;

entity fsm_fase
	is
	port(
	
	RST,CLK : in std_logic;	
	
	btt	: in std_logic;
	bth	: in std_logic;
	
	CLRT : out std_logic;
	CLRTH : out std_logic;
	
	y : out std_logic
	
	);
end fsm_fase;

architecture fsm of fsm_fase is	


signal qp, qn : std_logic_vector(1 downto 0); 

begin  
	
	c1 : process(qp,btt,bth)
	begin
		
		case(qp) is
		
		--s0
		when "00" =>	
		
		CLRT <= '0';
		y <= '0';
		CLRTH <= '1';
		
		if(btt='1') then
			qn <= "01";
		else
			qn <= "00";
		end if;
		
		--s1
		when "01" =>	
		
		CLRT <= '0';
		y <= '0';
		CLRTH <= '0';
		
		if(bth='1') then
			qn <= "10";
		else
			qn <= "01";
		end if;
		
		--s2
		when others =>
		
		y <= '1';
		CLRT <= '0';
		CLRTH <= '1';
		
		if(bth='0') then
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