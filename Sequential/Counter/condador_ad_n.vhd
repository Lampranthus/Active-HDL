library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity condador_ad_n is
	generic(
		n : integer :=4
	);
	port(
		RST,CLK,x0 : in std_logic;
		Q : out std_logic_vector(n-1 downto 0)
	);
end condador_ad_n;

architecture simple of condador_ad_n is	  
signal qp,qn : std_logic_vector(n-1 downto 0);
begin 
	
	c1 : process (qp,x0)
	begin
		if(x0='0') then
			qn <= qp + 1;
		else
			qn <= qp - 1;
		end if;
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
	
end simple;