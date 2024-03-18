library IEEE;
use ieee.std_logic_1164.all;

entity brojac is
    port( clr : IN BIT;
          clk : IN BIT;
          q   :  OUT BIT_VECTOR(3 DOWNTO 0));       --q je izlaz, q_int je unutrasnje stanje brojaca
end entity;

architecture brojac_arch of brojac is
begin
    process(clr,clk)        --Asinhroni
        variable q_int : BIT_VECTOR(3 DOWNTO 0);        --Sintetisati ce se kao memorijski element (obicno za variable)
        variable cq : BIT;          --Flag za svaki drugi takt
    begin
        IF clr = '1' then
            q_int := "0000";        
            cq := '0';

        elsif clk'event and clk = '1' then          
            cq := not cq;

            IF cq='1' then
                CASE q_int is       --Nikako ne moze ovde q pa da se direktno pise i cita iz njega
                    when "0000" => q_int := "0001";     --Kada je stanje brojaca 0, predji na 1 "brojanje"
                    when "0001" => q_int := "0010";
                    when "0010" => q_int := "0011";
                    when "0011" => q_int := "0100";
                    when "0100" => q_int := "0101";
                    when "0101" => q_int := "0110";
                    when "0110" => q_int := "0111";
                    when "0111" => q_int := "1000";     --Sigurni smo da je sintetizabilno
                    when "1000" => q_int := "1001";     --Ako stavimo when others
                    when others => q_int := "0000";     --Prelazak sa 9 na 0 (jednobitni sabirac), 
                end case;
            end if;
        end if;
    q <= q_int;     --Unutrasnje stanje brojaca upisujemo na izlaz nakon sto je brojio
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
    SIGNAL clr_tb,clk_tb : BIT;
    SIGNAL q_tb: BIT_VECTOR(3 downto 0);

   
begin
    DUT : entity work.brojac(brojac_arch)
        port map (clk => clk_tb,
                  clr => clr_tb,
                  q => q_tb);

    clock: process
    begin
        clk_tb <= '1';
        wait for 5ns;
        clk_tb <= '0';
        wait for 5ns;
    end process;
   
    stimuli : process
    begin
    	wait for 100ns;
    
        clr_tb <= '1';
        wait for 10ns;

        clr_tb<='0';
        wait for 300ns;

        clr_tb <= '1';
        wait for 10ns;
      
    end process;
end architecture;