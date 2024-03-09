library IEEE;
use ieee.std_logic_1164.all;

entity edge_triggered_Dff is
    port ( D: IN bit;
           clk: IN bit;
           clr: IN bit;
           Q: OUT bit);
end entity;

architecture edge_triggered_Dff_arch of edge_triggered_Dff is
begin
    promena : process (clk, clr) -- Kod asinhronog je clr u listi osetljivosti
    begin
        if clr ='1' then
            Q <= '0' after 2ns;
        elsif clk'event and clk = '1' then
            Q <= d after 2ns;
        end if;
    end process;
end architecture;



--------------------------------------------------
--TEST BENCH
--------------------------------------------------

library IEEE;
use ieee.std_logic_1164.all;

entity testbench is
end entity;

architecture testbench_arch of testbench is
    SIGNAL D_tb, clk_tb, clr_tb, Q_tb : bit;

begin
    DUT: entity work.edge_triggered_Dff(edge_triggered_Dff_arch)
        port map(D => D_tb,
                 q => Q_tb,
                 clk => clk_tb,
                 clr => clr_tb);
    
    clock: process
    begin
        clk_tb <= '1';
        wait for 5ns;
        clk_tb <= '0';
        wait for 5ns;
    end process;

    stimuli: process
    begin
        clr_tb <= '1';
        wait for 10ns;

        clr_tb <= '0';
        wait for 10ns;

        D_tb <= '0';
        wait for 37ns;

        D_tb <= '1';
        wait for 52ns;

        D_tb <= '0';
        wait;
    end process;
end architecture;

