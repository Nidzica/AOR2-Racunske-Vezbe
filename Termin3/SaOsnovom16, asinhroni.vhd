library IEEE;
use ieee.std_logic_1164.all;


entity brojac is
    port (clk, reset : IN bit;
          count      : OUT natural);    --natural je podtip od integer
end entity;

architecture brojac_arch of brojac is
begin
    PROCESS is
        variable count_value : natural := 0;    --Nije sintetizabilan zbog inicijalizacije!!!
    begin
        count <= count_value;
        loop
            loop
                wait until clk = '1' or reset = '1';
                exit when reset = '1';      --Iskace iz petlje
                count_value := (count_value + 1) mod 16;     --Moze nad numerickim tipom
                count <= count_value;
            end loop;
            count_value := 0;   --Ovde exit skace
            count <= count_value;
            wait until reset = '0';     --Ceka reset da bi opet krenuo sa brojanjem 
        end loop;                   --Takodje treba taj wait da bi se dodelila vrednost
    end process;
end architecture;


--------------------------------------------------
--TEST BENCH
--------------------------------------------------

library IEEE;
use ieee.std_logic_1164.all;

entity testbench is
end entity;
   
architecture testbench_tb of testbench is
    SIGNAL reset_tb,clk_tb : BIT;
    SIGNAL count_tb : natural;

   
begin
    DUT : entity work.brojac(brojac_arch)
        port map (clk => clk_tb,
                  reset => reset_tb,
                  count => count_tb);

    clock: process
    begin
        clk_tb <= '1';
        wait for 5ns;
        clk_tb <= '0';
        wait for 5ns;
    end process;
   
    stimuli : process
    begin
    	wait for 73ns;
    
        reset_tb <= '1';
        wait for 5ns;

        reset_tb<='0';
        wait for 273ns;

        reset_tb <= '1';
        wait for 14ns;
      
    end process;
end architecture;