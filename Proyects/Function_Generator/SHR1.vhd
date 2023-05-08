library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity SHR1 is 
	
	generic( 
	
	N : integer := 9
	
	);
	
	port(
	
	RST,CLK, R: in std_logic;
	OPR : in std_logic_vector(1 downto 0);
	Q : out std_logic_vector(N-2 downto 0);
	pr : out std_logic
	
	); 
	
end SHR1;


architecture simple of SHR1 is
signal qp, qn : std_logic_vector(N-1 downto 0);
begin
	
	c1 : process(qp,R,OPR) 
	begin
		if(OPR = "00") then
			qn <= R&qp(N-1 downto 1);
			
		elsif(OPR = "01") then
			 qn <= qp;
		else   
			qn <= (others => '0');
		end if;
	end process;
	
	Q <= Qp(n-2 downto 0);
	pr <= Qp(n-1);
	
	secuencial : process(RST,CLK)
	begin
		if(RST='0') then
			
			qp <= (others => '0');
			
		elsif(CLK'event and CLK='1') then
			
			qp <= qn;	
			
		end if;
	end process;
	
end simple;