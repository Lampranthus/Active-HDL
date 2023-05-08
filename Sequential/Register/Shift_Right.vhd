library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Shift_Right is 
	
	generic( 
	
	N : integer := 8
	
	);
	
	port(
	
	RST,CLK, R: in std_logic;
	OPR : in std_logic_vector(1 downto 0);
	Q : out std_logic_vector(N-1 downto 0)
	
	); 
	
end Shift_Right;


architecture simple of Shift_Right is
signal qp, qn : std_logic_vector(N-1 downto 0);
begin
	
	c1 : process(qn,R,OPR) 
	begin
		if(OPR = "00") then
			qn <= R&qp(N-1 downto 1);
			
		elsif(OPR = "01") then
			 qn <= qp;
		else   
			qn <= (others => '0');
		end if;
	end process;
	
	Q <= Qp;
	
	secuencial : process(RST,CLK)
	begin
		if(RST='0') then
			
			qp <= (others => '0');
			
		elsif(CLK'event and CLK='1') then
			
			qp <= qn;	
			
		end if;
	end process;
	
end simple;