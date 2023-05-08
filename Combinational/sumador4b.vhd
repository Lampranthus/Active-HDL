library ieee;
use ieee.std_logic_1164.all;

entity sumador4b is
port(
	A, B	:	in	std_logic_vector(3 downto 0);
	Ci		:	in std_logic;
	Y		:	out std_logic_vector((3+1) downto 0);
	Co		:	out std_logic
	);
end sumador4b;

architecture jerarquico	of sumador4b is

signal Co0, Co1, Co2, msb	:	std_logic;

component sumador_completo is
	port(
	A	:	in std_logic;
	B	:	in std_logic;
	Ci	:	in std_logic;
	Co	:	out std_logic; --Solo como referencia, ya que se usa Y(4) como salida del ultimo bit de acarreo con el fin de tener una simulacion mas comprensible
	Y	:	out std_logic
	);
end component;

begin

	sc0	:	sumador_completo port map(A(0),B(0),Ci,Co0,Y(0));
	sc1	:	sumador_completo port map(A(1),B(1),Co0,Co1,Y(1));
	sc2	:	sumador_completo port map(A(2),B(2),Co1,Co2,Y(2));
	sc3	:	sumador_completo port map(A(3),B(3),Co2,Y(4),Y(3));
	
end jerarquico;
	