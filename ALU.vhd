library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;


entity ALU is generic(
N:integer:=8
);
  port(
        A,B : in std_logic_vector(N-1 downto 0);
        opcode_in:in std_logic_vector(3 downto 0);
        clk_in: in std_logic;
        HI,LO:out std_logic_vector(N-1 downto 0);
        STATUS :out std_logic_vector (5 downto 0)
  );
end ALU;
architecture Arch_ALU of ALU is
    
  component Aritmetic_Unit is generic(
    N:integer:=8
    );
    
  port (

  Opcode:                        in std_logic_vector(3 downto 0);--9 actions availible
  InputBusA:                     in std_logic_vector(N-1 downto 0);
  InputBusB:                     in std_logic_vector(N-1 downto 0);
  clk:                           in std_logic;
	Aritmetic_Unit_output_MUL:     out std_logic_vector(2*N-1 downto 0);
	Aritmetic_Unit_output_MAC:     out std_logic_vector(2*N-1 downto 0); 
	Aritmetic_Unit_output_MIN_MAX: out std_logic_vector(2*N-1 downto 0);
	Aritmetic_Unit_output_FA:      out std_logic_vector(2*N-1 downto 0)	
		
	);-- ports declerations
	end component;
	component Shift_reg_MUXER is generic(
	  N:integer:=8
	  );
	  port (

    right,En: in std_logic;--1->right, 0->left
	  inputA: in std_logic_vector(N-1 downto 0);
	  Shift: in std_logic_vector(4 downto 0);	
	  output1: out std_logic_vector (2*N-1 downto 0)
		
	     );-- ports declerations
	     end component;
	     
	 component Output_Selector is generic(
	   N:integer:=8
	   );
	   port(
    signal opcode : in std_logic_vector(3 downto 0);
    signal FA_out,MIN_MAX_out : in std_logic_vector(2*N-1 downto 0);
    signal MUL_out,MAC_out,SHIFT_out : in std_logic_vector(2*N-1 downto 0);
    signal LO,HI:out std_logic_vector(N-1 downto 0)
    );
  	end component;
  	
  	
  	signal ARU_FA_out: std_logic_vector(2*N-1 downto 0);
  	signal ARU_MIN_MAX_out: std_logic_vector(2*N-1 downto 0);
  	signal ARU_MAC_out: std_logic_vector(2*N-1 downto 0);
  	signal ARU_MUL_out: std_logic_vector(2*N-1 downto 0);
  	signal Shift_out : std_logic_vector(2*N-1 downto 0);
  	signal LO_trans,HI_trans: std_logic_vector(N-1 downto 0);
  	
  	begin
  	  
  	  LO<=LO_trans;
  	  HI<=HI_trans;
  	  
  	  ARU: Aritmetic_Unit generic map(N=>N)
	                       port map(Opcode=>opcode_in,InputBusA=>A,
	                                InputBusB=>B,clk=>clk_in,
  	                               Aritmetic_Unit_output_MUL=>ARU_MUL_out,
  	                               Aritmetic_Unit_output_MAC=>ARU_MAC_out,
  	                               Aritmetic_Unit_output_MIN_MAX=>ARU_MIN_MAX_out,
	                                Aritmetic_Unit_output_FA=>ARU_FA_out
	                               );
	   SHIFT:Shift_reg_MUXER  generic map(N=>N)
	                          port map(right=>opcode_in(0),
	                                   En=>opcode_in(3),inputA=>A,
	                                   Shift=>B(4 downto 0),
	                                   output1=>Shift_out
	                                  );
	   SELECT1:Output_Selector generic map(N=>N)
                        	    port map(opcode=>opcode_in,
	                                    SHIFT_out=>Shift_out,
	                                    FA_out=>ARU_FA_out,
	                                    MUL_out=>ARU_MUL_out,
	                                    MAC_out=>ARU_MAC_out,
	                                    MIN_MAX_out=>ARU_MIN_MAX_out,
	                                    LO=>LO_trans,
	                                    HI=>HI_trans
	                                   );
	  end Arch_ALU;  
	          
	
	     
	    
	  
	 
  
    
    

