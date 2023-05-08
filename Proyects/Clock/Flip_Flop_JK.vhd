--Nota importante, este es un flip flop JK con preset y clear

library ieee;
use ieee.std_logic_1164.all;

entity Flip_Flop_JK is
	port(
	CLK,J,K,CLR,Prset: in std_logic;
	Q: out std_logic
	);
end Flip_Flop_JK;

architecture simple of Flip_Flop_JK is
	signal Qs: std_logic;
begin
	secuencial: process(CLK,CLR,Prset,J,K)
	begin
		if(CLR='1') then			   
			Qs<='0';
		elsif (Prset='1') then
			Qs<='1';
		elsif (CLK'event and CLK='0') then
			Qs<=(J and (not Qs))or((not K) and Qs);
		end if;
	end process;
	Q<=Qs;
end simple;