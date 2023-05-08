library ieee;
use ieee.std_logic_1164.all;

entity latch_D is

port(
RST, LE, D : in std_logic;
Q : out std_logic
);

end latch_D;

architecture simple of latch_D is
begin
	secuencial : process(RST,LE,D)
	begin
		if(RST='0') then
			Q <= '0';
		elsif(LE='1') then
			Q <= D;
		end if;
	end process;
end simple;