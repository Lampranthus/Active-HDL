library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity if_triangular is
	generic(
	
	n :	integer := 12;
	k1 : std_logic_vector := "111111111111";
	k2 : std_logic_vector := "000000000000"
	
	);
	
	port(
	RST,CLK	:	in std_logic;
	entrada : in std_logic_vector(n-1 downto 0);
	f : in std_logic_vector(n-1 downto 0);
	op : out std_logic
	
	);
end if_triangular;

architecture fsm of if_triangular is	

 
signal qp, qn : std_logic; 

begin
	
	c1 : process(qp,entrada,f)
	Variable resta	:	unsigned(n downto 0);
	Variable suma	:	unsigned(n downto 0);
	begin
		resta := unsigned('0' & k1) - unsigned('0' & f);
		suma := unsigned('0' & k2) + unsigned('0' & f);
		
		case(qp) is
		
		--s0
		when '0' =>
		op <= '0'; 
		if((entrada>=std_logic_vector(resta(n-1 downto 0))) and (entrada<=k1)) then
			qn <= '1';
		else
			qn <= '0';
		end if;
		
		--s1
		when others =>
		op <= '1'; 
		if((entrada<=std_logic_vector(suma(n-1 downto 0))) and (entrada>=k2)) then
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