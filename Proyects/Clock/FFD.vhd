library ieee;
use ieee.std_logic_1164.all;

entity FFD is

port(
RST, CLK, D : in std_logic;
Q : out std_logic
);

end FFD;

architecture simple of FFD is
begin
	secuencial : process(RST,CLK)
	begin
		if(RST='0') then
			Q <= '1';
		elsif(D='1') then
			Q <= not D;
		end if;
	end process;
end simple;