library ieee;
use ieee.std_logic_1164.all;

entity fsm_DAC7564 is 
	
	port(
	
	RST,CLK : in std_logic;	
	--entradas
	init	: in std_logic;							--in1
	bt		: in std_logic;							--in2
	valid	: in std_logic;							--in3
	--salidas
	mux		: out std_logic_vector(1 downto 0);		--out1
	start	: out std_logic;						--out2
	ldac	: out std_logic;						--out3
	clr		: out std_logic;						--out4
	fin		: out std_logic							--out5
	
	
	);
end fsm_DAC7564;

architecture fsm of fsm_DAC7564 is	


signal qp, qn : std_logic_vector(3 downto 0); 

begin  
	
	c1 : process(qp,bt,valid,init)
	begin
		
		case(qp) is
		
		--s0-- apagado
		when "0000" =>	
		
		mux		<= "00";			--out1 --primera palabra
		start	<= '0';				--out2 --no trans
		ldac	<= '0';				--out3 --no load
		clr		<= '1';				--out4 --no cuenta
		fin		<= '1';				--out5 --fin
		
		if(init='1') then
			qn <= "0001"; --siguiente
		else
			qn <= qp   ; --se mantiene
		end if;

		
		--s1 --primera palabra
		when "0001" =>	
		
		mux		<= "00";			--out1 --primera palabra
		start	<= '1';				--out2 --trans
		ldac	<= '0';				--out3 --no load
		clr		<= '1';				--out4 --no cuenta
		fin		<= '0';				--out5 --no fin
		
		if(valid='1') then
			qn <= "0010"; --siguiente
		else
			qn <= qp   ; --se mantiene
		end if;
		
		--s2 --segunda palabra
		when "0010" =>	
		
		mux		<= "01";			--out1 --segunda palabra
		start	<= '1';				--out2 --no trans
		ldac	<= '0';				--out3 --load
		clr		<= '1';				--out4 --no cuenta
		fin		<= '0';				--out5 --no fin
		
		if(valid='1') then
			qn <= "0011"; --siguiente
		else
			qn <= qp   ; --se mantiene
		end if;
		
		--s3-- tercera palabra 
		when "0011" =>	
		
		mux		<= "10";			--out1 --tercera palabra
		start	<= '1';				--out2 --no trans
		ldac	<= '0';				--out3 --load
		clr		<= '1';				--out4 --no cuenta
		fin		<= '0';				--out5 --no fin
		
		if(valid='1') then
			qn <= "0100"; --siguiente
			start	<= '0';
		else
			qn <= qp   ; --se mantiene
		end if;
		
		--s4-- 0 dac
		when "0100" =>	
		
		mux		<= "10";			--out1 --tercera palabra
		start	<= '0';				--out2 --trans
		ldac	<= '0';				--out3 --no load
		clr		<= '0';				--out4 --cuenta
		fin		<= '0';				--out5 --no fin
		
		if(bt='1') then
			qn <= "0101"; --loop
		else
			qn <= qp   ; --siguiente
		end if;
		
		--s5-- 1 ldac
		when "0101" =>	
		
		mux		<= "10";			--out1 --tercera palabra
		start	<= '0';				--out2 --trans
		ldac	<= '1';				--out3 --no load
		clr		<= '0';				--out4 --cuenta
		fin		<= '0';				--out5 --no fin
		
		if(bt='1') then
			qn <= "0110"; --siguiente
		else
			qn <= qp   ; --se mantiene
		end if;	 
		
		

		
		--s6-- 0 ldac --fin
		when "0110" =>	
		
		mux		<= "10";			--out1 --tercera palabra
		start	<= '0';				--out2 --trans
		ldac	<= '0';				--out3 --no load
		clr		<= '0';				--out4 --cuenta
		fin		<= '0';				--out5 --no fin
		
		if(bt='1') then
			qn <= "0111"; --siguiente
		else
			qn <= qp   ; --se mantiene
		end if;	
		
		
		--s7-- ciclo de reloj mas
		when "0111" =>	
		
		mux		<= "10";			--out1 --tercera palabra
		start	<= '0';				--out2 --no trans
		ldac	<= '0';				--out3 --no load
		clr		<= '1';				--out4 --no cuenta
		fin		<= '0';				--out5 --no fin
		
		qn <= "1000"; --siguiente	  
		
		--s8-- ciclo de reloj mas
		when others =>	
		
		mux		<= "10";			--out1 --tercera palabra
		start	<= '0';				--out2 --no trans
		ldac	<= '0';				--out3 --no load
		clr		<= '1';				--out4 --no cuenta
		fin		<= '0';				--out5 --no fin
		
		qn <= "0000"; --siguiente
		
		
		
		
			
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