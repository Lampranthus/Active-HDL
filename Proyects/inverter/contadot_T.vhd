library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity contador_T is
	
	generic(
	
	n :	integer := 6;
	c : integer := 49
	
	);
	
	port(
	
	RST,CLK : in std_logic;
	
	CLR : in std_logic;
	
	BT : out std_logic
	
	);
	
end contador_T; 


architecture secuencial of contador_T is

signal qp, qn : std_logic_vector(n-1 downto 0);

begin
	
	c1 : process (CLR,qp)
	begin
		
	if (CLR='0') then
		
	if(qp=c) then
		
		qn <= (others => '0');
		BT <= '1';
		
	else
		
		qn <= qp + 1;
		BT <= '0';
		
	end if;
	
	else 
		
		qn <= (others => '0');
		BT <= '0';
	
	end if;
	
	end process;
	
	
	secuencial : process (RST,CLK)
	begin
		
	if(RST = '0') then
		
		qp <= (others => '0');
		
	elsif(CLK'event and CLK='1') then
		qp <= qn;
	end if;
	end process;
end secuencial;
		