--
--	File Name:		Selector_FA_TB.vhd
--	Description:	Test bench for selector_fa 
--					
--
--	Date:			30/03/2018
--	Designer:		Amir Tsur
--
-- ====================================================================
-- Test Bench for Selector_FA.

library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;



entity Selector_FA_TB is
end Selector_FA_TB;

architecture rtl of Selector_FA_TB is  

component Selector_FA generic(
  
 N : integer := 8	

);

port (

	Mac_input, RST_input: in std_logic_vector(2*N-1 downto 0) := (others =>'0');
	inputBusB: in std_logic_vector(N-1 downto 0);
	opcode: in std_logic_vector(3 downto 0);
	mode_FA: out std_logic;--Add/Sub bit 0-add 1-sub
	inputToPass_FA: out std_logic_vector(2*N-1 downto 0);
	RST_Line: out std_logic := '0'
		
	);-- ports declerations
end component;  

signal inB_tmp: std_logic_vector (1 downto 0);
signal mac_input_q,RST_input_q: std_logic_vector (3 downto 0):=(others=>'0');
signal opcode_q: std_logic_vector (3 downto 0);
signal transfer : std_logic_vector (3 downto 0);
signal mode_FA_q: std_logic;
signal RST_Line_q: std_logic:='0';

for tester: Selector_FA use entity work.Selector_FA;

begin
      
        tester : Selector_FA
        generic map ( N => 2)
        port map
        (
          Mac_input=>mac_input_q, 
          RST_input=>RST_input_q, 
          inputBusB=>inB_tmp, 
          opcode=>opcode_q, 
          mode_FA=>mode_FA_q, 
          inputToPass_FA=>transfer, 
          RST_Line=>RST_Line_q
        );
        
          process
          begin
            mac_input_q <= "0001";
            inB_tmp <= "10";
            opcode_q<="0000";
            wait for 2 ns;
        end process ;
end rtl;






