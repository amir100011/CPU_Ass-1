-- ====================================================================
--
--	File Name:		Test_D_FlipFlop.vhd
--	Description:	Test bench for counter 
--					
--
--	Date:			30/03/2018
--	Designer:		Amir Tsur
--
-- ====================================================================
-- Test Bench for D_FlipFlop_MemoryReg.

library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;



entity D_FlipFlop_TB is
end D_FlipFlop_TB;

architecture rtl of D_FlipFlop_TB is  

component D_FlipFlop generic(
  
N : integer := 8
  
);

port (

  clk,enable : in std_logic;
	input: in std_logic_vector(4*N-1 downto 0);	
	output: out std_logic_vector (4*N-1 downto 0)	
		
	);-- ports declerations
end component;  

constant numOfClockCounter: integer := 100000;
signal  clk : std_logic;
signal  transfer, inA_tmp: std_logic_vector (3 downto 0);
begin
        tester : D_FlipFlop
        generic map ( N => 1)
        port map(clk=>clk, output=>transfer, input=>inA_tmp, enable => '1');
        
        clock: process 
        begin
                clk <= '0';
                inA_tmp <= "1010";
                for i in 0 to numOfClockCounter loop 
                        wait for 1 ns;
                        clk <= not clk;	
                        if (i mod 2 = 0) then
                        inA_tmp <= not inA_tmp;		 
                      end if;
                end loop;
                wait;
        end process clock;
end rtl;


