library ieee;
use ieee.std_logic_1164.all;

entity fsm_TXD is
	port(
	
	RST,CLK : in std_logic;	
	
	start	: in std_logic;
	bt	: in std_logic;	
	
	CLR : out std_logic;
	OPC : out std_logic_vector(3 downto 0);
	fin : out std_logic
	
	);
end fsm_TXD;

architecture fsm of fsm_TXD is	


signal qp, qn : std_logic_vector(3 downto 0); 

begin  
	
	c1 : process(qp,start,bt)
	begin
		
		case(qp) is
		
		--s0
		when "0000" =>	
		
		OPC <= "1111";  --canal libre
		CLR <= '1';
		fin <= '1';
		
		if(start='1') then
			qn <= "0001";
		else
			qn <= "0000";
		end if;
		
		--s1
		when "0001" =>	
		
		OPC <= "1001"; --START
		CLR <= '0';
		fin <= '0';
		
		if(bt='1') then
			qn <= "0010";
		else
			qn <= "0001";
		end if;
		
		--s2
		when "0010" =>	
		
		OPC <= "0000"; --D(0)
		CLR <= '0';
		fin <= '0';
		
		if(bt='1') then
			qn <= "0011";
		else
			qn <= "0010";
		end if;	
		
		--s3
		when "0011" =>	
		
		OPC <= "0001"; --D(1)
		CLR <= '0';
		fin <= '0';
		
		if(bt='1') then
			qn <= "0100";
		else
			qn <= "0011";
		end if;
		
		--s4
		when "0100" =>	
		
		OPC <= "0010"; --D(2)
		CLR <= '0';
		fin <= '0';
		
		if(bt='1') then
			qn <= "0101";
		else
			qn <= "0100";
		end if;	
		
		--s5
		when "0101" =>	
		
		OPC <= "0011"; --D(3)
		CLR <= '0';
		fin <= '0';
		
		if(bt='1') then
			qn <= "0110";
		else
			qn <= "0101";
		end if;
		
		--s6
		when "0110" =>	
		
		OPC <= "0100"; --D(4)
		CLR <= '0';
		fin <= '0';
		
		if(bt='1') then
			qn <= "0111";
		else
			qn <= "0110";
		end if;
		
		--s7
		when "0111" =>	
		
		OPC <= "0101"; --D(5)
		CLR <= '0';
		fin <= '0';
		
		if(bt='1') then
			qn <= "1000";
		else
			qn <= "0111";
		end if;
		
		--s8
		when "1000" =>	
		
		OPC <= "0110"; --D(6)
		CLR <= '0';
		fin <= '0';
		
		if(bt='1') then
			qn <= "1001";
		else
			qn <= "1000";
		end if;
		
		--s9
		when "1001" =>	
		
		OPC <= "0111"; --D(7)
		CLR <= '0';
		fin <= '0';
		
		if(bt='1') then
			qn <= "1010";
		else
			qn <= "1001";
		end if;
		
		--s10
		when "1010" =>	
		
		OPC <= "1000"; --P
		CLR <= '0';
		fin <= '0';
		
		if(bt='1') then
			qn <= "1011";
		else
			qn <= "1010";
		end if;
		
		--s11
		when others =>	
		
		OPC <= "1111"; --STOP
		CLR <= '0';
		fin <= '0';
		
		if(bt='1') then
			qn <= "0000";
		else
			qn <= "1111";
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