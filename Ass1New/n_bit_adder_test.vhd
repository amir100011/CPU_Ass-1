-- ====================================================================
--
--	File Name:		n_bit_adder_Test.vhd
--	Description:	Test bench for 	n_bit_adder_Test 
--					
--
--	Date:			28/03/2018
--	Designer:		Amir Tsur
--
-- ====================================================================
-- Test Bench for 	n_bit_adder_Test.

library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;



entity 	n_bit_adder_Test is
end 	n_bit_adder_Test;

architecture rtl of 	n_bit_adder_Test is  

component  n_Bit_Full_Adder generic(
  

N : integer := 8	

);

port (

	inputBusA, inputBusB: in std_logic_vector(N-1 downto 0);
	carryIn : in std_logic;
	carryOutN: out std_logic;	
	result: out std_logic_vector(N-1 downto 0)
		
	);-- ports declerations
end component;  

signal inA_tmp,inB_tmp, sum  : std_logic_vector(3 downto 0);
signal Cin, Cout : std_logic;

begin
        tester : n_Bit_Full_Adder
        generic map ( N => 4)
        port map(inputBusA=>inA_tmp, inputBusB=>inB_tmp, carryOutN=>Cout, carryIn=>Cin, result=>sum);
        
        testbench : process
        begin
    
    --TEST 0 Cin=0
      inA_tmp <= "1111";
      inB_tmp <= "1111";
      Cin <= '0';
      wait for 1 ns;
      assert(sum = "1110") report "sum error 0" severity error;
      assert(Cout = '1') report "Cout error 0" severity error;
      
      --TEST 1 Cin=1 ---> subtractionn
      inA_tmp <= "1111";
      inB_tmp <= "1111";
      Cin <= '1';
      wait for 1 ns;
      assert(sum = "0000") report "sum error 1" severity error;
      assert(Cout = '0') report "Cout error 1" severity error;
      
      --TEST 2 Cin=1 ---> subtractionn
      inA_tmp <= "1110";
      inB_tmp <= "1010";
      Cin <= '1';
      wait for 1 ns;
      assert(sum = "0100") report "sum error 2" severity error;
      assert(Cout = '0') report "Cout error 2" severity error;
      
      --TEST 3 Cin=0
      inA_tmp <= "1110";
      inB_tmp <= "1010";
      Cin <= '0';
      wait for 1 ns;
      assert(sum = "1000") report "sum error 3" severity error;
      assert(Cout = '1') report "Cout error 3" severity error;
      
      --TEST 4 Cin=1 ---> subtractionn
      inA_tmp <= "1000";
      inB_tmp <= "0000";
      Cin <= '1';
      wait for 1 ns;
      assert(sum = "1000") report "sum error 4" severity error;
      assert(Cout = '0') report "Cout error 4" severity error;
      
      --TEST 5 Cin=0
      inA_tmp <= "1011";
      inB_tmp <= "0100";
      Cin <= '0';
      wait for 1 ns;
      assert(sum = "1111") report "sum error 5" severity error;
      assert(Cout = '0') report "Cout error 5" severity error;
      
      --TEST 6 Cin=1 ---> subtractionn
      inA_tmp <= "1011";
      inB_tmp <= "0100";
      Cin <= '1';
      wait for 1 ns;
      assert(sum = "0111") report "sum error 6" severity error;
      assert(Cout = '0') report "Cout error 6" severity error;
      
      --TEST 7 Cin=0
      inA_tmp <= "0000";
      inB_tmp <= "0000";
      Cin <= '0';
      wait for 1 ns;
      assert(sum = "0000") report "sum error 7" severity error;
      assert(Cout = '0') report "Cout error 7" severity error;
      
  
   end process testbench;
    
end rtl;


