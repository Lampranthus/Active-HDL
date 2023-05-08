library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity registro_paralelo_rr is
	
	generic(
	
	n : integer := 12
	
	);
	
	port(
	
	Din : in std_logic_vector(n-1 downto 0);   
	
	OPR : in std_logic_vector(1 downto 0);
	
	RST,CLK : in std_logic; 
	
	Qout : out std_logic_vector(n-1 downto 0)	
	
	);
	
end registro_paralelo_rr;


architecture simple of registro_paralelo_rr is

signal qn, qp : std_logic_vector(n-1 downto 0);

begin
	
	c1 : process(OPR, qp, Din)
	begin 
		
		case (OPR) is
			
			when "01" => qn <= qp;	 				--1 mantiene
			when "00" => qn <= Din;				 	--0 guarda
			when others => qn <= (others => '0');	--2,3 borra
			
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
	
	Qout <= qp(n-1 downto 0);
	
end simple;