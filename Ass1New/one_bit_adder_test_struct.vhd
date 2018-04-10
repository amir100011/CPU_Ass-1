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



entity 	one_bit_adder_Test is
end 	one_bit_adder_Test;

architecture rtl of 	one_bit_adder_Test is  

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
         
    for i in 0 to 6 loop 
      wait for 1 ns;
      Cin <= not Cin;			
    end loop;
    
          wait;
        end process testbench;
        
   process
   variable errCnt : integer := 0;
   begin
    
    --TEST 0 Cin=0
      inA_tmp <= '0';
      inB_tmp <= '0';
      wait for 1 ns;
      assert(sum = '0') report "sum error 1" severity error;
      assert(Cout = '0') report "Cout error 1" severity error;
      if(sum = '1' or Cout = '1') then
         errCnt := errCnt + 1;
      end if;

    --TEST 1 Cin=1
      inA_tmp <= '0';
      inB_tmp <= '0';
      wait for 1 ns;
      assert(sum = '1') report "sum error 1" severity error;
      assert(Cout = '0') report "Cout error 1" severity error;
      if(sum = '0' or Cout = '1') then
         errCnt := errCnt + 1;
      end if;
      
   --TEST 2 Cin=0
   inA_tmp <= '0';
     inB_tmp <= '1';
     wait for 1 ns;
     assert(sum = '1') report "sum error 2" severity error;
     assert(Cout = '0') report "Cout error 2" severity error;
     if(sum = '0' or Cout = '1') then
        errCnt := errCnt + 1;
     end if;

   --TEST 3 Cin=1
    inA_tmp <= '0';
     inB_tmp <= '1';
     wait for 1 ns;
     assert(sum = '0') report "sum error 3" severity error;
     assert(Cout = '1') report "Cout error 3" severity error;
     if(sum = '1' and Cout = '0') then
        errCnt := errCnt + 1;
     end if;
     
        --TEST 4 Cin=0
    inA_tmp <= '1';
     inB_tmp <= '0';
     wait for 1 ns;
     assert(sum = '1') report "sum error 3" severity error;
     assert(Cout = '0') report "Cout error 3" severity error;
     if(sum = '0' and Cout = '1') then
        errCnt := errCnt + 1;
     end if;
     
        --TEST 5 Cin=1
    inA_tmp <= '1';
     inB_tmp <= '0';
     wait for 1 ns;
     assert(sum = '0') report "sum error 3" severity error;
     assert(Cout = '1') report "Cout error 3" severity error;
     if(sum = '1' and Cout = '0') then
        errCnt := errCnt + 1;
     end if;
     
        --TEST 6 Cin=0
    inA_tmp <= '1';
     inB_tmp <= '1';
     wait for 1 ns;
     assert(sum = '0') report "sum error 3" severity error;
     assert(Cout = '1') report "Cout error 3" severity error;
     if(sum = '1' and Cout = '0') then
        errCnt := errCnt + 1;
     end if;
     
        --TEST 7 Cin=1
    inA_tmp <= '1';
     inB_tmp <= '1';
     wait for 1 ns;
     assert(sum = '1') report "sum error 3" severity error;
     assert(Cout = '1') report "Cout error 3" severity error;
     if(sum = '0' and Cout = '0') then
        errCnt := errCnt + 1;
     end if;

     ---- SUMMARY ----
     if(errCnt = 0) then
        assert false report "Success!" severity note;
     else
        assert false report "Faillure!" severity note;
     end if;

   end process;
    
end rtl;
