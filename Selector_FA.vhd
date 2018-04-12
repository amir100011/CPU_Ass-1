library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;



entity Selector_FA is generic(

N : integer := 8	

);

port (

	Mac_input, RST_input: in std_logic_vector(2*N-1 downto 0) := (others =>'0');
	inputBusB: in std_logic_vector(N-1 downto 0);
	opcode: in std_logic_vector(3 downto 0);
	mode_FA: out std_logic;--Add/Sub bit 0-add 1-sub
	inputToPass_FA: out std_logic_vector(2*N-1 downto 0);
	RST_Line: out std_logic := '0';
	Mac_enable: out std_logic := '0';
	min_max_mode: out std_logic :='0'
		
	);-- ports declerations
end Selector_FA;

architecture behavioral_Arch of Selector_FA is
  
  
  
  begin
  
  
    
    process(opcode,Mac_input,RST_input,inputBusB)
      
      variable inputBusB_resized: std_logic_vector(2*N-1 downto 0);
      
      
      begin
        
        inputBusB_resized := std_logic_vector(resize(signed(inputBusB),inputBusB_resized'length));
        
        
      case opcode is
        when "0000" =>  inputToPass_FA <= inputBusB_resized;--ADD
                        RST_Line <= '0';--RST->connected to DFF, reset line
                        mode_FA <= opcode(0);--0 
                        Mac_enable <= '0';
                        
        when "0001" =>  inputToPass_FA <= inputBusB_resized;--SUB
                        RST_Line <= '0';--RST->connected to DFF, reset line
                        mode_FA <= opcode(0);--1
                        Mac_enable <= '0';
                        
        when "0011" =>  inputToPass_FA <= inputBusB_resized;--MIN
                        RST_Line <=  '0';--RST->connected to DFF, reset line
                        mode_FA <= opcode(0);--1
                        min_max_mode <= opcode(3); --0
                        Mac_enable <= '0';
                        
        when "0111" =>  inputToPass_FA <= inputBusB_resized;--MAX
                        RST_Line <=  '0';--RST->connected to DFF, reset line
                        mode_FA <= opcode(0);--1
                        min_max_mode <= opcode(3); --1
                        Mac_enable <= '0';
                        
        when "0100" =>  inputToPass_FA <= Mac_input;--MAC
                        RST_Line <=  '0';--RST->connected to DFF, reset line
                        mode_FA <= opcode(0);--1
                        Mac_enable <= '1';
                        
        when "0101" =>  inputToPass_FA <= RST_input;--RST
                        RST_Line <= '1';--RST->connected to DFF, reset line
                        mode_FA <= opcode(0);--0  
                        Mac_enable <= '0';  
                                   
        when others =>  inputToPass_FA <= RST_input;--MUL/SHR/SHL -> FA should get 0-es
                        RST_Line <= '0';--RST->connected to DFF, reset line
                        mode_FA <= opcode(0);--DON'T CARE 
                        Mac_enable <= '0';              

      end case;
end process;

end behavioral_Arch;


