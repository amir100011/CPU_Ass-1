library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity D_FlipFlop is generic(

  N : integer := 8
  
);

port (

  clk,enable : in std_logic;
	input: in std_logic_vector(4*N-1 downto 0);	
	output: out std_logic_vector (4*N-1 downto 0)	
		
	);-- ports declerations
end D_FlipFlop;

architecture Arch_D_FlipFlop of D_FlipFlop is
  
  signal transfer : std_logic_vector(4*N-1 downto 0);
 
 begin
  
process (clk,enable)
  begin
    
  if (rising_edge(clk)) then
    if (enable = '1') then	 
		transfer <= input;
		output <= transfer;		
  end if;
 end if;
  end process;


 end Arch_D_FlipFlop;  



