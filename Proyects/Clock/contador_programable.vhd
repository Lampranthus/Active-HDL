library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity contador_programable is
	
	generic(
	
	n : integer := 28;
	c : integer := 24999999
	
	);
	
	port(
	
	RST,CLK : in std_logic;
	
	set : in std_logic_vector(n-1 downto 0);
	
	Q : out std_logic_vector(n downto 0);
	
	desb : out std_logic
	
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
			
			when '0' => 
			
			if (qp = "0000") then
			
				qn <= set;
			
			else
				
				qn <= qp+1;
				
			end if;
			
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
	
	Q <= qp;
	desb <= con;
	
end simple;