
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity ALU_tb is
end ALU_tb;
architecture rtl of ALU_tb is
  component ALU is generic(
    N:integer:=8
  );
    port(
    signal A,B : in std_logic_vector(N-1 downto 0);
    signal opcode_in:in std_logic_vector(3 downto 0);
    signal clk_in: in std_logic;
    signal HI,LO:out std_logic_vector(N-1 downto 0);
    signal STATUS :out std_logic_vector (5 downto 0)
  );
end component;
  signal A_in,B_in,HI_trans,LO_trans:std_logic_vector(15 downto 0);
  signal Op_in : std_logic_vector(3 downto 0);
  signal clock:std_logic;
begin
  ALU_1:ALU
  generic map(16)
  port map(A=>A_in,B=>B_in,clk_in=>clock,HI=>HI_trans,LO=>LO_trans,opcode_in=>Op_in);
  Test_0:process
  begin  
    
  --TEST 1:ADD-->opcode=0000
  A_in<=X"00F0";
  B_in<=X"000F";
  Op_in<="0000";
  wait for 1 ns;
  assert LO_trans = X"00FF";
  REPORT "Test 1 Failed"
  SEVERITY error;
  wait for 1 ns;
  --TEST 2;SUB--opcode= 0001
  A_in<=X"0F01";
  B_in<=X"0F00";
  Op_in<="0001";
  wait for 1 ns;
  assert Lo_trans =X"0001";
  REPORT "Test 2 Failed"
  SEVERITY error;
  wait for 1 ns;
  --TEST 3:Shift left
  A_in<=X"F0F0";
  B_in<=X"0004";
  Op_in<="1000";
  wait for 1 ns;
  assert (LO_trans =X"0F00") and( HI_trans =X"000F");
  REPORT "Test 3 Failed"
  SEVERITY error;
  wait for 1 ns;
  --TEST 4:Shift right 
  A_in<=X"F000";
  B_in<=X"0008";
  Op_in<="1001";
  wait for 1 ns;
  assert (LO_trans =X"00F0") and( HI_trans =X"0000");
  REPORT "Test 4 Failed"
  SEVERITY error;
  wait for 1 ns;
  --TEST 5:MULTIPLY
  A_in<=X"0004";
  B_in<=X"0004";
  Op_in<="0010";
  wait for 1 ns;
  assert (LO_trans =X"0010");
  REPORT "Test 5 Failed"
  SEVERITY error;
  wait for 1 ns;
  --TEST 6:MAC  Q(0) = 0
  clock<='0';
  wait for  1000 ps;
  A_in<=X"0001";
  B_in<=X"0001";
  Op_in<="0100";
  clock<='1'; 
  wait for 1 ns;
  clock<='0';
  wait for 1 ns;
  clock<='1'; 
  wait for 1 ns;
  clock<='0';
  wait for 1 ns;
  assert (LO_trans =X"0001") 
  REPORT "Test 6_1 Failed"
  SEVERITY error;
  wait for 1 ns;
  A_in<=X"0002";
  B_in<=X"0002";
  Op_in<="0100";
  clock<='1';
  wait for 1 ns;
  clock<='0';
  wait for 1 ns;
  clock<='1';
  wait for 1 ns;
  clock<='0';
  assert (LO_trans =X"0005") 
  REPORT "Test 6_2 Failed"
  SEVERITY error;
 end process Test_0;
end rtl;

