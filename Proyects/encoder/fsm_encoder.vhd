library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity fsm_encoder	is 
	
	generic(
		n : integer :=12
	);
	
	port(
	
	RST, CLK : in std_logic;
	
	sup : in std_logic_vector(n-1 downto 0);
	inf : in std_logic_vector(n-1 downto 0);
	
	s1 : in std_logic;
	s2 : in std_logic; 
	Q : in std_logic_vector(n-1 downto 0);
	opc : out std_logic_vector(1 downto 0)
	
	);
	
end fsm_encoder;

architecture simple of fsm_encoder is
signal qp,qn : std_logic_vector(2 downto 0);
begin  
	
	c1 : process(qp,Q,s1,s2)
	begin 
		
		case (qp) is  
			
			--s0
		
			when "000" => 
			opc <= "10";	 --hold
			
			if(s1='1' and s2='1' and (Q <= sup) and (Q >= inf)) then
				qn <= "001";
			else
				qn <= "000";
				
			end if;	
			
			--s1
		
			when "001" => 
			opc <= "10";	 --hold
			
			if(s1='0' and s2='1'and (Q /= sup)) then
				qn <= "010";
			elsif (s1='1' and s2='0'and (Q /= inf)) then
				qn <= "100"; 
			elsif (s1='0' and s2='0') then
				qn <= "000";   
			else
				qn <= "001";   
				
			end if;	
			
			--s2
			
			when "010" =>
			
			opc <= "00";	 --asc
			
			qn <= "011";
			
			--s3
			
			when "011" =>
			
			opc <= "10";	 --hold
			
			if(s1='0' and s2='0') then
				qn <= "000"; 
			else
				qn <= "011";
				
			end if;	
			
			--s4
			
			when "100" =>
			
			opc <= "01";	 --desc
			
			qn <= "101"; 
			
			--s5
			
			when others =>
			
			opc <= "10";	 --hold
			
			if(s1='0' and s2='0') then
				qn <= "000"; 
			else
				qn <= "101";
				
			end if;
		
		end case;

	end process;	
	
	secuencial : process(RST,CLK)
	begin
		if(RST='0') then
			qp <= (others => '0');
		elsif(CLK'event and CLK='1') then
			qp <= qn;
		end if;
	end process;	
	
end simple;