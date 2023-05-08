library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity contador_programable is
	
	generic(
	
	n : integer := 8;
	l : integer := 4;
	c : integer := 149
	
	);
	
	port(
	
	RST,CLK : in std_logic; 
	
	Q : out std_logic_vector(n-1 downto n-l)	
	
	);
	
end contador_programable;


architecture simple of contador_programable is

signal qn, qp : std_logic_vector(n-1 downto 0);
signal con : std_logic;

begin
	
	c1 : process(con, qp)
	begin 
		
		if (qp < c) then
		
			con <= '0';
		
		else 
			
			con <= '1';
			
		end if;
		
		case (con) is
			
			when '0' => qn <= qp+1;
			when others => qn <= (others => '0');
			
		end case;
		
	end process;

	secuencial : process (RST, CLK)
	begin
		
		if(RST='0') then
			
			qp <= (others => '0');
			
		elsif(CLK'event and CLK='1') then
			
			qp <= qn;	
			
		end if;
		
	end process;	
	
	Q <= qp(n-1 downto n-4);
	
end simple;