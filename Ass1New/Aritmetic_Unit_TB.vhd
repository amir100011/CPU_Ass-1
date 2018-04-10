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



entity 	Aritmetic_Unit_TB is
end 	Aritmetic_Unit_TB;

architecture rtl of 	Aritmetic_Unit_TB is  

component Aritmetic_Unit is generic(

  N : integer := 8
  
);

port (

  Opcode:                      in std_logic_vector(3 downto 0);--9 actions availible
  InputBusA:                   in std_logic_vector(N-1 downto 0);
  InputBusB:                   in std_logic_vector(N-1 downto 0);
  clk:                         in std_logic;
	Aritmetic_Unit_output_MUL:   out std_logic_vector(2*N-1 downto 0);
	Aritmetic_Unit_output_MAC:   out std_logic_vector(2*N-1 downto 0);  
	Aritmetic_Unit_output_FA:    out std_logic_vector(2*N-1 downto 0)	
		
	);-- ports declerations
end component;

signal inA_tmp,inB_tmp  : std_logic_vector(1 downto 0);
signal clk_q : std_logic;
signal opcode_q : std_logic_vector(3 downto 0);
signal sum : std_logic_vector(3 downto 0);
signal mul : std_logic_vector(3 downto 0);
signal Acc : std_logic_vector(3 downto 0);

for tester: Aritmetic_Unit use entity work.Aritmetic_Unit;

begin
        tester : Aritmetic_Unit
        generic map ( N => 2)
        port map(inputBusA=>inA_tmp, 
                 inputBusB=>inB_tmp, 
                 clk=>clk_q, 
                 Opcode=>opcode_q, 
                 Aritmetic_Unit_output_FA=>sum,
                 Aritmetic_Unit_output_MUL => mul,
                 Aritmetic_Unit_output_MAC => Acc             
                 );
        
        testbench : process
        begin
          
          
     --TEST 0 ADD
      inA_tmp <= "01";
      inB_tmp <= "01";
      clk_q <= '1';
      opcode_q <= "0000";
      wait for 1 ns;
      assert(sum = "0010") report "sum error 0" severity error;
      
      clk_q <= '0';
      wait for 1 ns;
      
        --TEST 1 MUL
      inA_tmp <= "01";
      inB_tmp <= "01";
      clk_q <= '1';
      opcode_q <= "0100";
      wait for 1 ns;
      assert(mul = "0001") report "sum error 0" severity error;
      
      clk_q <= '0';
      wait for 1 ns;
      

      --TEST 2 SUB
      inA_tmp <= "01";
      inB_tmp <= "01";
      clk_q <= '1';
      opcode_q <= "0001";
      wait for 1 ns;
      assert(sum = "0000") report "sum error 0" severity error;
      
      clk_q <= '0';
      wait for 1 ns;
      
      
      --TEST 3 SUB
      inA_tmp <= "01";
      inB_tmp <= "01";
      clk_q <= '1';
      opcode_q <= "0101";
      wait for 1 ns;
      clk_q <= '0';
      wait for 1 ns;
      clk_q <= '1';
      wait for 1 ns;
      assert(Acc = "0000") report "sum error 0" severity error;
  
   end process testbench;
    
end rtl;






