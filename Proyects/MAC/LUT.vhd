--Tabla de consulta de datos
library IEEE;
use IEEE.std_logic_1164.all;

entity LUT is
port (
    F	:	in std_logic_vector(2 downto 0);
    s	: 	out std_logic_vector(11 downto 0)
    );
  end LUT;
  
  architecture tabla of LUT is
 begin
  process(F)
  begin case F is
  when "000"=> s <="000000000000"; -- Argumento 0 Funcion 0.00000000
  when "001"=> s <="010001111011"; -- Argumento 1 Funcion 0.280029296875
  when "010"=> s <="011100001010"; -- Argumento 2 Funcion 0.43994140625
  when "011"=> s <="010001111011"; -- Argumento 3 Funcion 0.280029296875
  when "100"=> s <="000000000000"; -- Argumento 4 Funcion 0.00000000
  when others => null;
       end case;
    end process;
  end tabla;
