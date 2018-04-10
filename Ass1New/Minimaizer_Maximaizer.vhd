library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Minimazier_Maximaizer is generic(

  N : integer := 8
  
);

port (

  mode:                  in std_logic;--1<=max,0<=min
  enable:                in std_logic;
  clk:                   in std_logic;
	MinMaxA_In:            in std_logic_vector(2*N-1 downto 0);	
	MinMaxB_In:            in std_logic_vector(2*N-1 downto 0);	
	Min_Max_output:        out std_logic_vector(2*N-1 downto 0)	
		
	);-- ports declerations
end Minimazier_Maximaizer;


architecture Arch_Minimazier_Maximaizer of Minimazier_Maximaizer is

	component nX2_Bit_Full_Adder is generic(
   
   N : integer := 8

   ); 
 
  port(
 	
	inputBusA, inputBusB : in std_logic_vector(2*N-1 downto 0);
	carryIn : in std_logic;
	carryOut2N: out std_logic;	
	resultnX2: out std_logic_vector(2*N-1 downto 0)
  
  );
end component;


  signal inA_tmp,inB_tmp : std_logic_vector(2*N-1 downto 0):=(others=>'0');
  signal transfer, dff_tmp_out : std_logic_vector(2*N-1 downto 0):=(others=>'0');
  signal carryOut2N_tmp : std_logic;
  signal result_FA, resualt_MUL: std_logic_vector(2*N-1 downto 0):=(others=>'0');
 
 begin
 
 
 inA_tmp <= MinMaxA_In;
 inB_tmp <= MinMaxB_In;

FA: nX2_Bit_Full_Adder generic map (N=>N)
port map (inputBusA => inA_tmp, 
          inputBusB => inB_tmp, 
          carryIn => '1', --substractor
          carryOut2N => carryOut2N_tmp, 
          resultnX2 => result_FA
          );
          

process(result_FA,enable,clk) is
  variable result_FA_sign_bit: integer;
  begin
    if(rising_edge(clk)) then
     if (enable = '1') then
      result_FA_sign_bit :=result_FA'length - 1;--getting the sign bit 
      --if statment: Mode = Max & A>B or Mode = Min & A<B, equality returns B always
        if (result_FA(result_FA_sign_bit) = '1' and (mode = '0')) or (result_FA(result_FA_sign_bit) = '0' and (mode = '1')) then --
          Min_Max_output <= inA_tmp;
      --else statment: Mode = Min & A>B or Mode = Max & A<B or A=B
        else
          Min_Max_output <= inB_tmp;
        end if;
      end if;
    end if;
  end process;


end Arch_Minimazier_Maximaizer;
          
          
  
  
  
  
  
  
  
  