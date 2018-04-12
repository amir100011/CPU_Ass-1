library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
 entity xor_Gate is port(

bitA,bitB: in std_logic;
resultXor: out std_logic

);
end xor_Gate;


architecture XOR_Gate of xor_Gate is

 begin
 
 resultXor <= bitA xor BitB;
 
 end XOR_Gate;

