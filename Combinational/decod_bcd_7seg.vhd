library ieee;
use ieee.std_logic_1164.all;

entity decod_bcd_7seg is

port(
	bcd	: in		std_logic_vector (3 downto 0);
	y	: out		std_logic_vector (6 downto 0)
							   
);

end decod_bcd_7seg;

-- look up table
architecture lut of decod_bcd_7seg is
begin
	lut	:	process (bcd)
	begin
		
		case bcd is
			
			when "0000" => 
			
			y		<=	"0000001";
			
			when "0001" => 
			
			y		<=	"1001111";
			
			when "0010" => 
			
			y		<=	"0010010";
			
			when "0011" => 
			
			y		<=	"0000110";
			
			when "0100" => 
			
			y		<=	"1001100";
			
			when "0101" => 
			
			y		<=	"0100100";
			
			when "0110" => 
			
			y		<=	"0100000";
			
			when "0111" => 
			
			y		<=	"0001111";
			
			when "1000" => 
			
			y		<=	"0000000";
			
			when "1001" => 
			
			y		<=	"0001100";
			
			when "1010" => 
			
			y		<=	"0001000";
			
			when "1011" => 
			
			y		<=	"1100000";
			
			when "1100" => 
			
			y		<=	"0110001";
			
			when "1101" => 
			
			y		<=	"1000010";
			
			when "1110" => 
			
			y		<=	"0110000";
			
			when others => 
			
			 y		<=	"0111000";
			
			end case;
		
	end process;
end lut;