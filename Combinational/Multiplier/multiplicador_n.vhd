library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity multiplicador_n is
	
	generic(
	n : integer := 36
	);
	
	port(
	A,B : in std_logic_vector(n-1 downto 0);
	M : out std_logic_vector(2*n-1 downto 0)
	);
	
end multiplicador_n;


architecture aritmetica of multiplicador_n is
begin

	process(A,B)
	variable P : signed(2*n-1 downto 0);
	begin
		P := signed(A) * signed(B);
		M <= std_logic_vector(P);
	end process;
	
end aritmetica;
