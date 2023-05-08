library ieee;
use ieee.std_logic_1164.all;

entity fsm_MAC_4 is
	port(
	
	RST,CLK : in std_logic;
	fs : in std_logic;
	REG,RAC,RR : out std_logic_vector(1 downto 0);
	MUX,LUT : out std_logic_vector(2 downto 0);
	EOP : out std_logic
	
	);
end fsm_MAC_4;

architecture fsm of fsm_MAC_4 is	


signal qp, qn : std_logic_vector(3 downto 0); 

begin  
	
	c1 : process(qp,fs)
	begin
		
		case(qp) is
		
		--s0
		when "0000" =>
		
		REG <= "01";	--hold
		RAC <= "11";	--borra
		RR	<= "01";	--hold
		
		MUX <= "000";	--0
		LUT <= "000";	--0
		
		EOP <= '1';		--no fin
		
		if(fs='1') then
			qn <= "0001";
		else
			qn <= qp;
		end if;
		
		
		--s1--op0
		when "0001" => 
		
		REG <= "01";	--hold
		RAC <= "00";	--guarda
		RR	<= "01";	--hold
		
		MUX <= "000";	--0
		LUT <= "000";	--0
		
		EOP <= '0';		--no fin
		
		qn <= "0010";
		
		--s2--op1
		when "0010" => 
		
		REG <= "01";	--hold
		RAC <= "00";	--guarda
		RR	<= "01";	--hold
		
		MUX <= "001";	--1
		LUT <= "001";	--1
		
		EOP <= '0';		--no fin
		
		qn <= "0011";
		
		--s3--op2
		when "0011" => 
		
		REG <= "01";	--hold
		RAC <= "00";	--guarda
		RR	<= "01";	--hold
		
		MUX <= "010";	--2
		LUT <= "010";	--2
		
		EOP <= '0';		--no fin
		
		qn <= "0100";
		
		--s4--op3
		when "0100" => 
		
		REG <= "01";	--hold
		RAC <= "00";	--guarda
		RR	<= "01";	--hold
		
		MUX <= "011";	--3
		LUT <= "011";	--3
		
		EOP <= '0';		--no fin
		
		qn <= "0101";
		
		--s5--op4
		when "0101" => 
		
		REG <= "01";	--hold
		RAC <= "00";	--guarda
		RR	<= "01";	--hold
		
		MUX <= "100";	--4
		LUT <= "100";	--4
		
		EOP <= '0';		--no fin
		
		qn <= "0110";
		
		--s6--resultado
		when others => 
		
		REG <= "00";	--guarda
		RAC <= "01";	--hold
		RR	<= "00";	--guarda
		
		MUX <= "000";	--4
		LUT <= "000";	--4
		
		EOP <= '0';		--fin
		
		qn <= "0000";	--loop
		
		
		
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