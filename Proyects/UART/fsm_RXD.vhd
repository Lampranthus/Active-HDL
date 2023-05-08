library ieee;
use ieee.std_logic_1164.all;

entity fsm_RXD is

	port(
	
	RST,CLK : in std_logic;	
	
	RXD	: in std_logic;
	bt : in std_logic;
	
	CLR : out std_logic;
	OPC : out std_logic_vector(1 downto 0);
	k : out std_logic_vector(15 downto 0);
	valido : out std_logic
	
	);
end fsm_RXD;

architecture fsm of fsm_RXD is	


signal qp, qn : std_logic_vector(4 downto 0); 

begin  
	
	c1 : process(qp,RXD,bt)
	begin
		
		case(qp) is
		
		--s0--esperando bit de start
		when "00000" =>	
		
		OPC <= "01";  --hold
		CLR <= '1';
		k <= "0001010001010111"; --5207
		valido <= '0';
		
		if(RXD='0') then
			qn <= "00001";
		else
			qn <= "00000";
		end if;
		
		--s1--bit start
		when "00001" =>	
		
		OPC <= "01"; --hold
		CLR <= '0';
		k <= "0001010001010111"; --5207
		valido <= '0';
		
		if(bt='1') then
			qn <= "00010";
		else
			qn <= "00001";
		end if;
		
		--s2--T/2
		when "00010" =>	
		
		OPC <= "01"; --hold
		CLR <= '0';
		k <= "0000101000101100"; --2604
		valido <= '0';
		
		if(bt='1') then
			qn <= "00011";
		else
			qn <= "00010";
		end if;	
		
		--s3--hit and run
		when "00011" =>	
		
		OPC <= "00"; --SHR D(0)
		CLR <= '0';
		k <= "0000101000101100"; --2604
		valido <= '0';
		
		qn <= "00100"; 
		
		--s4--T
		when "00100" =>	
		
		OPC <= "01"; --hold
		CLR <= '0';
		k <= "0001010001010111"; --5207
		valido <= '0';
		
		if(bt='1') then
			qn <= "00101";
		else
			qn <= "00100";
		end if;	
		
		--s5--hit and run
		when "00101" =>	
		
		OPC <= "00"; --SHR D(1)
		CLR <= '0';
		k <= "0001010001010111"; --5207
		valido <= '0';
		
		qn <= "00110";
		
		--s6--T
		when "00110" =>	
		
		OPC <= "01"; --hold
		CLR <= '0';
		k <= "0001010001010111"; --5207
		valido <= '0';
		
		if(bt='1') then
			qn <= "00111";
		else
			qn <= "00110";
		end if;
		
		--s7--hit and run
		when "00111" =>	
		
		OPC <= "00"; --SHR D(2)
		CLR <= '0';
		k <= "0001010001010111"; --5207
		valido <= '0';
		
		qn <= "01000";
		
		--s8--T
		when "01000" =>	
		
		OPC <= "01"; --hold
		CLR <= '0';
		k <= "0001010001010111"; --5207
		valido <= '0';
		
		if(bt='1') then
			qn <= "01001";
		else
			qn <= "01000";
		end if;
		
		--s9--hit and run
		when "01001" =>	
		
		OPC <= "00"; --SHR D(3)
		CLR <= '0';
		k <= "0001010001010111"; --5207
		valido <= '0';
		
		qn <= "01010";
		
		--s10-T
		when "01010" =>	
		
		OPC <= "01"; --hold
		CLR <= '0';
		k <= "0001010001010111"; --5207
		valido <= '0';
		
		if(bt='1') then
			qn <= "01011";
		else
			qn <= "01010";
		end if;
		
		--s11--hit and run
		when "01011" =>	
		
		OPC <= "00"; --SHR D(4)
		CLR <= '0';
		k <= "0001010001010111"; --5207
		valido <= '0';
		
		qn <= "01100";

		--s12-T
		when "01100" =>	
		
		OPC <= "01"; --hold
		CLR <= '0';
		k <= "0001010001010111"; --5207
		valido <= '0';
		
		if(bt='1') then
			qn <= "01101";
		else
			qn <= "01100";
		end if;
		
		--s13--hit and run
		when "01101" =>	
		
		OPC <= "00"; --SHR D(5)
		CLR <= '0';
		k <= "0001010001010111"; --5207
		valido <= '0';
		
		qn <= "01110";

		--s14-T
		when "01110" =>	
		
		OPC <= "01"; --hold
		CLR <= '0';
		k <= "0001010001010111"; --5207
		valido <= '0';
		
		if(bt='1') then
			qn <= "01111";
		else
			qn <= "01110";
		end if;
		
		--s15--hit and run
		when "01111" =>	
		
		OPC <= "00"; --SHR D(6)
		CLR <= '0';
		k <= "0001010001010111"; --5207
		valido <= '0';
		
		qn <= "10000";
		
		--s16-T
		when "10000" =>	
		
		OPC <= "01"; --hold
		CLR <= '0';
		k <= "0001010001010111"; --5207
		valido <= '0';
		
		if(bt='1') then
			qn <= "10001";
		else
			qn <= "10000";
		end if;
		
		--s17--hit and run
		when "10001" =>	
		
		OPC <= "00"; --SHR D(7)
		CLR <= '0';
		k <= "0001010001010111"; --5207
		valido <= '0';
		
		qn <= "10010"; 
		
		--s18-T
		when "10010" =>	
		
		OPC <= "01"; --hold
		CLR <= '0';
		k <= "0001010001010111"; --5207
		valido <= '0';
		
		if(bt='1') then
			qn <= "10011";
		else
			qn <= "10010";
		end if;
		
		--s19--hit and run
		when "10011" =>	
		
		OPC <= "00"; --SHR pr
		CLR <= '0';
		k <= "0001010001010111"; --5207
		valido <= '0';
		
		qn <= "10100";
		
		--s20-T
		when "10100" =>	
		
		OPC <= "01"; --hold
		CLR <= '0';
		k <= "0001010001010111"; --5207
		valido <= '0';
		
		if(bt='1') then
			qn <= "10101";
		else
			qn <= "10100";
		end if;
		
		--s21-T/2 and valido
		when "10101" =>	
		
		OPC <= "01"; --hold
		CLR <= '0';
		k <= "0000101000101100"; --2604
		valido <= '1';
		
		qn <= "10110";

		--s22-T/2
		when others =>	
		
		OPC <= "01"; --hold
		CLR <= '0';
		k <= "0000101000101100"; --2604
		valido <= '0';
		
		if(bt='1') then
			qn <= "00000";
		else
			qn <= "10110";
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
	
end fsm;