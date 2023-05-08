library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Contador_9 is
	port(
	CLR,CLK: in std_logic;
	Dset: in std_logic_vector(3 downto 0);
	Dcont: out std_logic_vector(3 downto 0);
	Fin: out std_logic
	);
end entity Contador_9;

architecture arq of Contador_9 is
	--Flip_Flop_JK de flanco de reloj negativo o de caida
	component Flip_Flop_JK is
		port(
		CLK,J,K,CLR,Prset: in std_logic;
		Q: out std_logic
		);
	end component;
	--STOP_9
	component STOP_9 is
		port( 
		Dcont: in std_logic_vector(3 downto 0);
		CLR: out std_logic 
		);
	end component;
	
	signal J,K,clk1,clk2,clk3,clr_out,clr_in: std_logic;
	signal d: std_logic_vector(3 downto 0);
	
	begin
		J<='1';
		K<='1';
		clk1<= d(0);
		clk2<= d(1);
		clk3<= d(2);
		Dcont<=d;
		clr_in<= CLR or clr_out;
		Fin<=clr_out;
		ff0: Flip_Flop_JK port map(CLK,J,K,clr_in,Dset(0),d(0));
		ff1: Flip_Flop_JK port map(clk1,J,K,clr_in,Dset(1),d(1));
		ff2: Flip_Flop_JK port map(clk2,J,K,clr_in,Dset(2),d(2));
		ff3: Flip_Flop_JK port map(clk3,J,K,clr_in,Dset(3),d(3));
		
		st9_1: STOP_9 port map(d,clr_out);
	end arq;
	
		
	