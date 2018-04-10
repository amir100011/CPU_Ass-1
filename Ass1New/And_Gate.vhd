library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all; 
entity and_Gate is port(

bitA,bitB: in std_logic;
resultAnd: out std_logic

);
end and_Gate;


architecture AND_Gate of and_Gate is

 begin
  
 resultAnd <= bitA and BitB;
 
 end AND_Gate;
 
