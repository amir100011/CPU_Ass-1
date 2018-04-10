library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity n_Bit_Full_Adder is generic(

N : integer := 8	

);

port (

	inputBusA, inputBusB : in std_logic_vector(N-1 downto 0);
	carryIn : in std_logic;
	carryOutN: out std_logic;	
	result: out std_logic_vector(N-1 downto 0)
		
	);-- ports declerations
end n_Bit_Full_Adder;

architecture Arch_N_Bit_Full_Adder of n_Bit_Full_Adder is
  
  component Full_Adder_Struct is port(
 	
 	digitA, digitB, carryIn: in std_logic;	
	carryOut, result: out std_logic	
  
  );
end component;  

component xor_Gate port(
	 bitA,bitB : in std_logic;	
	resultXor  : out std_logic
	); 
end component; 

signal carryArray: std_logic_vector(N downto 0);--describes all the carries we have in the system 
signal subtractorConvertArray: std_logic_vector(N-1 downto 0); 
--describes NOT (inputbusB)  for subtracting operation, if addition is needed has no affect

begin
  
carryArray(0) <= carryIn;
AddersBuilder: for Index in 0 to N - 1 generate
  N_Xors : xor_Gate port map(
    bitA => carryArray(0),
    bitB => inputBusB(Index),
    resultXor => subtractorConvertArray(Index));--inputBusB NOT if subtract or InputBusB if addition
  N_Adders : Full_Adder_Struct port map(
  digitA => inputBusA(Index),
  digitB => subtractorConvertArray(Index),--for converting into subtractor mode 1-subtractor, 0- adder
  carryIn => carryArray(Index),
  result => result(Index),
  carryOut => carryArray(Index + 1));
end generate;
 
 carryOutN <= (carryArray(N) xor carryArray(0));--for converting into subtractor mode 1-subtractor, 0- adder
 end Arch_N_Bit_Full_Adder;