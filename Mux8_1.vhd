

--
--	File Name:		Mux8_1.vhd
--	Description:	Mux8_1 
--					
--
--	Date:			10/04/2018
--	Designer:		Dor Livne
--
-- ====================================================================
library ieee;
use ieee.std_logic_1164.all;

entity mux8_1 is
port(
  CTRL : in std_logic_vector(3 downto 0);
  I0,I1,I2,I3,I4,I5,I6,I7,I8: in std_logic;
  O:out std_logic
);
end mux8_1;

architecture dataflow of mux8_1 is
  signal out_trans:std_logic;
  begin
    O<=out_trans;
    process(I0,I1,I2,I3,I4,I5,I6,I7,CTRL) is
      begin
   if(CTRL(0) = '0') and (CTRL(1) ='0') and (CTRL(2) ='0') and (CTRL(3)='0')  then
    out_trans<=I0;
  end if;
  if(CTRL(0) = '1') and (CTRL(1) ='0') and (CTRL(2) ='0')and (CTRL(3)='0')   then
    out_trans<=I1;
  end if;
  if(CTRL(0) = '0') and (CTRL(1) ='1') and (CTRL(2) ='0')and (CTRL(3)='0')   then
    out_trans<=I2;
  end if;
  if(CTRL(0) = '1') and (CTRL(1) ='1') and (CTRL(2) ='0') and (CTRL(3)='0')   then
    out_trans<=I3;
  end if;
  if(CTRL(0) = '0') and (CTRL(1) ='0') and (CTRL(2) ='1') and (CTRL(3)='0')   then
    out_trans<=I4;
  end if;
  if(CTRL(0) = '1') and (CTRL(1) ='0') and (CTRL(2) ='1') and (CTRL(3)='0') then
    out_trans<=I5;
  end if;
  if(CTRL(0) = '0') and (CTRL(1) ='1') and (CTRL(2) ='1') and (CTRL(3)='0')   then
    out_trans<=I6;
  end if;
  if(CTRL(0) = '1') and (CTRL(1) ='1') and (CTRL(2) ='1')  and (CTRL(3)='0')  then
    out_trans<=I7;
  end if;
  if (CTRL(3)='1')  then
    out_trans<=I8;
  end if;
end process;
end dataflow;

 
  
  

  





