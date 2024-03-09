library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Full_Adder is

PORT(a , b , C_In : IN STD_LOGIC; S,C_Out : OUT STD_LOGIC);

end Full_Adder;

architecture Behavioral of Full_Adder is
begin

S <= a XOR b XOR C_In;
C_Out <= (a AND b) OR (a AND C_In) OR (b AND C_In);

end Behavioral;


--------------------------------------------------
--TEST BENCH, primer sa interneta, koriscenjem logickih izraza
--------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity testbench is     
end testbench;

architecture Behavioral of testbench is

   signal a: std_logic := '0'; -- signal declarations
   signal b: std_logic := '0';
   signal C_in: std_logic := '0';
   signal S: std_logic;
   signal C_out : std_logic;

begin

   uut : entity work.Full_Adder -- component instantiation
   port map(
      a => a, -- signal mappings
      b => b,
      C_in => C_in,
      S => S,
      C_out => C_out);

process 
begin 
   wait for 10 ns; -- wait time 
   a <= '0'; b <= '0'; C_in <= '1'; -- example test vector
   wait for 10 ns;

   -- Other test vectors and waits here

end process;


end Behavioral;