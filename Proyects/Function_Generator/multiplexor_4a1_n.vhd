library ieee;
use ieee.std_logic_1164.all;


entity multiplexor_4a1_n is	 
	generic(
	n	: integer := 12
	);
	port(
	A,B,C,D		: in std_logic_vector(n-1 downto 0);
	S		: in std_logic_vector(1 downto 0);
	Y		: out std_logic_vector(n-1 downto 0)
	);
	end multiplexor_4a1_n;
	
	architecture simple of multiplexor_4a1_n is
	begin
		mux: process(S,A,B,C,D)
		begin
		if (S="00") then
			Y<=A;
		elsif (S="01") then
			Y<=B;
		elsif (S="10") then
			Y<=C;
		else
			Y<=D;
		end if;
		end process;
	end simple;