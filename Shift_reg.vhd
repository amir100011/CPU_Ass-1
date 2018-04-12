library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Shift_reg is generic(

  N : integer := 8
  
);

port (

  right_left : in std_logic;--0->right, 1->left
	inputA, inputB: in std_logic_vector(N-1 downto 0);	
	output,output1: out std_logic_vector (31 downto 0)	
		
	);-- ports declerations
end Shift_reg;

architecture Arch_Shift_reg of Shift_reg is
   
  signal output_tmp,output_tmp1: std_logic_vector(31 downto 0);
  signal input_tmp: std_logic_vector (N-1 downto 0):= inputA;

  begin

process (right_left) is


  variable A_tmp,B_tmp: std_logic_vector(31 downto 0);


    begin
      
    A_tmp := std_logic_vector(resize(signed(input_tmp),output'length));
      
    if (right_left = '1') then
--  Shifter: for i in 0 to inputB'length loop
  B_tmp := std_logic_vector(shift_left(unsigned(A_tmp),to_integer(unsigned(inputB))));
   output_tmp <= std_logic_vector(shift_left(unsigned(A_tmp),to_integer(unsigned(inputB))));
--  end loop;
  end if;
output_tmp1<=B_tmp;

end process;

output<=output_tmp;
output1<=output_tmp1;

end Arch_Shift_reg;
  


