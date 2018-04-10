--
--	File Name:		Test_D_FlipFlop.vhd
--	Description:	Test bench for counter 
--					
--
--	Date:			06/04/2018
--	Designer:		Amir Tsur
--
-- ====================================================================
-- Test Bench for D_FlipFlop_MemoryReg.

library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;



entity Min_Max_TB is
end Min_Max_TB;

architecture rtl of Min_Max_TB is  

component Minimazier_Maximaizer is generic(
  
 N : integer := 8
  
);

port (

  mode:                  in std_logic;--1<=max,0<=min
  enable:                in std_logic;
  clk:                   in std_logic;
	MinMaxA_In:            in std_logic_vector(2*N-1 downto 0);	
	MinMaxB_In:            in std_logic_vector(2*N-1 downto 0);	
	Min_Max_output:        out std_logic_vector (2*N-1 downto 0)	
		
	);-- ports declerations
end component;

constant numOfClockCounter: integer := 6;
signal  clk_q,enable_q,mode_q : std_logic := '0';
signal  inA_tmp, inB_tmp: std_logic_vector (3 downto 0);
signal Min_Max_output_q : std_logic_vector (3 downto 0);

for tester: Minimazier_Maximaizer use entity work.Minimazier_Maximaizer;

begin
        tester : Minimazier_Maximaizer
        generic map ( N => 2)
        port map(
                clk=>clk_q, 
                MinMaxA_In=>inA_tmp, 
                MinMaxB_In=>inB_tmp, 
                Min_Max_output=>Min_Max_output_q, 
                mode=>mode_q,
                enable => enable_q
                );
        
 process
 begin
   
   --TEST 0 - Max,A>B
   clk_q <= '0';
   wait for 2 ns;
   inA_tmp <= "1010";
   inB_tmp <= "0101";
   mode_q <= '1';--max
   enable_q <= '1';
   clk_q <= '1';
   wait for 2 ns;
   
  assert(Min_Max_output_q = "1010") report "Min_Max_output_q error 0" severity error;
   
     
    end process;
         
end rtl;

