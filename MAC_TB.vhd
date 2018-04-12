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



entity MAC_TB is
end MAC_TB;

architecture rtl of MAC_TB is  

component MAC_struct is generic(

  N : integer := 8
  
);

port (

  clk,RST,enable : in std_logic;
	inputA, selector_MUL_in: in std_logic_vector(N-1 downto 0);	
	selector_FA_in: in std_logic_vector(2*N-1 downto 0);
	output2N: out std_logic_vector (2*N-1 downto 0)	
		
	);-- ports declerations
end component;

signal  clk_q,RST_q : std_logic:='0';
signal  inA_tmp, inB_tmp: std_logic_vector (3 downto 0):=(others=>'0');
signal output_MAC,selector_FA_in_tmp : std_logic_vector (7 downto 0):=(others=>'0');

for tester: MAC_struct use entity work.MAC_struct;

begin
        tester : MAC_struct
        generic map ( N => 4)
        port map(clk => clk_q, inputA => inA_tmp, selector_MUL_in => inB_tmp, selector_FA_in =>selector_FA_in_tmp , output2N=>output_MAC, RST=>RST_q, enable => '1');
        
 process
 begin
   
   --TEST 0 - no resets
      inA_tmp <= "0010";
      inB_tmp <= "0010";
      clk_q <= '1';--out = 0,mac_out=0
      wait for 1 ns;
      clk_q <= '0';
      selector_FA_in_tmp <= "00000100";
      wait for 1 ns;
      clk_q <= '1'; --out = 4
      wait for 1 ns;
      clk_q <= '0';
      selector_FA_in_tmp <= "00001000";
      wait for 1 ns;
      clk_q <= '1';
      wait for 1 ns;
      selector_FA_in_tmp <= "00001100";
      clk_q <= '0';
      wait for 1 ns;
      clk_q <= '1';
      wait for 1 ns;
      
      assert(output_MAC = "00001000") report "output_MAC error 0" severity error;
    end process;
         
end rtl;


