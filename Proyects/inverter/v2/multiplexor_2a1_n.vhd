library ieee;
use ieee.std_logic_1164.all;


entity multiplexor_2a1_n is	 
	generic(
	n	: integer := 2
	);
	port(
	A,B		: in std_logic_vector(n-1 downto 0);
	S		: in std_logic;
	Y		: out std_logic_vector(n-1 downto 0)
	);
	end multiplexor_2a1_n;
	
	architecture simple of multiplexor_2a1_n is
	begin
		mux: process(S,A,B)
		begin
		if (S='0') then
			Y<=A;
		else
			Y<=B;
		end if;
		end process;
	end simple;