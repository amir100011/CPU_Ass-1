library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity or_Gate is port(


bitA,bitB: in std_logic;
resultOr: out std_logic

);
end or_Gate;

architecture OR_Gate of or_Gate is

begin
  
 resultOr <= bitA or bitB;
 
 end OR_Gate;
