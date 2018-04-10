library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;



entity Selector_MUL is generic(

N : integer := 8	

);

port (

	inputBusB: in std_logic_vector(N-1 downto 0) := (others =>'0');
	ADD_input: in std_logic_vector(N-1 downto 0) := (others =>'1'); --B*1 = B and then goes to FA to do A+B*1
	opcode: in std_logic_vector(3 downto 0);
	inputToPass_MUL: out std_logic_vector(N-1 downto 0):=(0 => '1',others => '0')
		
	);-- ports declerations
end Selector_MUL;

architecture behavioral_Arch of Selector_MUL is
  
  begin
    
    process(opcode)
      begin
        
      case opcode is
        
        when "0100" =>  inputToPass_MUL <= inputBusB;--MAC
        when "0010" =>  inputToPass_MUL <= inputBusB;--MUL              
        when others => inputToPass_MUL <= ADD_input;--all other options we deliver A to FA
               
      end case;
end process;

end behavioral_Arch;




