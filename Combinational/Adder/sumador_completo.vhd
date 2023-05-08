library ieee;
use ieee.std_logic_1164.all;

entity sumador_completo is
	port(
	A	:	in std_logic;
	B	:	in std_logic;
	Ci	:	in std_logic;
	Co	:	out std_logic;
	Y	:	out std_logic
	);
end sumador_completo;

architecture estrucural of sumador_completo is

Signal s_x1, s_a1, s_a2 : std_logic;

begin
	
	s_x1	<=	A xor B;
	Y		<=	s_x1 xor ci;
	s_a1	<=	s_x1 and ci;
	s_a2	<=	a and b;
	Co		<=	s_a1 or s_a2;
	
end estrucural;
