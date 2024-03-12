--------------------------------------------------
--J signal (Set) prosledjuje 1 na izlaz sledece Q
--K signal (Reset) prosledjuje 0 na izlaz sledece Q
--S=0 i R=0 prosledjuje proslo Q na sledece Q (cuva vrednost)
--J=1 i K=1 prosledjuje komplement proslog stanja na izlaz
--Qnot je izlaz koji je uvek suprotan od Q
--------------------------------------------------

library IEEE;
use ieee.std_logic_1164.all;

entity JKFF is
    port (J,K,clk : IN std_logic;
          Q,Qnot   : OUT std_logic);
end entity;

architecture JKFF_arch of JKFF is
begin
    process(clk)
    variable pom : std_logic;       --Pomocna promenljiva koja ce da upisuje u izlaze
    begin
        if (J='1' and K='0') then
            pom := '1';
        elsif(J='0' and K='1') then
            pom := '0';
        elsif(J = '0' and K='0') then
            pom := pom;
        else
            pom := not pom;
        end if;
        
        Q <= pom;
        Qnot <= not pom;    
    end process;
end architecture;

--------------------------------------------------
--TEST BENCH
--------------------------------------------------


ibrary IEEE;
use ieee.std_logic_1164.all;

entity testbench is
end entity;

architecture testbench_arch of testbench is
SIGNAL J_TB,K_TB,CLK_TB,Q_TB,Qnot_TB : std_logic;

begin
    DUT : entity work.JKFF(JKFF_arch)
            port map (J => J_TB,
                      K => K_TB,
                      clk => clk_tb,
                      Q => Q_TB,
                      Qnot => Qnot_TB);
    
    clock: process
    begin
        clk_tb <= '1';
        wait for 5ns;
        clk_tb <= '0';
        wait for 5ns;
    end process;

    stimuli: process
    begin
    	J_TB <= '1';
        K_TB <= '0';
        wait for 7ns;
        
        J_TB <= '0';
        K_TB <= '0';
        wait for 7ns;

        J_TB <= '0';
        K_TB <= '1';
        wait for 7ns;

        J_TB <= '1';
        K_TB <= '1';
        wait for 7ns;

        wait;
    end process;
end architecture;