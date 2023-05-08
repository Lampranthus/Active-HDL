library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity X_BLKRAM_DP_2C_1WR_1R is
	generic(
	m : integer := 8; -- Ancho de palabra
	n : integer := 4; -- Bits de direccion
	k : integer := 16  -- Localidades de memoria k=2**n
	);
	port(
	RAM_CKA : in  std_logic; -- Reloj escritura/lectura A
	RAM_CKB : in  std_logic; -- Reloj lectura B
	RAM_ENA : in  std_logic; -- Habilitacion puerto A
	RAM_ENB : in  std_logic; -- Habilitacion puerto B
	RAM_WRE : in  std_logic; -- Habilitacion de escritura
	RAM_DWR : in  std_logic_vector(m-1 downto 0); -- Dato de escritura
	RAM_ADA : in  std_logic_vector(n-1 downto 0); -- Direccion de esc/lec A
	RAM_ADB : in  std_logic_vector(n-1 downto 0); -- Direccion de lectura B
	RAM_RDA : out std_logic_vector(m-1 downto 0); -- Dato de lectura A
	RAM_RDB : out std_logic_vector(m-1 downto 0)  -- Dato de lectura B
	);
end X_BLKRAM_DP_2C_1WR_1R;

architecture Xilinx_block of X_BLKRAM_DP_2C_1WR_1R is  

-- Definicion del numero de bits del registro
subtype Ancho_del_registro is std_logic_vector(m-1 downto 0);

-- Definicion de la memoria como arreglo de registros
type    Memoria is array(natural range <>) of Ancho_del_registro;

-- Declaracion del tamano de la memoria
signal  RAM_MEM : Memoria(0 to k-1);

begin	
	
Reloj_A: process (RAM_CKA)
	begin
	    -- Todo el proceso esta sincronizado al reloj A
   	    if (RAM_CKA'event and RAM_CKA = '1') then
	        -- Todos los accesos son habilitados por ENA y WRE
      	        if (RAM_ENA = '1') then	
                     if (RAM_WRE = '1') then
            	        RAM_MEM(conv_integer(RAM_ADA)) <= RAM_DWR;
		        		RAM_RDA <= RAM_MEM(conv_integer(RAM_ADA));
         	    end if;
      		end if;
   	    end if;
	end process Reloj_A;
	
	Reloj_B: process (RAM_CKB)
	begin
	    -- Todo el proceso esta sincronizado al reloj B
	    if (RAM_CKB'event and RAM_CKB = '1') then
		-- El acceso de lectura esta habilitado por ENB
      		if (RAM_ENB = '1') then
         	    RAM_RDB <= RAM_MEM(conv_integer(RAM_ADB));
      		end if;
   	    end if;
	end process Reloj_B;
	
end Xilinx_block;
