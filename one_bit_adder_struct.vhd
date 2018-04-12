library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Full_Adder_Struct is port (

	digitA, digitB, carryIn: in std_logic;	
	carryOut: out std_logic;	
	result: out std_logic
		
	);-- ports declerations
end Full_Adder_Struct;

architecture Arch_Full_Adder of Full_Adder_Struct is
  
  signal resultAnd2_tmp,resultXor_tmp, resultAnd_tmp, resultOr_tmp: std_logic;
   
component or_Gate is 
    port (
	       bitA,bitB : in std_logic;	
	       resultOr   : out std_logic
	       ); 
  end component;
  
component and_Gate is 
    port (
	       bitA,bitB : in std_logic;	
	       resultAnd   : out std_logic
	       ); 
  end component;  
  
component xor_Gate is 
    port (
	       bitA,bitB : in std_logic;	
	       resultXor   : out std_logic
	       ); 
  end component;  
  begin
  
 Gate0: xor_Gate port map (bitA=>digitA, bitB=>digitB, resultXor=>resultXor_tmp);
 Gate1: xor_Gate port map (bitA=>resultXor_tmp, bitB=>CarryIn, resultXor=>result);
 Gate2: and_Gate port map (bitA=>resultXor_tmp, bitB=>CarryIn, resultAnd=>resultAnd_tmp);
 Gate3: and_Gate port map (bitA=>digitA, bitB=>digitB, resultAnd=>resultAnd2_tmp);
 Gate4: or_Gate port map (bitA=>resultAnd_tmp, bitB=>resultAnd2_tmp, resultOr=>carryOut);
 
 end Arch_Full_Adder;  


