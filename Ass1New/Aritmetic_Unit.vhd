library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;


entity Aritmetic_Unit is generic(

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
end Aritmetic_Unit;

architecture Arch_Aritmetic_Unit of Aritmetic_Unit is
  
  component MAC_struct is generic(

  N : integer := 8
  
);

port (

  clk,RST : in std_logic;
	inputA, selector_MUL_in: in std_logic_vector(N-1 downto 0);	
	selector_FA_in: in std_logic_vector(2*N-1 downto 0);
	output2N: out std_logic_vector (2*N-1 downto 0)	
		
	);-- ports declerations
end component;


component Selector_MUL is generic(

N : integer := 8	

);

port (

	inputBusB: in std_logic_vector(2*N-1 downto 0) := (others =>'0');
	ADD_input: in std_logic_vector(2*N-1 downto 0) := (others =>'1'); --B*1 = B and then goes to FA to do A+B*1
	opcode: in std_logic_vector(3 downto 0);
	inputToPass_MUL: out std_logic_vector(2*N-1 downto 0)
		
	);-- ports declerations
end component;


component Selector_FA is generic(

N : integer := 8	

);

port (

	inputBusB, Mac_input, RST_input: in std_logic_vector(2*N-1 downto 0) := (others =>'0');
	opcode: in std_logic_vector(3 downto 0);
	mode_FA: out std_logic;--Add/Sub bit 0-add 1-sub
	inputToPass_FA: out std_logic_vector(2*N-1 downto 0);
	RST_Line: out std_logic := '0'
		
	);-- ports declerations
end component;
   
component nX2_Bit_Full_Adder is generic(

N : integer := 8	

);

port (

	inputBusA, inputBusB : in std_logic_vector(2*N-1 downto 0);
	carryIn : in std_logic;
	carryOut2N: out std_logic;	
	resultnX2: out std_logic_vector(2*N-1 downto 0)
		
	);-- ports declerations
end component;

component n_Bit_Multiplication_behavioral is generic(

N : integer := 8	

);

port (

	inputBusA, inputBusB: in std_logic_vector(N-1 downto 0);
	result: out std_logic_vector(2*N-1 downto 0):=(others=>'0')
		
	);-- ports declerations
end component;
   
   
   signal RST_Line_tmp: std_logic := '0'; 
   signal Add_input_tmp: std_logic_vector(N-1 downto 0):=(0 => '1', others =>'0');--SENDING 1-es to MUL in ADD COMMAND
   signal out_sel_mul: std_logic_vector(N-1 downto 0):=(others =>'0'); 
   signal out_sel_fa: std_logic_vector(2*N-1 downto 0):=(others =>'0'); 
   signal Mac_out:  std_logic_vector(2*N-1 downto 0):=(others =>'0');
   signal mode_FA_tmp: std_logic := '0';
   signal Aritmetic_Unit_output_MUL_tmp: std_logic_vector(2*N-1 downto 0):=(others =>'0');
   signal Aritmetic_Unit_output_FA_tmp: std_logic_vector(2*N-1 downto 0):=(others =>'0');
   
  begin
   
MAC_mapping: MAC_struct generic map (N => N)
                           port map (clk => clk,
                                     RST => RST_Line_tmp,
                                     inputA => InputBusA, 
                                     selector_MUL_in => out_sel_mul,
                                     selector_FA_in => out_sel_fa,
                                     output2N => Mac_out
                                   ); 
                                   
FA_Sel_mapping: Selector_FA generic map (N => N)
                               port map (inputBusB => InputBusB,
                                         Mac_input => Mac_out,--in->DFF_MAC_OUT
                                         RST_input => (others => '0'),
                                         opcode => Opcode,
                                         mode_FA => mode_FA_tmp,
                                         inputToPass_FA => out_sel_fa,
                                         RST_Line => RST_Line_tmp
                                       );                                 

MUL_Sel_mapping: Selector_MUL generic map (N => N)
                                port map (inputBusB => InputBusB,
                                          ADD_input => Add_input_tmp,--in->DFF_MAC_OUT
                                          opcode => Opcode,
                                          inputToPass_MUL => out_sel_mul
                                         );   
                                         
                                         
FA_mapping: nX2_Bit_Full_Adder generic map (N => N)
                                  port map (inputBusA => Aritmetic_Unit_output_MUL_tmp,
                                            inputBusB => out_sel_fa,
                                            carryIn => mode_FA_tmp,
                                            resultnX2 => Aritmetic_Unit_output_FA_tmp
                                         ); 
                                         
 MUL_mapping: n_Bit_Multiplication_behavioral generic map (N => N)
                                                 port map (inputBusA => InputBusA,
                                                           inputBusB => out_sel_mul,
                                                           result => Aritmetic_Unit_output_MUL_tmp
                                                );                                         
                 
 --Output setter                               
process(Aritmetic_Unit_output_FA_tmp,Aritmetic_Unit_output_MUL_tmp,Mac_out)  
  begin
           Aritmetic_Unit_output_FA <= Aritmetic_Unit_output_FA_tmp;
           Aritmetic_Unit_output_MUL <= Aritmetic_Unit_output_MUL_tmp;
           Aritmetic_Unit_output_MAC <= Mac_out;
           
  end process;

                                                                                                               
end Arch_Aritmetic_Unit;