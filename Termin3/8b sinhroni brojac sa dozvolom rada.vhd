--8b kruzni brojac sa asinhroni reset, paralelni upis, dozvolom upisa, dozvolom brojanja, izborom smera


library IEEE;
use ieee.std_logic_1164.all;

entity brojac is
    port (clk : in std_logic;
          reset: in std_logic;
          ce,load,dir : in std_logic;  --count enable, upis, smer
          din : in integer range 0 to 255;
          count: OUT integer range 0 to 255);  
end entity;

architecture brojac_arch of brojac is
begin
    process (clk,reset)     --Asinhroni ulazi i klok
    variable counter: integer range 0 to 255;
    begin
        if reset = '1' then
            counter :=0;
        elsif clk = '1' and clk'event then
            if load = '1' then
                counter := din;     --Upis kada je load '1'
            else
                if ce='1' then
                    if dir = '1' then   --broji na gore
                        if counter = 255 then
                            counter := 0;
                        else
                            counter := counter + 1;
                        end if;
                    else            --broji na dole
                        if counter = 0 then 
                            counter := 255;
                        else
                        	counter := counter - 1;
                        end if;
                    end if;
                end if;
            end if;
        end if;
    count <= counter;   --Upis u izlaz
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
    SIGNAL reset_tb,clk_tb,ce_tb,load_tb,dir_tb : std_logic;
    SIGNAL count_tb,din_tb: integer range 0 to 255;

   
begin
    DUT : entity work.brojac(brojac_arch)
        port map (clk => clk_tb,
                  reset => reset_tb,
                  ce => ce_tb,
                  dir => dir_tb,
                  load => load_tb,
                  count => count_tb,
                  din => din_tb);

    clock: process
    begin
        clk_tb <= '1';
        wait for 10ns;
        clk_tb <= '0';
        wait for 10ns;
    end process;
   
    stimuli : process
    begin
        ce_tb <= '1';
    	dir_tb <= '1';
        reset_tb <= '1';
        wait for 13ns;
		
        reset_tb <= '0';
        wait for 50ns;

        dir_tb <= '0';
        wait for 100ns;

        dir_tb <= '1';
        load_tb <= '1';
        din_tb <= 69;
        wait for 25ns;

		load_tb <= '0';
        wait for 500ns;
        
        dir_tb <= '0';
        wait for 500ns;
      
    end process;
end architecture;