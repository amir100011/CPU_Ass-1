--
--	File Name:		Shift_Unit_TB.vhd
--	Description:	Test bench for counter 
--					
--
--	Date:			30/03/2018
--	Designer:		Amir Tsur
--
-- ====================================================================
-- Test Bench for Shift_Unit.

library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;



entity Shift_Reg_Working_TB is
end Shift_Reg_Working_TB;

architecture rtl of Shift_Reg_Working_TB is  

component Shift_Reg_Working generic(
  
  N : integer := 8
  
);

port (
  
    clk:            in std_logic; 
    reset:          in std_logic; 
    enable:         in std_logic;    --enables shifting
    direction:      in std_logic;    --right/left shifting
    Num2Shift:      in std_logic_vector(N-1 downto 0);
    NumOfShifts:    in std_logic_vector(N-1 downto 0);--there is no saturation option
    output_Shift:   out std_logic_vector(31 downto 0):=(others=>'0')   --serial output
    );
end component;  

signal  inA_tmp, inB_tmp: std_logic_vector (1 downto 0);
signal transfer : std_logic_vector (31 downto 0);
signal direction_q: std_logic;
signal reset_q: std_logic:='0';

for tester: Shift_Reg_Working use entity work.Shift_Reg_Working;

begin
      
        tester : Shift_Reg_Working
        generic map ( N => 2)
        port map
        (
          clk=>'1', 
          Num2Shift=>inA_tmp, 
          NumOfShifts=>inB_tmp, 
          output_Shift=>transfer, 
          reset=>reset_q, 
          direction=>direction_q, 
          enable=>'1'
        );
        
          process
          begin
            inA_tmp <= "01";
            inB_tmp <= "10";
            direction_q<='1';
            wait for 2 ns;
            inA_tmp <= "10";
            inB_tmp <= "01";
            direction_q<='0';
            wait for 2 ns;
        end process ;
end rtl;




