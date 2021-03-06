library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Shift_Reg_Working is generic(

  N : integer := 8
  
);

  port(
    
    clk:            in std_logic; 
    reset:          in std_logic; 
    enable:         in std_logic;    --enables shifting
    direction:      in std_logic;    --right/left shifting
    Num2Shift:      in std_logic_vector(N-1 downto 0);
    NumOfShifts:    in std_logic_vector(N-1 downto 0);--there is no saturation option
    output_Shift:   out std_logic_vector(31 downto 0):=(others=>'0')   --serial output
    );
    
end Shift_Reg_Working;

architecture Arch_Shift_reg of Shift_Reg_Working is
   
begin
  process (direction)
    
    variable NumOfShifts_int: integer;
    variable Num2Shift_vec: std_logic_vector(31 downto 0);
    
  begin
    
    --initialization for variables
    
    NumOfShifts_int:= to_integer(unsigned(NumOfShifts));
    Num2Shift_vec:= std_logic_vector(resize(unsigned(Num2Shift),32));
    
    
    if (reset = '1') then
      Num2Shift_vec := (others=>'0');   
--    elsif (clk'event and clk='1') then
      elsif(clk='1') then
        if (enable ='1') then
          if(direction='1') then
        --left shifting of n number of bits
            for j in 0 to NumOfShifts_int-1 loop
              for i in 0 to 30 loop 
                Num2Shift_vec(31-i) := Num2Shift_vec(30-i);
              end loop;
             Num2Shift_vec(0) := '0';
            end loop;
          else
              --direction=0 -> right shifting of n number of bits
            for j in 0 to NumOfShifts_int-1 loop
              for i in 0 to 30 loop 
                Num2Shift_vec(i) := Num2Shift_vec(i+1);
              end loop;
              Num2Shift_vec(31) := '0';
            end loop;
          end if;--direction
        end if;--enable
      end if;--reset/clk
      
  --output setting
  output_Shift <= Num2Shift_vec;
  
end process;

end Arch_Shift_reg;
  




