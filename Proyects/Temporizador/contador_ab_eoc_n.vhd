library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity contador_ab_eoc_n is
	generic(
	n : integer :=28;
	c : integer := 149
	);
	port(
		RST,CLK : in std_logic;
		opc : in std_logic_vector(1 downto 0);
		Q : out std_logic_vector(n-1 downto 0);
		EOC : out std_logic
	);
end contador_ab_eoc_n;

architecture simple of contador_ab_eoc_n is  

signal qp,qn : std_logic_vector(n-1 downto 0);

begin 
	
	c1 : process (qp,opc)  --contador ab
	begin
		case (opc) is
			when "00" => 
		
			qn <= qp + 1;
		
			
			when others => 
			qn <= (others => '0');
			
		end case;
	end process;
	
	c2 : process(qp)  --comparador/eoc
	begin
		
		if(qp=c) then
			EOC <= '1';
		else
			EOC <= '0';
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
	
	    Q <= qp(n-1 downto 0);
	
end simple;