library ieee;
use ieee.std_logic_1164.all;


entity mux_11a1_1 is
	port(
		D	:	in	std_logic_vector(7 downto 0);
	   	P 	: 	in std_logic;
		S		: in 	std_logic_vector(3 downto 0);
		Y		: out 	std_logic
	);
end mux_11a1_1;


architecture simple of mux_11a1_1 is
begin
	mux:process(S,D,P)
	begin
		case S is
			when "0000" =>
			Y<=D(0);
			when "0001" =>
			Y<=D(1);
			when "0010" =>
			Y<=D(2);  
			when "0011" =>
			Y<=D(3);
			when "0100" =>
			Y<=D(4);
			when "0101" =>
			Y<=D(5);
			when "0110" =>
			Y<=D(6);
			when "0111" =>
			Y<=D(7);
			when "1000" =>
			Y<=P;
			when "1001" =>
			Y<='0';
			when others =>
			Y<='1';
		end case;
	end process;
end simple;