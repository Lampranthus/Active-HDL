library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity contador_adhb_n is
	generic(
		n : integer :=28
	);
	port(
		RST,CLK : in std_logic;
		opc : in std_logic_vector(1 downto 0);
		Q : out std_logic_vector(n-1 downto n-4)
	);
end contador_adhb_n;

architecture simple of contador_adhb_n is	  
signal qp,qn : std_logic_vector(n-1 downto 0);
begin 
	
	c1 : process (qp,opc)
	begin
		case (opc) is
			when "00" => qn <= qp + 1;
			when "01" => qn <= qp - 1;
			when "10" => qn <= qp;
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