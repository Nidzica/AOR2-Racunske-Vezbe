library IEEE;
use IEEE.std_logic_1164.all;

entity e_and2 is
    port (in1,in2 : in bit;
          out1    : out bit);
end entity e_and2;

architecture e_and2_arch of e_and2 is

begin
    out1<= in1 and in2;
end architecture;

--architecture drugi_nacin of e_and2 is
--begin
--    process(in1,in2)
--    begin
--        out1 <= in1 and in2;
--    end process;
--end architecture;

--------------------------------------------------
--TEST BENCH
--------------------------------------------------


entity testbench is
    end entity;
    
    architecture e_and2_tb_arch of testbench is
        SIGNAL out1_tb : bit;
        SIGNAL in1_tb,in2_tb : bit;
    begin
        DUT : entity work.e_and2(e_and2_arch)
            port map(in1=>in1_tb,
                     in2=>in2_tb,
                     out1=>out1_tb);
        
        stimuli : process
        begin
            in1_tb <= '0';
            in2_tb <= '0';
            wait for 1ns;
            in1_tb <= '1';
            in2_tb <= '0';
            wait for 1ns;
            in1_tb <= '0';
            in2_tb <= '1';
            wait for 1ns;
            in1_tb <= '1';
            in2_tb <= '1';
            wait for 1ns;
        end process;
    end architecture;
    

