library ieee;
use ieee.std_logic_1164.all;


entity mux_3a1_8 is
	port(
		D0		:	in	std_logic_vector(7 downto 0);
		D1		:	in	std_logic_vector(7 downto 0);
		D2		:	in	std_logic_vector(7 downto 0);
		S		: 	in 	std_logic_vector(1 downto 0);
		Y		: 	out std_logic_vector(7 downto 0)
	);
end mux_3a1_8;


architecture simple of mux_3a1_8 is
begin
	mux:process(S,D0,D1,D2)
	begin
		case S is
			when "00" =>
			Y<=D0;
			when "01" =>
			Y<=D1;
			when others =>
			Y<=D2; 
		end case;
	end process;
end simple;