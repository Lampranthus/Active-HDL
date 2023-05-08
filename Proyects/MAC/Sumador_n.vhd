library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Sumador_n is
	generic(
	n : integer :=38
	);
	port(
	A,B :	in std_logic_vector(n-1 downto 0);
	--Ci	:	in std_logic;
	S	:	out std_logic_vector(n-1 downto 0)
	--Co	:	out std_logic
	);
end Sumador_n;

architecture aritmetica of Sumador_n is
begin

	process(A,B)
	Variable suma	:	signed(n downto 0);
	begin
		suma := signed('0' & A) + signed('0' & B)+ '0';
		S <= std_logic_vector(suma(n-1 downto 0));
		--Co <= std_logic(suma(n));
	end process;
	
end aritmetica;