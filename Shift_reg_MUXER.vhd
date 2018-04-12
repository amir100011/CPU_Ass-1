--
--	File Name:		Shift_Unit.vhd
--	Description:	Shift register structural 
--					
--
--	Date:			08/04/2018
--	Designer:		Dor Livne
--
-- ====================================================================
-- Description:
-- signals:
-- right_left->decides the orienation of the shift
-- inputA ->the binary number to be shifted
-- Shift->number of shift to be made.
-- En -> Enable
-- output_exit-> output



library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Shift_reg_MUXER is generic(

  N : integer := 8
  
);

port (

  right,En: in std_logic;--1->right, 0->left
	inputA: in std_logic_vector(N-1 downto 0);
	Shift: in std_logic_vector(4 downto 0);	
	output1: out std_logic_vector (2*N-1 downto 0)
		
	);-- ports declerations
end Shift_reg_MUXER;

architecture dataflow of Shift_reg_MUXER is
  component Mux4_1
   port(
  I0,I1,I2,I3,S1,S2 : in std_logic;
  O:out std_logic
  );
end component;
  signal In0 : std_logic_vector(31 downto 0);
  signal Out0In1 : std_logic_vector(31 downto 0);
  signal Out1In2 : std_logic_vector(31 downto 0);
  signal Out2In3 : std_logic_vector(31 downto 0);    
	signal Out3In4 : std_logic_vector(31 downto 0);
	signal Out4 : std_logic_vector(31 downto 0);
	signal C0: std_logic;
	signal C1: std_logic;
	signal C2: std_logic;
	signal C3: std_logic;
	signal C4: std_logic;
	signal CTRL1: std_logic;
	begin
	  In0<=std_logic_vector(resize(unsigned(inputA),32));
	  --In0<=inputA;
	  C0<=En and Shift(0);
	  C1<=En and Shift(1);
	  C2<=En and Shift(2);
	  C3<=En and Shift(3);
	  C4<=En and Shift(4);
	  output1<=Out4(2*N-1 downto 0);
	  CTRL1<=right;--0 move left 1 move right
	  
	  SHIFT_BIT0: for i in 0 to 31 generate
	   LOWERBOUND0:if i = 0 generate
	       MUX00:Mux4_1 
	       port map (I0=>In0(0),I1=>In0(0),I2=>'0',I3=>In0(1),S1=>CTRL1,S2=>C0,O=>Out0In1(0));--in case of moving left aka CTL1=0
	       end generate LOWERBOUND0;
	   MUX_ARRAY0: if (i > 0) and (i < 31) generate
	       ARRAY0:Mux4_1  
	       port map (I0=>In0(i),I1=>In0(i),I2=>In0(i-1),I3=>In0(i+1),S1=>CTRL1,S2=>C0,O=>Out0In1(i));
	       end generate MUX_ARRAY0;
	   UPPERBOUND0:if i = 31 generate
	       MUX0N:Mux4_1 
	       port map (I0=>In0(31),I1=>In0(31),I2=>In0(30),I3=>'0',S1=>CTRL1,S2=>C0,O=>Out0In1(31));
	       end generate UPPERBOUND0;
	   end generate SHIFT_BIT0;
	   
	  SHIFT_BIT1: for i in 0 to 31 generate
	   LOWERBOUND1:if (i >= 0) and (i <= 1) generate
	       MUX10:Mux4_1 
	       port map (I0=>Out0In1(i),I1=>Out0In1(i),I2=>'0',I3=>Out0In1(i+2),S1=>CTRL1,S2=>C1,O=>Out1In2(i));
	       end generate LOWERBOUND1;
	   MUX_ARRAY1: if (i > 1 ) and (i < 30) generate
	       ARRAY1:Mux4_1  
	       port map (I0=>Out0In1(i),I1=>Out0In1(i),I2=>Out0In1(i-2),I3=>Out0In1(i+2),S1=>CTRL1,S2=>C1,O=>Out1In2(i));
	       end generate MUX_ARRAY1;
	   UPPERBOUND1: if  (i >= 30) and (i <= 31) generate
	       MUX1N:Mux4_1 
	       port map (I0=>Out0In1(i),I1=>Out0In1(i),I2=>Out0In1(i-2),I3=>'0',S1=>CTRL1,S2=>C1,O=>Out1In2(i));
	       end generate UPPERBOUND1;
	   end generate SHIFT_BIT1;
	   
	  SHIFT_BIT2: for i in 0 to 31 generate
	   LOWERBOUND2:if (i >= 0) and (i <= 3) generate
	       MUX20:Mux4_1 
	       port map (I0=>Out1In2(i),I1=>Out1In2(i),I2=>'0',I3=>Out0In1(i+4),S1=>CTRL1,S2=>C2,O=>Out2In3(i));
	       end generate LOWERBOUND2;
	   MUX_ARRAY2: if (i > 3 ) and (i < 28) generate
	       ARRAY2:Mux4_1  
	       port map (I0=>Out1In2(i),I1=>Out1In2(i),I2=>Out1In2(i-4),I3=>Out1In2(i+4),S1=>CTRL1,S2=>C2,O=>Out2In3(i));
	       end generate MUX_ARRAY2;
	   UPPERBOUND2: if  (i >= 28) and (i <= 31) generate
	       MUX2N:Mux4_1 
	       port map (I0=>Out1In2(i),I1=>Out1In2(i),I2=>Out1In2(i-4),I3=>'0',S1=>CTRL1,S2=>C2,O=>Out2In3(i));
	       end generate UPPERBOUND2;
	   end generate SHIFT_BIT2;
	   
    SHIFT_BIT3: for i in 0 to 31 generate
	   LOWERBOUND3:if (i >= 0) and (i <= 7) generate
	       MUX30:Mux4_1 
	       port map (I0=>Out2In3(i),I1=>Out2In3(i),I2=>'0',I3=>Out2In3(i+8),S1=>CTRL1,S2=>C3,O=>Out3In4(i));
	       end generate LOWERBOUND3;
	   MUX_ARRAY3: if (i > 7 ) and (i < 24) generate
	       ARRAY3:Mux4_1  
	       port map (I0=>Out2In3(i),I1=>Out2In3(i),I2=>Out2In3(i-8),I3=>Out2In3(i+8),S1=>CTRL1,S2=>C3,O=>Out3In4(i));
	       end generate MUX_ARRAY3;
	   UPPERBOUND3: if  (i >= 24) and (i <= 31) generate
	       MUX3N:Mux4_1 
	       port map (I0=>Out2In3(i),I1=>Out2In3(i),I2=>Out2In3(i-8),I3=>'0',S1=>CTRL1,S2=>C3,O=>Out3In4(i));
	       end generate UPPERBOUND3;
	   end generate SHIFT_BIT3;
	   
	   SHIFT_BIT4: for i in 0 to 31 generate
	   LOWERBOUND4:if (i >= 0) and (i <= 15) generate
	       MUX40:Mux4_1 
	       port map (I0=>Out3In4(i),I1=>Out3In4(i),I2=>'0',I3=>Out3In4(i+16),S1=>CTRL1,S2=>C4,O=>Out4(i));
	       end generate LOWERBOUND4;
	   MUX_ARRAY4: if (i > 15) and (i < 16) generate
	       ARRAY4:Mux4_1  
	       port map (I0=>Out3In4(i),I1=>Out3In4(i),I2=>Out3In4(i-16),I3=>Out3In4(i+16),S1=>CTRL1,S2=>C4,O=>Out4(i));
	       end generate MUX_ARRAY4;
	   UPPERBOUND4: if  (i >= 16) and (i <= 31) generate
	       MUX4N:Mux4_1 
	       port map (I0=>Out3In4(i),I1=>Out3In4(i),I2=>Out3In4(i-16),I3=>'0',S1=>CTRL1,S2=>C4,O=>Out4(i));
	       end generate UPPERBOUND4;
	   end generate SHIFT_BIT4;
	end dataflow;
	    
	    
	  
	  
	    

	
	    
	





