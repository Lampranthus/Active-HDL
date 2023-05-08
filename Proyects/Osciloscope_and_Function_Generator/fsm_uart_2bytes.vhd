library ieee;
use ieee.std_logic_1164.all;

entity fsm_uart_2bytes is
	port(
	
	RST,CLK : in std_logic;	
	
	start	: out std_logic;
	fin 	: in std_logic;
	
	op		: out std_logic_vector(1 downto 0);
	
	mux 	: out std_logic
	
	);
end fsm_uart_2bytes;

architecture fsm of fsm_uart_2bytes is	


signal qp, qn : std_logic_vector(3 downto 0); 

begin  
	
	c1 : process(qp,fin)
	begin
		
		case(qp) is
		
		--s0
		when "0000" =>	
		
		start <= '0';
		
		mux <= '0';
		
		op <= "00";
		
		
		qn <= "0001";
		
		
		--s1
		when "0001" =>	
		
		start <= '1';
		
		mux <= '0';
		
		op <= "01";

		if(fin='1') then
			qn <= "0010";
		else
			qn <= qp;
		end if;
		
		
		--s2
		when "0010" =>	
		
		start <= '0';
		
		mux <= '1';
		
		op <= "01";
		
		
		qn <= "0011";
		
		
		--s3
		when others =>	
		
		start <= '1';
		
		mux <= '1';
		
		op <= "01";

		if(fin='1') then
			qn <= "0000";
		else
			qn <= qp;
		end if;
		

		
		end case;
		
	end process;
	
	secuencial : process(RST,CLK)
	begin
		if(RST='0') then
			qp <= "0000";
		elsif(CLK'event and CLK='1') then
			qp <= qn;
		end if;
	end process;
	
end fsm;