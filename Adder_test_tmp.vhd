-- ====================================================================
--
--	File Name:		one_bit_adder_Test.vhd
--	Description:	Test bench for 	one_bit_adder_Test 
--					
--
--	Date:			28/03/2018
--	Designer:		Amir Tsur
--
-- ====================================================================
-- Test Bench for 	one_bit_adder_Test.

library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;



entity 	Adder_test is
end 	Adder_test;

architecture rtl of 	Adder_test is  

component  Full_Adder_Struct port(
  
	digitA, digitB, carryIn: in std_logic;	
	carryOut: out std_logic;	
	result: out std_logic
		
	); 
end component;  

signal  inA_tmp,inB_tmp, Cin  : std_logic;
signal  Cout, sum : std_logic;

begin
        tester : Full_Adder_Struct
        port map(digitA=>inA_tmp, digitB=>inB_tmp, carryOut=>Cout, carryIn=>Cin, result=>sum);
        
        testbench : process
        begin
          Cin <= '0';
          inA_tmp <='1';
          inB_tmp <='1';
          wait;
        end process testbench;
        
  
end rtl;

