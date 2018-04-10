
--
--	File Name:		Mux4_1.vhd
--	Description:	Mux4_1 
--					
--
--	Date:			08/04/2018
--	Designer:		Dor Livne
--
-- ====================================================================
library ieee;
use ieee.std_logic_1164.all;

entity mux4_1 is
port(
  I0,I1,I2,I3,S1,S2 : in std_logic;
  O:out std_logic
);
end mux4_1;

architecture dataflow of mux4_1 is
  signal out_trans:std_logic;
  begin
    O<=out_trans;
    process(I0,I1,I2,I3,S1,S2) is
      begin
   if(S1 = '0') and (S2 ='0')  then
    out_trans<=I0;
  end if;
  if(S1 = '1') and (S2 ='0')  then
    out_trans<=I0;
  end if;
  if(S1 = '0') and (S2 ='1')  then
    out_trans<=I2;
  end if;
  if(S1 = '1') and (S2 ='1')  then
    out_trans<=I3;
  end if;
end process;
end dataflow;

 
  
  

  


