-- ====================================================================
--
--	File Name:		Or_gate_Test.vhd
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



entity or_Gate_Tset is
end or_Gate_Tset;

architecture rtl of or_Gate_Tset is  

component or_Gate port(
	 bitA,bitB : in std_logic;	
	resultOr  : out std_logic
	); 
end component;  

signal  inA_tmp,inB_tmp : std_logic;
signal  outA_tmp : std_logic;
begin
        tester : or_Gate
        port map(bitA=>inA_tmp, bitB=>inB_tmp,  resultOr=>outA_tmp);
        
        testbench : process
        begin
          inA_tmp <= '1','0' after 50 ns;
          inB_tmp <= '0';
          wait;
        end process testbench;
        
end rtl;




