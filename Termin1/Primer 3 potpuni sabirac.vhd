library IEEE;
use IEEE.std_logic_1164.all;

entity full_adder is
    port (a,b,c_in : IN BIT;
          s, c_out : OUT BIT);
end entity;

architecture truth_table of full_adder is
begin
    with BIT_VECTOR'(a,b,c_in) select
        (c_out,s) <= BIT_VECTOR'("00") when "000",
                     BIT_VECTOR'("01") when "001",
                     BIT_VECTOR'("01") when "010",
                     BIT_VECTOR'("10") when "011",
                     BIT_VECTOR'("01") when "100",
                     BIT_VECTOR'("10") when "101",
                     BIT_VECTOR'("10") when "110",
                     BIT_VECTOR'("11") when "111";
end architecture;


---------------------------------------------
--TEST BENCH, ne radi
---------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity testbench is
end entity;

architecture testbench_tb of testbench is
    SIGNAL a_tb,b_tb,c_in_tb : BIT;
    SIGNAL s_tb, c_out_tb    : BIT;
begin

    DUT : entity work.full_adder(truth_table)
            port map (a => a_tb,
                      b => b_tb,
                      s => s_tb,
                      c_in => c_in_tb,
                      c_out => c_out_tb);
    
     stimuli : process
     begin
        a_tb <= '1';
        b_tb <= '0';
        c_in_tb <= '0';
        wait for 1ns;

        a_tb <= '1';
        b_tb <= '0';
        c_in_tb <= '1';
        wait for 1ns;

        a_tb <= '0';
        b_tb <= '0';
        c_in_tb <= '0';
        wait for 1ns;

        a_tb <= '1';
        b_tb <= '1';
        c_in_tb <= '1';
        wait for 1ns;

        a_tb <= '0';
        b_tb <= '1';
        c_in_tb <= '1';
        wait for 1ns;
    end process;
end architecture;

        


