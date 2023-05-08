library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity MAC_4 is	
	
	port(
	
	RST,CLK : in std_logic;
	
	fs : in std_logic;

	Xn : in std_logic_vector(11 downto 0);
	
	EOP : out std_logic;
	
	Yn : out std_logic_vector(37 downto 0)
	
	);	
	
end MAC_4;

architecture fsm of MAC_4 is	

--------------------------------------------------------------------------------------

component mux_5a1_n is
	generic(
	n	:	integer := 12
	);
	port(
	x0,x1,x2,x3,x4	: in std_logic_vector(n-1 downto 0);
	s			: in std_logic_vector(2 downto 0);
	y			: out std_logic_vector(n-1 downto 0)
	);

end component;

--------------------------------------------------------------------------------------

component multiplicador_n is
	
	generic(
	n : integer := 18
	);
	
	port(
	A,B : in std_logic_vector(n-1 downto 0);
	M : out std_logic_vector(2*n-1 downto 0)
	);
	
end component; 

--------------------------------------------------------------------------------------

component LUT is
port (
    F	:	in std_logic_vector(2 downto 0);
    s	: 	out std_logic_vector(11 downto 0)
    ); 	
	
end component; 

-------------------------------------------------------------------------------------- 

component Sumador_n is
	generic(
	n : integer :=38
	);
	port(
	A,B :	in std_logic_vector(n-1 downto 0);
	--Ci	:	in std_logic;
	S	:	out std_logic_vector(n-1 downto 0)
	--Co	:	out std_logic
	);
	
end component; 

--------------------------------------------------------------------------------------

component registro_paralelo_reg is
	
	generic(
	
	n : integer := 12
	
	);
	
	port(
	
	RST,CLK : in std_logic;
	
	Din : in std_logic_vector(n-1 downto 0);   
	
	OPR : in std_logic_vector(1 downto 0);
	
	Qout : out std_logic_vector(n-1 downto 0)	
	
	);
	
		
end component; 


--------------------------------------------------------------------------------------

component registro_paralelo_rac is
	
	generic(
	
	n : integer := 38
	
	);
	
	port(
	
	Din : in std_logic_vector(n-1 downto 0);   
	
	OPR : in std_logic_vector(1 downto 0);
	
	RST,CLK : in std_logic; 
	
	Qout : out std_logic_vector(n-1 downto 0)
	
	);
		
end component;

--------------------------------------------------------------------------------------

component registro_paralelo_rr is
	
	generic(
	
	n : integer := 38
	
	);
	
	port(
	
	Din : in std_logic_vector(n-1 downto 0);   
	
	OPR : in std_logic_vector(1 downto 0);
	
	RST,CLK : in std_logic; 
	
	Qout : out std_logic_vector(n-1 downto 0)
	
	);
		
end component; 

--------------------------------------------------------------------------------------

component fsm_MAC_4 is
	port(
	
	RST,CLK : in std_logic;
	fs : in std_logic;
	REG,RAC,RR : out std_logic_vector(1 downto 0);
	MUX,LUT : out std_logic_vector(2 downto 0);
	EOP : out std_logic
	
	);
	
end component; 

--------------------------------------------------------------------------------------


signal x1,x2,x3,x4,A,B: std_logic_vector(11 downto 0);
signal A1,B1			: std_logic_vector(17 downto 0);
signal M				: std_logic_vector(35 downto 0);
signal M1,Q1,D1,S		: std_logic_vector(37 downto 0);
signal smux,slut		: std_logic_vector(2 downto 0);	
signal sreg,srac,srr	: std_logic_vector(1 downto 0);

begin 
	
	A1<=A(11) & A(11) & A(11) & A(11) & A(11) & A(11) & A;
	B1<=B(11) & B(11) & B(11) & B(11) & B(11) & B(11) & B;
	M1<= M(35) & M(35) & M;

	
	sc0 :  mux_5a1_n port map(Xn,x1,x2,x3,x4,smux,A);
	sc1:  LUT port map(slut,B);
	sc2 :  multiplicador_n port map(A1,B1,M);
	sc3 :  Sumador_n port map(M1,Q1,D1);
	sc4 :  registro_paralelo_reg port map(RST,CLK,Xn,sreg,x1);
	sc5 :  registro_paralelo_reg port map(RST,CLK,x1,sreg,x2);
	sc6 :  registro_paralelo_reg port map(RST,CLK,x2,sreg,x3);
	sc7 :  registro_paralelo_reg port map(RST,CLK,x3,sreg,x4);
	sc8 :  registro_paralelo_rac port map(D1,srac,RST,CLK,Q1);
	sc9 :  registro_paralelo_rr port map(Q1,srr,RST,CLK,Yn);
	sc10 :  fsm_MAC_4 port map(RST,CLK,fs,sreg,srac,srr,smux,slut,EOP);
	
	--Yn <= S(23 downto 12);
	
	
end fsm;