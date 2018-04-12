--
--	File Name:		Output_selector.vhd
--	Description:	Output selector is responsible for muxing the outputs of the diffrenet modules
-- to the outputs of the ALU
--	Inputs:all the outputs of the ALU
-- Outputs: LO N bit register
--          HI N bit register(probabaly used only when using shift, mac and MUL				
--
--	Date:			10/04/2018
--	Designer:		Dor Livne
--
-- ====================================================================
library ieee;
use ieee.std_logic_1164.all;

entity Output_Selector is generic(
N: integer:=8
);
  port(
    signal opcode : in std_logic_vector(3 downto 0);
    signal FA_out,MIN_MAX_out : in std_logic_vector(2*N-1 downto 0);
    signal MUL_out,MAC_out,SHIFT_out : in std_logic_vector(2*N-1 downto 0);
    signal LO,HI:out std_logic_vector(N-1 downto 0)
  );
end Output_Selector;

architecture dataflow of Output_Selector is
  component Mux8_1 
    port(
      CTRL : in std_logic_vector(3 downto 0);
      I0,I1,I2,I3,I4,I5,I6,I7,I8: in std_logic;
      O:out std_logic
    );
  end component;
  signal transferLO,transferHI :std_logic_vector(N-1 downto 0);
  
begin
  LO<=transferLO;
  HI<=transferHI;
  LO_REG: for i in 0 to N-1 generate
          CONSTRUCTLO:Mux8_1
          port map(CTRL=>opcode,I0=>FA_out(i),I1=>FA_out(i),I2=>MUL_out(i),I3=>MIN_MAX_out(i),I4=>MAC_out(i),I5=>'0',I6=>SHIFT_out(i),I7=>MIN_MAX_out(i),I8=>SHIFT_out(i),O=>transferLO(i));
        end generate LO_REG;
  HI_REG: for i in N to 2*N-1 generate
          CONSTRUCTHI:Mux8_1
          port map(CTRL=>opcode,I0=>FA_out(i),I1=>FA_out(i),I2=>MUL_out(i),I3=>MIN_MAX_out(i),I4=>MAC_out(i),I5=>'0',I6=>SHIFT_out(i),I7=>MIN_MAX_out(i),I8=>SHIFT_out(i),O=>transferHI(i-N));    
      end generate HI_REG;
    end dataflow;


    


