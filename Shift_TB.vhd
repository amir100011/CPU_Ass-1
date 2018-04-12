--
--	File Name:		Shift_Unit_TB.vhd
--	Description:	Test bench for counter 
--					
--
--	Date:			30/03/2018
--	Designer:		Amir Tsur
--
-- ====================================================================
-- Test Bench for Shift_Unit.

library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;



entity Shift_TB is
end Shift_TB;

architecture rtl of Shift_TB is  

component Shift_reg generic(
  
  N : integer := 8
  
);

port (

  right_left : in std_logic;--0->right, 1->left
	inputA, inputB: in std_logic_vector(N-1 downto 0);	
	output, output1: out std_logic_vector (31 downto 0)		
		
	);-- ports declerations
end component;  

signal  inA_tmp, inB_tmp: std_logic_vector (1 downto 0);
signal transfer, transfer1 : std_logic_vector (31 downto 0);
signal right_left_tmp: std_logic;
begin
      
        tester : Shift_reg
        generic map ( N => 2)
        port map(right_left=>right_left_tmp, inputA=>inA_tmp, inputB=>inB_tmp, output=>transfer, output1=>transfer1);
        
         testbench : process
        begin
            inA_tmp <= "01";
            inB_tmp <= "10";
            right_left_tmp<='1';
            wait for 11 ns;
        end process testbench;
           
end rtl;


