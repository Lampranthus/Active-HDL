library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity restador_n is
	generic(
	n	:	integer	:= 4
	);
	
	port(
	A,B	:	in	std_logic_vector(n-1 downto 0);
	R	:	out std_logic_vector(n-1 downto 0)
	);
end restador_n;
	
architecture aritmetica of restador_n is
begin
	
	process(A,B)
	Variable resta	:	unsigned(n downto 0);
	begin
		resta := unsigned('0' & A) - unsigned('0' & B);
		R <= std_logic_vector(resta(n-1 downto 0));
	end process;
	
	
end aritmetica;