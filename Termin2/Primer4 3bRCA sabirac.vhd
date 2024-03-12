library IEEE;
use ieee.std_logic_1164.all;

entity RCA3b is
    port (op1, op2 : IN bit_vector(2 downto 0);
          cin      : IN bit;
          sum      : OUT bit_vector(2 downto 0);
          cout     : OUT bit);
end entity;

architecture RCA3b_arch of RCA3b is
    SIGNAL c01, c12 : bit;
begin
    bit0 : entity work.Full_Adder(Behavioral)
        port map(a => op1(0), b => op2(0), c_in => cin, s => sum(0), c_out => c01);

    bit1 : entity work.Full_Adder(Behavioral)
        port map(a => op1(1), b => op2(1), c_in => c01, s => sum(1), c_out => c12);

    bit2 : entity work.Full_Adder(Behavioral)
        port map(a => op1(2), b => op2(2), c_in => c12, s => sum(2), c_out => cout);
end architecture;

---------------------------------------------
--POTPUNI SABIRAC ISPOD TREBA DA IDE U POSEBAN FILE  "Full_Adder.vhd"
---------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Full_Adder is
PORT(a , b , C_In : IN bit; 
	 S,C_Out : OUT bit);
end Full_Adder;

architecture Behavioral of Full_Adder is
begin

S <= a XOR b XOR C_In;
C_Out <= (a AND b) OR (a AND C_In) OR (b AND C_In);

end Behavioral;

---------------------------------------------
--TEST BENCH, dodaj primera jos
---------------------------------------------

library IEEE;
use ieee.std_logic_1164.all;

entity testbench is
end entity;

architecture testbench_tb of testbench is
    SIGNAL op1_tb, op2_tb, sum_tb : bit_vector(2 downto 0);
    SIGNAL cin_tb, cout_tb : bit;
begin

    DUT : entity work.RCA3b(RCA3b_arch)
            port map (op1 => op1_tb,
                      op2 => op2_tb,
                      cin => cin_tb,
                      sum => sum_tb,
                      cout => cout_tb);

    stimuli : process
    begin
        op1_tb <= "001";
        op2_tb <= "010";
        cin_tb <= '0';
        wait for 1ns;

        op1_tb <= "111";
        op2_tb <= "010";
        cin_tb <= '0';
        wait for 1ns;

        op1_tb <= "111";
        op2_tb <= "010";
        cin_tb <= '1';
        wait for 1ns;
        
    end process;
end architecture;