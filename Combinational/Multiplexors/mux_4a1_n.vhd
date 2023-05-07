library ieee;	   
use ieee.std_logic_1164.all; 


entity mux_4a1_n is
	generic(
	n	:	integer := 2 		--n-bits
	);
	port(
	x0,x1,x2,x3	: in std_logic_vector(n-1 downto 0);
	s			: in std_logic_vector(1 downto 0);
	y			: out std_logic_vector(n-1 downto 0)
	);
end mux_4a1_n;


architecture combinacional of mux_4a1_n is 
begin
	process (s,x0,x1,x2,x3)
	begin
		case s is
			when "00" 	=> y<=x0;
			when "01"	=> y<=x1;
			when "10" 	=> y<=x2;
			when others => y<=x3;
		end case;
	end process;
end combinacional;
