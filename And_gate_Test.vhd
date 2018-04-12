-- ====================================================================
--
--	File Name:		And_gate_Test.vhd
--	Description:	Test bench for or gate 
--					
--
--	Date:			28/03/2018
--	Designer:		Amir Tsur
--
-- ====================================================================
-- Test Bench for or_Gate_Tset.

library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;



entity and_Gate_Tset is
end and_Gate_Tset;

architecture rtl of and_Gate_Tset is  

component and_Gate port(
	 bitA,bitB : in std_logic;	
	resultAnd  : out std_logic
	); 
end component;  

signal  inA_tmp,inB_tmp : std_logic;
signal  outA_tmp : std_logic;
begin
        tester : and_Gate
        port map(bitA=>inA_tmp, bitB=>inB_tmp,  resultAnd=>outA_tmp);
        
        testbench : process
        begin
          inA_tmp <= '0','1' after 5 ns;
          inB_tmp <= '1';
          wait;
        end process testbench;
        
end rtl;






