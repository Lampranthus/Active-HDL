																  library ieee;
use ieee.std_logic_1164.all;

entity bit_paridad_par is
	port( 
	
	D	:	in	std_logic_vector(7 downto 0);
	pr	:	in std_logic;
	salida	:	out	std_logic 
	
	);
end bit_paridad_par;

architecture generador of bit_paridad_par is

signal s_d76 ,s_d54 ,s_d32 ,s_d10 ,s_d7654 ,s_d3210, pl :	std_logic;

begin

	s_d76	<= D(7) xor D(6);
	s_d54	<= D(5) xor D(4);
	s_d32	<= D(3) xor D(2);
	s_d10	<= D(1) xor D(0);
	s_d7654 <= s_d76 xor s_d54;
	s_d3210 <= s_d32 xor s_d10;
	
	pl	<=	s_d7654 xor s_d3210;
	
	salida <= pl xor pr;
	
	
	
end generador;