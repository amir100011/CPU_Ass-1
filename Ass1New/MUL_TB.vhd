-- ====================================================================
--
--	File Name:		Test_D_FlipFlop.vhd
--	Description:	Test bench for counter 
--					
--
--	Date:			30/03/2018
--	Designer:		Amir Tsur
--
-- ====================================================================
-- Test Bench for D_FlipFlop_MemoryReg.

library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;



entity MUL_TB is
end MUL_TB;

architecture rtl of MUL_TB is  

component n_Bit_Multiplication_behavioral generic(
N : integer := 8	

);

port (

	inputBusA, inputBusB: in std_logic_vector(N-1 downto 0);
	result: out std_logic_vector(2*N-1 downto 0)
		
	);-- ports declerations
end component;  

signal  inA_tmp,inB_tmp: std_logic_vector (1 downto 0);
signal  transfer:  std_logic_vector (3 downto 0);
begin
        tester : n_Bit_Multiplication_behavioral
        generic map ( N => 2)
        port map(result=>transfer, inputBusA=>inA_tmp, inputBusB=>inB_tmp);
          
          inA_tmp <= "10";
          inB_tmp <= "10";



end rtl;




