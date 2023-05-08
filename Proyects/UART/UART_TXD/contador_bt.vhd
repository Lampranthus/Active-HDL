library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity contador_bt is
	
	generic(
	
	n :	integer := 16;
	k : integer := 5208
	
	);
	
	port(
	
	RST,CLK : in std_logic;
	
	CLR : in std_logic;
	
	BT : out std_logic
	
	);
	
end contador_bt; 


architecture secuencial of contador_bt is

signal qp, qn : std_logic_vector(n-1 downto 0);

begin
	
	c1 : process (CLR,qp)
	begin
		
		
	if (CLR='0') then
		
	if(qp=k-1) then
		
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