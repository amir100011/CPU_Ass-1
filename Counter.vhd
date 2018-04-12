-- ====================================================================
--
--	File Name:		counter.vhd
--	Description:	counter 
--					
--
--	Date:			15/03/2013
--	Designer:		Boris Braginsky
--
-- ====================================================================


-- libraries decleration
library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all; 
use ieee.std_logic_arith.all;

entity counter is port (
	clk,enable : in std_logic;	
	q          : out std_logic_vector (7 downto 0)); 
end entity;
-- Architecture Definition
architecture rtl of counter is
signal q_int : std_logic_vector (31 downto 0);
begin                                         
-- Design Body
process (clk)
begin
if (rising_edge(clk)) then
  if (enable = '1') then	   
		  q_int <= q_int + 1;
end if;
	end if;
end process;
q <= q_int (7 downto 0);
end rtl;
