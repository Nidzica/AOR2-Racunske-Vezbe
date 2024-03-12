--------------------------------------------------
--S signal (Set) prosledjuje 1 na izlaz sledece Q
--R signal (Reset) prosledjuje 0 na izlaz sledece Q
--S=0 i R=0 prosledjuje proslo Q na izlaz sledece Q (cuva vrednost)
--S=1 i R=1 je nedozvoljeno stanje (Ostavi prazno ili 'Z')
--Qnot je izlaz koji je uvek suprotan od Q
--------------------------------------------------
library IEEE;
use ieee.std_logic_1164.all;

entity SRFF is
    port (S,R,clk : IN std_logic;
          Q,Qnot   : OUT std_logic);
end entity;

architecture SRFF_arch of SRFF is
begin
    process(clk)
    variable pom : std_logic;       --Pomocna promenljiva koja ce da upisuje u izlaze
    begin
        if (S='1' and R='0') then
            pom := '1';
        elsif(S='0' and R='1') then
            pom := '0';
        elsif(S = '0' and R='0') then
            pom := pom;
        else
            pom := 'Z';
        end if;
        
        Q <= pom;
        Qnot <= not pom;    
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
SIGNAL S_TB,R_TB,CLK_TB,Q_TB,Qnot_TB : std_logic;

begin
    DUT : entity work.SRFF(SRFF_arch)
            port map (S => S_TB,
                      R => R_TB,
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
    	S_TB <= '1';
        R_TB <= '0';
        wait for 7ns;
        
        S_TB <= '0';
        R_TB <= '0';
        wait for 7ns;

        S_TB <= '0';
        R_TB <= '1';
        wait for 7ns;

        S_TB <= '1';
        R_TB <= '1';
        wait for 7ns;

        wait;
    end process;
end architecture;