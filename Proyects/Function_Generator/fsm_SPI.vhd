library ieee;
use ieee.std_logic_1164.all;

entity fsm_SPI is

	port(
	
	RST,CLK : in std_logic;	
	
	c 		: in std_logic_vector(11 downto 0);
	
	start 	: 	in std_logic;
	fin 	: 	out std_logic; -- out 1
	valido 	: 	out std_logic; -- out 2
	CPOL 	: 	in std_logic;
	CPHA 	: 	in std_logic;
	
	CS 		: 	out std_logic; -- out 3
	
	OP		:	out std_logic_vector(1 downto 0); -- out 4
	
	SELECT1	:	out std_logic_vector(3 downto 0); -- out 5
	SELECT2	:	out std_logic_vector(1 downto 0); -- out 6
	
	CLR		:	out std_logic; -- out 7
	K		:	out std_logic_vector(11 downto 0); -- out 8
	BT		:	in	std_logic
	
	);
end fsm_SPI;

architecture fsm of fsm_SPI is	


signal qp, qn : std_logic_vector(5 downto 0); 

begin  
	
	c1 : process(qp,CPOL,CPHA,BT,start)
	begin
		
		case(qp) is
		
		--s0--estado de reposo-- esperando start----------------------------------------------------------------------
		when "000000" =>	
		
		fin <= '1'; 			--out 1	--no fin
		valido <= '0'; 			--out 2 --no valido
		CS <= '1';				--out 3 --chip no select
		OP <= "01";  			--out 4 --hold
		SELECT1 <= "1000";		--out 5 --MOSI='0'
		if(CPOL = '0') then
			SELECT2 <= "00";	--out 6 --SCLK='0'
		else
			SELECT2 <= "01";	--out 6 --SCLK='1'
		end if;
		
		CLR <= '1';				--out 7 --no cuenta
		K <= c;					--out 8 --24 -- sclk 1MHz 
		
		if(start='1' and CPHA='1') then		--start and phase 1
			qn <= "111111";	    --estado 1.1 phase
		elsif(start='1' and CPHA='0') then
			qn <= "000001";		--estado 1
		else
			qn <= "000000";		--se mantiene
		end if;
		
		--sd----bt-phase 1-----------------------------------------------------------------------------------------
		when "111111" =>	
		
		fin <= '0'; 			--out 1	--no fin
		valido <= '0'; 			--out 2 --no valido
		CS <= '0';				--out 3 --chip select
		OP <= "01";  			--out 4 --hold
		SELECT1 <= "1000";		--out 5 --MOSI='D0'
		if(CPOL = '0') then
			SELECT2 <= "00";	--out 6 --SCLK='bitsclk'
		else
			SELECT2 <= "01";	--out 6 --SCLK='~bitsclk'
		end if;
		
		CLR <= '0';				--out 7 --cuenta

		K <= c;					--out 8 --24 -- sclk 1MHz
		
		if(BT='1') then			--BT
			qn <= "000001";	    --siguiente estado
		else
			qn <= "111111";		--se mantiene
		end if;
		
		--s1--inicio--bt-----------------------------------------------------------------------------------------
		when "000001" =>	
		
		fin <= '0'; 			--out 1	--no fin
		valido <= '0'; 			--out 2 --no valido
		CS <= '0';				--out 3 --chip select
		OP <= "01";  			--out 4 --hold
		SELECT1 <= "0000";		--out 5 --MOSI='D0'
		if(CPOL = '0') then
			SELECT2 <= "00";	--out 6 --SCLK='bitsclk'
		else
			SELECT2 <= "01";	--out 6 --SCLK='~bitsclk'
		end if;
		
		CLR <= '0';				--out 7 --cuenta

		K <= c;	--out 8 --24 -- sclk 1MHz
		
		if(BT='1') then			--BT
			qn <= "000010";	    --siguiente estado
		else
			qn <= "000001";		--se mantiene
		end if;
		
		--s2--hit and run-----------------------------------------------------------------------------------------
		when "000010" =>	
		
		fin <= '0'; 			--out 1	--no fin
		valido <= '0'; 			--out 2 --no valido
		CS <= '0';				--out 3 --chip select
		OP <= "00";  			--out 4 --SHR MISO D0
		SELECT1 <= "0000";		--out 5 --MOSI='D0'
		if(CPOL = '0') then
			SELECT2 <= "00";	--out 6 --SCLK='bitsclk'
		else
			SELECT2 <= "01";	--out 6 --SCLK='~bitsclk'
		end if;
		
		CLR <= '0';				--out 7 -- no cuenta 
		
		K <= c;		--out 8 --24 -- sclk 1MHz
		

		qn <= "000011";	    	-- hit and run --siguiente estado

		
		--s3--bt-----------------------------------------------------------------------------------------
		when "000011" =>	
		
		fin <= '0'; 			--out 1	--no fin
		valido <= '0'; 			--out 2 --no valido
		CS <= '0';				--out 3 --chip select
		OP <= "01";  			--out 4 --hold
		SELECT1 <= "0000";		--out 5 --MOSI='D0'
		if(CPOL = '0') then
			SELECT2 <= "00";	--out 6 --SCLK='bitsclk'
		else
			SELECT2 <= "01";	--out 6 --SCLK='~bitsclk'
		end if;
		
		CLR <= '0';				--out 7 --cuenta

		K <= c;		--out 8 --24 -- sclk 1MHz
		
		if(BT='1') then			--BT
			qn <= "000100";	    --siguiente estado
		else
			qn <= "000011";		--se mantiene
		end if;
		
		--s4--bt-----------------------------------------------------------------------------------------
		when "000100" =>	
		
		fin <= '0'; 			--out 1	--no fin
		valido <= '0'; 			--out 2 --no valido
		CS <= '0';				--out 3 --chip select
		OP <= "01";  			--out 4 --hold
		SELECT1 <= "0001";		--out 5 --MOSI='D1'
		if(CPOL = '0') then
			SELECT2 <= "00";	--out 6 --SCLK='bitsclk'
		else
			SELECT2 <= "01";	--out 6 --SCLK='~bitsclk'
		end if;
		
		CLR <= '0';				--out 7 -- cuenta 
		
		K <= c;		--out 8 --24 -- sclk 1MHz
		

		if(BT='1') then			--BT
			qn <= "000101";	    --siguiente estado
		else
			qn <= "000100";		--se mantiene
		end if;
		
		--s5--hit and run-----------------------------------------------------------------------------------------
		when "000101" =>	
		
		fin <= '0'; 			--out 1	--no fin
		valido <= '0'; 			--out 2 --no valido
		CS <= '0';				--out 3 --chip select
		OP <= "00";  			--out 4 --SHR MISO D1
		SELECT1 <= "0001";		--out 5 --MOSI='D1'
		if(CPOL = '0') then
			SELECT2 <= "00";	--out 6 --SCLK='bitsclk'
		else
			SELECT2 <= "01";	--out 6 --SCLK='~bitsclk'
		end if;
		
		CLR <= '0';				--out 7 --no cuenta

		K <= c;		--out 8 --24 -- sclk 1MHz

		qn <= "000110";		--hit and run -- siguiente estado
		
		--s6--bt-----------------------------------------------------------------------------------------
		when "000110" =>	
		
		fin <= '0'; 			--out 1	--no fin
		valido <= '0'; 			--out 2 --no valido
		CS <= '0';				--out 3 --chip select
		OP <= "01";  			--out 4 --hold
		SELECT1 <= "0001";		--out 5 --MOSI='D1'
		if(CPOL = '0') then
			SELECT2 <= "00";	--out 6 --SCLK='bitsclk'
		else
			SELECT2 <= "01";	--out 6 --SCLK='~bitsclk'
		end if;
		
		CLR <= '0';				--out 7 -- cuenta 
		
		K <= c;		--out 8 --24 -- sclk 1MHz
		

		if(BT='1') then			--BT
			qn <= "000111";	    --siguiente estado
		else
			qn <= "000110";		--se mantiene
		end if;
		
		
		--s7--bt-----------------------------------------------------------------------------------------
		when "000111" =>	
		
		fin <= '0'; 			--out 1	--no fin
		valido <= '0'; 			--out 2 --no valido
		CS <= '0';				--out 3 --chip select
		OP <= "01";  			--out 4 --hold
		SELECT1 <= "0010";		--out 5 --MOSI='D2'
		if(CPOL = '0') then
			SELECT2 <= "00";	--out 6 --SCLK='bitsclk'
		else
			SELECT2 <= "01";	--out 6 --SCLK='~bitsclk'
		end if;
		
		CLR <= '0';				--out 7 -- cuenta 
		
		K <= c;		--out 8 --24 -- sclk 1MHz
		

		if(BT='1') then			--BT
			qn <= "001000";	    --siguiente estado
		else
			qn <= "000111";		--se mantiene
		end if;
		
		--s8--hit and run-----------------------------------------------------------------------------------------
		when "001000" =>	
		
		fin <= '0'; 			--out 1	--no fin
		valido <= '0'; 			--out 2 --no valido
		CS <= '0';				--out 3 --chip select
		OP <= "00";  			--out 4 --SHR MISO D2
		SELECT1 <= "0010";		--out 5 --MOSI='D2'
		if(CPOL = '0') then
			SELECT2 <= "00";	--out 6 --SCLK='bitsclk'
		else
			SELECT2 <= "01";	--out 6 --SCLK='~bitsclk'
		end if;
		
		CLR <= '0';				--out 7 --no cuenta

		K <= c;		--out 8 --24 -- sclk 1MHz

		qn <= "001001";		--hit and run -- siguiente estado
		
		--s9--bt-----------------------------------------------------------------------------------------
		when "001001" =>	
		
		fin <= '0'; 			--out 1	--no fin
		valido <= '0'; 			--out 2 --no valido
		CS <= '0';				--out 3 --chip select
		OP <= "01";  			--out 4 --hold
		SELECT1 <= "0010";		--out 5 --MOSI='D2'
		if(CPOL = '0') then
			SELECT2 <= "00";	--out 6 --SCLK='bitsclk'
		else
			SELECT2 <= "01";	--out 6 --SCLK='~bitsclk'
		end if;
		
		CLR <= '0';				--out 7 -- cuenta 
		
		K <= c;		--out 8 --24 -- sclk 1MHz
		

		if(BT='1') then			--BT
			qn <= "001010";	    --siguiente estado
		else
			qn <= "001001";		--se mantiene
		end if;
		
		--s10--bt-----------------------------------------------------------------------------------------
		when "001010" =>	
		
		fin <= '0'; 			--out 1	--no fin
		valido <= '0'; 			--out 2 --no valido
		CS <= '0';				--out 3 --chip select
		OP <= "01";  			--out 4 --hold
		SELECT1 <= "0011";		--out 5 --MOSI='D3'
		if(CPOL = '0') then
			SELECT2 <= "00";	--out 6 --SCLK='bitsclk'
		else
			SELECT2 <= "01";	--out 6 --SCLK='~bitsclk'
		end if;
		
		CLR <= '0';				--out 7 -- cuenta 
		
		K <= c;		--out 8 --24 -- sclk 1MHz
		

		if(BT='1') then			--BT
			qn <= "001011";	    --siguiente estado
		else
			qn <= "001010";		--se mantiene
		end if;
		
		--s11--hit and run-----------------------------------------------------------------------------------------
		when "001011" =>	
		
		fin <= '0'; 			--out 1	--no fin
		valido <= '0'; 			--out 2 --no valido
		CS <= '0';				--out 3 --chip select
		OP <= "00";  			--out 4 --SHR MISO D3
		SELECT1 <= "0011";		--out 5 --MOSI='D3'
		if(CPOL = '0') then
			SELECT2 <= "00";	--out 6 --SCLK='bitsclk'
		else
			SELECT2 <= "01";	--out 6 --SCLK='~bitsclk'
		end if;
		
		CLR <= '0';				--out 7 --no cuenta

		K <= c;		--out 8 --24 -- sclk 1MHz

		qn <= "001100";		--hit and run -- siguiente estado
		
		--s12--bt-----------------------------------------------------------------------------------------
		when "001100" =>	
		
		fin <= '0'; 			--out 1	--no fin
		valido <= '0'; 			--out 2 --no valido
		CS <= '0';				--out 3 --chip select
		OP <= "01";  			--out 4 --hold
		SELECT1 <= "0011";		--out 5 --MOSI='D3'
		if(CPOL = '0') then
			SELECT2 <= "00";	--out 6 --SCLK='bitsclk'
		else
			SELECT2 <= "01";	--out 6 --SCLK='~bitsclk'
		end if;
		
		CLR <= '0';				--out 7 -- cuenta 
		
		K <= c;		--out 8 --24 -- sclk 1MHz
		

		if(BT='1') then			--BT
			qn <= "001101";	    --siguiente estado
		else
			qn <= "001100";		--se mantiene
		end if;
		
		--s13--bt-----------------------------------------------------------------------------------------
		when "001101" =>	
		
		fin <= '0'; 			--out 1	--no fin
		valido <= '0'; 			--out 2 --no valido
		CS <= '0';				--out 3 --chip select
		OP <= "01";  			--out 4 --hold
		SELECT1 <= "0100";		--out 5 --MOSI='D4'
		if(CPOL = '0') then
			SELECT2 <= "00";	--out 6 --SCLK='bitsclk'
		else
			SELECT2 <= "01";	--out 6 --SCLK='~bitsclk'
		end if;
		
		CLR <= '0';				--out 7 -- cuenta 
		
		K <= c;		--out 8 --24 -- sclk 1MHz
		

		if(BT='1') then			--BT
			qn <= "001110";	    --siguiente estado
		else
			qn <= "001101";		--se mantiene
		end if;
		
		--s14--hit and run-----------------------------------------------------------------------------------------
		when "001110" =>	
		
		fin <= '0'; 			--out 1	--no fin
		valido <= '0'; 			--out 2 --no valido
		CS <= '0';				--out 3 --chip select
		OP <= "00";  			--out 4 --SHR MISO D4
		SELECT1 <= "0100";		--out 5 --MOSI='D4'
		if(CPOL = '0') then
			SELECT2 <= "00";	--out 6 --SCLK='bitsclk'
		else
			SELECT2 <= "01";	--out 6 --SCLK='~bitsclk'
		end if;
		
		CLR <= '0';				--out 7 --no cuenta

		K <= c;		--out 8 --24 -- sclk 1MHz

		qn <= "001111";		--hit and run -- siguiente estado
		
		--s15--bt-----------------------------------------------------------------------------------------
		when "001111" =>	
		
		fin <= '0'; 			--out 1	--no fin
		valido <= '0'; 			--out 2 --no valido
		CS <= '0';				--out 3 --chip select
		OP <= "01";  			--out 4 --hold
		SELECT1 <= "0100";		--out 5 --MOSI='D4'
		if(CPOL = '0') then
			SELECT2 <= "00";	--out 6 --SCLK='bitsclk'
		else
			SELECT2 <= "01";	--out 6 --SCLK='~bitsclk'
		end if;
		
		CLR <= '0';				--out 7 -- cuenta 
		
		K <= c;		--out 8 --24 -- sclk 1MHz
		

		if(BT='1') then			--BT
			qn <= "010000";	    --siguiente estado
		else
			qn <= "001111";		--se mantiene
		end if;
		
		--s16--bt-----------------------------------------------------------------------------------------
		when "010000" =>	
		
		fin <= '0'; 			--out 1	--no fin
		valido <= '0'; 			--out 2 --no valido
		CS <= '0';				--out 3 --chip select
		OP <= "01";  			--out 4 --hold
		SELECT1 <= "0101";		--out 5 --MOSI='D5'
		if(CPOL = '0') then
			SELECT2 <= "00";	--out 6 --SCLK='bitsclk'
		else
			SELECT2 <= "01";	--out 6 --SCLK='~bitsclk'
		end if;
		
		CLR <= '0';				--out 7 -- cuenta 
		
		K <= c;		--out 8 --24 -- sclk 1MHz
		

		if(BT='1') then			--BT
			qn <= "010001";	    --siguiente estado
		else
			qn <= "010000";		--se mantiene
		end if;
		
		--s17--hit and run-----------------------------------------------------------------------------------------
		when "010001" =>	
		
		fin <= '0'; 			--out 1	--no fin
		valido <= '0'; 			--out 2 --no valido
		CS <= '0';				--out 3 --chip select
		OP <= "00";  			--out 4 --SHR MISO D5
		SELECT1 <= "0101";		--out 5 --MOSI='D5'
		if(CPOL = '0') then
			SELECT2 <= "00";	--out 6 --SCLK='bitsclk'
		else
			SELECT2 <= "01";	--out 6 --SCLK='~bitsclk'
		end if;
		
		CLR <= '0';				--out 7 --no cuenta

		K <= c;		--out 8 --24 -- sclk 1MHz

		qn <= "010010";		--hit and run -- siguiente estado
		
		--s18--bt-----------------------------------------------------------------------------------------
		when "010010" =>	
		
		fin <= '0'; 			--out 1	--no fin
		valido <= '0'; 			--out 2 --no valido
		CS <= '0';				--out 3 --chip select
		OP <= "01";  			--out 4 --hold
		SELECT1 <= "0101";		--out 5 --MOSI='D5'
		if(CPOL = '0') then
			SELECT2 <= "00";	--out 6 --SCLK='bitsclk'
		else
			SELECT2 <= "01";	--out 6 --SCLK='~bitsclk'
		end if;
		
		CLR <= '0';				--out 7 -- cuenta 
		
		K <= c;		--out 8 --24 -- sclk 1MHz
		

		if(BT='1') then			--BT
			qn <= "010011";	    --siguiente estado
		else
			qn <= "010010";		--se mantiene
		end if;
		
		
		--s19--bt-----------------------------------------------------------------------------------------
		when "010011" =>	
		
		fin <= '0'; 			--out 1	--no fin
		valido <= '0'; 			--out 2 --no valido
		CS <= '0';				--out 3 --chip select
		OP <= "01";  			--out 4 --hold
		SELECT1 <= "0110";		--out 5 --MOSI='D6'
		if(CPOL = '0') then
			SELECT2 <= "00";	--out 6 --SCLK='bitsclk'
		else
			SELECT2 <= "01";	--out 6 --SCLK='~bitsclk'
		end if;
		
		CLR <= '0';				--out 7 -- cuenta 
		
		K <= c;		--out 8 --24 -- sclk 1MHz
		

		if(BT='1') then			--BT
			qn <= "010100";	    --siguiente estado
		else
			qn <= "010011";		--se mantiene
		end if;
		
		--s20--hit and run-----------------------------------------------------------------------------------------
		when "010100" =>	
		
		fin <= '0'; 			--out 1	--no fin
		valido <= '0'; 			--out 2 --no valido
		CS <= '0';				--out 3 --chip select
		OP <= "00";  			--out 4 --SHR MISO D6
		SELECT1 <= "0110";		--out 5 --MOSI='D6'
		if(CPOL = '0') then
			SELECT2 <= "00";	--out 6 --SCLK='bitsclk'
		else
			SELECT2 <= "01";	--out 6 --SCLK='~bitsclk'
		end if;
		
		CLR <= '0';				--out 7 --no cuenta

		K <= c;		--out 8 --24 -- sclk 1MHz

		qn <= "010101";		--hit and run -- siguiente estado
		
		--s21--bt-----------------------------------------------------------------------------------------
		when "010101" =>	
		
		fin <= '0'; 			--out 1	--no fin
		valido <= '0'; 			--out 2 --no valido
		CS <= '0';				--out 3 --chip select
		OP <= "01";  			--out 4 --hold
		SELECT1 <= "0110";		--out 5 --MOSI='D6'
		if(CPOL = '0') then
			SELECT2 <= "00";	--out 6 --SCLK='bitsclk'
		else
			SELECT2 <= "01";	--out 6 --SCLK='~bitsclk'
		end if;
		
		CLR <= '0';				--out 7 -- cuenta 
		
		K <= c;		--out 8 --24 -- sclk 1MHz
		

		if(BT='1') then			--BT
			qn <= "010110";	    --siguiente estado
		else
			qn <= "010101";		--se mantiene
		end if;
		
		--s22--bt-----------------------------------------------------------------------------------------
		when "010110" =>	
		
		fin <= '0'; 			--out 1	--no fin
		valido <= '0'; 			--out 2 --no valido
		CS <= '0';				--out 3 --chip select
		OP <= "01";  			--out 4 --hold
		SELECT1 <= "0111";		--out 5 --MOSI='D7'
		if(CPOL = '0') then
			SELECT2 <= "00";	--out 6 --SCLK='bitsclk'
		else
			SELECT2 <= "01";	--out 6 --SCLK='~bitsclk'
		end if;
		
		CLR <= '0';				--out 7 -- cuenta 
		
		K <= c;		--out 8 --24 -- sclk 1MHz
		

		if(BT='1') then			--BT
			qn <= "010111";	    --siguiente estado
		else
			qn <= "010110";		--se mantiene
		end if;
		
		--s23--hit and run-----------------------------------------------------------------------------------------
		when "010111" =>	
		
		fin <= '0'; 			--out 1	--no fin
		valido <= '0'; 			--out 2 --no valido
		CS <= '0';				--out 3 --chip select
		OP <= "00";  			--out 4 --SHR MISO D6
		SELECT1 <= "0111";		--out 5 --MOSI='D7'
		if(CPOL = '0') then
			SELECT2 <= "00";	--out 6 --SCLK='bitsclk'
		else
			SELECT2 <= "01";	--out 6 --SCLK='~bitsclk'
		end if;
		
		CLR <= '0';				--out 7 --no cuenta

		K <= c;		--out 8 --24 -- sclk 1MHz

		qn <= "011000";		--hit and run -- siguiente estado
		
		--s24--bt-----------------------------------------------------------------------------------------
		when "011000" =>	
		
		fin <= '0'; 			--out 1	--no fin
		valido <= '0'; 			--out 2 --no valido
		CS <= '0';				--out 3 --chip select
		OP <= "01";  			--out 4 --hold
		SELECT1 <= "0111";		--out 5 --MOSI='D7'
		if(CPOL = '0') then
			SELECT2 <= "00";	--out 6 --SCLK='bitsclk'
		else
			SELECT2 <= "01";	--out 6 --SCLK='~bitsclk'
		end if;
		
		CLR <= '0';				--out 7 -- cuenta 
		
		K <= c;		--out 8 --24 -- sclk 1MHz
		

		if(BT='1') then			--BT
			qn <= "011001";	    --siguiente estado
		else
			qn <= "011000";		--se mantiene
		end if;
		
		
		--s25--fin-----------------------------------------------------------------------------------------
		when others =>	
		
		fin <= '0'; 			--out 1	--fin
		valido <= '1'; 			--out 2 --valido
		CS <= '0';				--out 3 --chip select
		OP <= "01";  			--out 4 --hold
		SELECT1 <= "0111";		--out 5 --MOSI='0'
		if(CPOL = '0') then
			SELECT2 <= "00";	--out 6 --SCLK='0'
		else
			SELECT2 <= "01";	--out 6 --SCLK='1'
		end if;
		
		CLR <= '0';				--out 7 -- no cuenta 
		
		K <= c;		--out 8 --24 -- sclk 1MHz
		

		if(start='1') then			--start
			qn <= "000001";	    --nueva palabra a enviar y recibir
		else
			qn <= "000000";		--origen
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