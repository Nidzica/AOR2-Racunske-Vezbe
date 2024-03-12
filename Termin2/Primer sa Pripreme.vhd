--Na VHDL-u, korišćenjem konkurentnih klauzula dodele vrednosti signalu, opisati D flipflop sa 
--asinhronim resetom, i koji se okida prednjom ivicom. Portovi treba da su tipa bit. Kreirati 
--testbenč sa talasnim oblicima ulaza koji demonstriraju sve osobine kola - željene i nepoželjne. 

library IEEE;
use ieee.std_logic_1164.all;

entity priprema is
    port ( D: IN bit;
           clk: IN bit;
           clr: IN bit;
           Q: OUT bit);
end entity;

architecture priprema_arch of priprema is
begin
    Q <= '0' when clr = '1' else
   		  D when clk'event and clk = '1';
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
    DUT: entity work.priprema(priprema_arch)
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
end architecture;