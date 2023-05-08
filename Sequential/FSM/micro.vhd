library ieee;
use ieee.std_logic_1164.all;

entity micro is
	port(
	star, EOC,RST,CLK: in std_logic;
	y: out std_logic;
	OPC: out std_logic_vector(1 downto 0)
	);
end micro;
	
architecture arqui of micro is
signal Qp,Qn: std_logic;
begin

	c1: process(star,EOC,Qp)
	begin
		if(star='0')then
			opc <= "11";
			Qn <= '0';
		elsif(EOC='0')then
			opc <= "00";
			Qn <= '1';
		end if;
	end process;

	secuencial: process(RST,CLK)
	begin
		if(RST='0')then
			Qp <= '0';
		elsif(CLK'event and CLK='1')then
			Qp <= Qn;
		end if;
	end process;
	
	y <= Qp;
	
end arqui;