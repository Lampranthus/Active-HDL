library ieee;	   
use ieee.std_logic_1164.all; 


entity mux_5a1_n is
	generic(
	n	:	integer := 12
	);
	port(
	x0,x1,x2,x3,x4	: in std_logic_vector(n-1 downto 0);
	s			: in std_logic_vector(2 downto 0);
	y			: out std_logic_vector(n-1 downto 0)
	);
end mux_5a1_n;


architecture combinacional of mux_5a1_n is 
begin
	process (s,x0,x1,x2,x3,x4)
	begin
		case s is
			when "000" 	=> y<=x0;
			when "001"	=> y<=x1;
			when "010" 	=> y<=x2;
			when "011" 	=> y<=x3;
			when others => y<=x4;
		end case;
	end process;
end combinacional;