library ieee;
use ieee.std_logic_1164.all;
																											
entity demux_1a4_n is
generic(
  n: integer := 4
);
port(
x				: in		std_logic_vector(n-1 downto 0);
s				: in		std_logic_vector(1 downto 0);
y0,y1,y2,y3		: out		std_logic_vector(n-1 downto 0)
);
																												
end demux_1a4_n;
																											
architecture simple of demux_1a4_n is
begin
demux	:	process (s,x)
begin
case s is
	
	when "00" =>
	
	y0		<=	x;
	y1		<=	(others => '0');
	y2		<=	(others => '0');
	y3		<=	(others => '0');
	
	when "01" =>
	
	y0		<=	(others => '0');
	y1		<=	x;
	y2		<=	(others => '0');
	y3		<=	(others => '0');
	
	when "10" =>
	
	y0		<=	(others => '0');
	y1		<=	(others => '0');
	y2		<=	x;
	y3		<=	(others => '0');
	
	when others =>
	
	y0		<=	(others => '0');
	y1		<=	(others => '0');
	y2		<=	(others => '0');
	y3		<=	x;
	
	end case;

end process;
																										
end simple;