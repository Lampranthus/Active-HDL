library ieee;
use ieee.std_logic_1164.all;


entity mux_4a1_1 is
	port(
		BITSCLK	:	in	std_logic;
		S		: 	in 	std_logic_vector(1 downto 0);
		SCLK		: 	out std_logic
	);
end mux_4a1_1;


architecture simple of mux_4a1_1 is
begin
	mux:process(S,BITSCLK)
	begin
		case S is
			when "00" =>
			SCLK <= BITSCLK;
			when "01" =>
			SCLK <= not BITSCLK;
			when "10" =>
			SCLK <= '0';  
			when others =>
			SCLK <= '1';
		end case;
	end process;
end simple;