library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity MAC_struct is generic(

  N : integer := 8
  
);

port (

  clk,RST,enable : in std_logic:='0';
	inputA, selector_MUL_in: in std_logic_vector(N-1 downto 0);	
	selector_FA_in: in std_logic_vector(2*N-1 downto 0);
	output2N: out std_logic_vector (2*N-1 downto 0):=(others => '0')	
		
	);-- ports declerations
end MAC_struct;

architecture Arch_MAC_struct of MAC_struct is

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
  
component n_Bit_Multiplication_behavioral is generic(
  
  N: integer := 8
  
);

port (

	inputBusA, inputBusB: in std_logic_vector(N-1 downto 0);
	result: out std_logic_vector(2*N-1 downto 0)
		
	);-- ports declerations
end component;

component D_FlipFlop is generic(

  N : integer := 8
  
);

port (

  clk,RST : in std_logic;
	input: in std_logic_vector(2*N-1 downto 0) := (others=>'0');	
	output: out std_logic_vector(2*N-1 downto 0) := (others=>'0')	
		
	);-- ports declerations
end component;
  
  signal inA_tmp,inB_tmp : std_logic_vector(N-1 downto 0):=(others=>'0');
  signal transfer : std_logic_vector(2*N-1 downto 0):=(others=>'0');
  signal carryOut2N_tmp : std_logic;
  signal resualt_FA, resualt_MUL: std_logic_vector(2*N-1 downto 0):=(others=>'0');

 begin
 
 
 inA_tmp <= inputA;
   
MUL: n_Bit_Multiplication_behavioral generic map(N => N)
port map(inputBusB => selector_MUL_in, inputBusA => inA_tmp ,  result => resualt_MUL);
FA: nX2_Bit_Full_Adder generic map (N=>N)
port map (inputBusB => selector_FA_in, inputBusA => resualt_MUL, carryIn => '0', carryOut2N => carryOut2N_tmp, resultnX2 => resualt_FA);
--DFF: D_FlipFlop generic map (N=>N)
--port map (clk => clk, input => resualt_FA, output => dff_tmp_out,RST=>RST);

  
process (clk,enable) is

begin 
  if (rising_edge(clk)) then
      if RST='1' then
       output2N <= (others => '0'); -- reset accumulated value to 0
   --if enable = '1' then	 
      else
        if(enable = '1') then  
		      output2N <= resualt_FA;
        end if;
  end if;
end if;
	-- end if;
end process;

 end Arch_MAC_struct;  





