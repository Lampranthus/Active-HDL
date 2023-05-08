library ieee;	   
use ieee.std_logic_1164.all; 


entity mux_2a1_n is
	generic(
	n	:	integer := 8
	);
	port(
	x0,x1		: in std_logic_vector(n-1 downto 0);
	s			: in std_logic;
	y			: out std_logic_vector(n-1 downto 0)
	);
end mux_2a1_n;


architecture combinacional of mux_2a1_n is 
begin
	process (s,x0,x1)
	begin
		case s is
			when '1' 	=> y<=x0;
			when others => y<=x1;
		end case;
	end process;
end combinacional;