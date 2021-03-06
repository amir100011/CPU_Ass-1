--
--	File Name:		Shift_Unit_TB.vhd
--	Description:	Shift register structural 
--					
--
--	Date:			10/04/2018
--	Designer:		Dor Livne
--
-- ====================================================================
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Shift_Test is
end Shift_Test;

architecture rtl of Shift_Test is
  
  component Shift_reg_MUXER generic(
  N : integer :=16
  ); 
  port(
    right,En: in std_logic;--1->right, 0->left
	inputA: in std_logic_vector(N-1 downto 0);
	Shift: in std_logic_vector(4 downto 0);	
	output1: out std_logic_vector (N-1 downto 0)
		
	);-- ports declerations
	end component;
	signal inA,output_trans: std_logic_vector(15 downto 0);
	signal shiftby: std_logic_vector(4 downto 0);
	signal direction,enable:std_logic;
	
	for simulation: Shift_reg_MUXER use entity work.Shift_reg_MUXER;
	
	begin
	  simulation: Shift_reg_MUXER
	               generic map(N=>16)
	               port map(right=>direction,En=>enable,Shift=>shiftby,inputA=>inA,output1=>output_trans);
	                
	                testbench: process
	                begin
	                  inA<=X"4001";
	                  shiftby<="00001";
	                  direction<='0';
	                  enable<='1';
	                  wait for 1 ns;
	                  assert output_trans = X"8002"
	                  REPORT "TEST 1 FAILED"
	                  SEVERITY error;
	                  wait for 1 ns;
	                  inA<=X"F001";
	                  shiftby<="00100";
	                  direction<='1';
	                  enable<='1';
	                  wait for 1 ns;
	                  assert output_trans = X"0F00"
	                  REPORT "TEST 2 FAILED"
	                  SEVERITY error;
	                   wait for 1 ns;
	                  inA<=X"F001";
	                  shiftby<="11111";
	                  direction<='1';
	                  enable<='0';
	                  wait for 1 ns;
	                  assert output_trans = X"F001"
	                  REPORT "TEST 3 FAILED"
	                  SEVERITY error;
	                   wait for 1 ns;
	                  inA<=X"FFFF";
	                  shiftby<="11111";
	                  direction<='1';
	                  enable<='1';
	                  wait for 1 ns;
	                  assert output_trans = X"0000";
	                  REPORT "TEST 4 FAILED"
	                  SEVERITY error;
	                  wait for 1 ns;
	                  end process testbench;
	                  end rtl;
	  
	
