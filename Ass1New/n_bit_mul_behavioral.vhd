
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity n_Bit_Multiplication_behavioral is generic(

N : integer := 8	

);

port (

	inputBusA, inputBusB: in std_logic_vector(N-1 downto 0);
	result: out std_logic_vector(2*N-1 downto 0):=(others=>'0')
		
	);-- ports declerations
end n_Bit_Multiplication_behavioral;

architecture behavioral_Arch of n_Bit_Multiplication_behavioral is
  
  begin
      
  result <= signed(inputBusA)*signed(inputBusB);
  
end behavioral_Arch;
