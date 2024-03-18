library IEEE;
use ieee.std_logic_1164.all;

entity registar is
    generic (n : integer := 8);      --Konstanta za ovo kolo
    port (wr, clk : IN STD_LOGIC;
          d_in : IN STD_LOGIC_VECTOR(n-1 downto 0);
          d_out: OUT STD_LOGIC);
end entity;

architecture registar_arch of registar is
begin
    process
        variable int_storage : std_logic_vector(n-1 downto 0);  --Mem element koji sadrzi podatak iz registra
    begin
        wait until wr='1';  --Ceka da se promeni wr i da postane 1

        int_storage := d_in;        --Paralelan upis: svi bitovi se odjednom upisu

        for i in n-1 downto 0 loop
            wait until clk'event and clk = '1'
            d_out <= int_storage(i);    --Serijski izlaz: jedan po jedan bit
        end loop;
        wait until clk'event and clk='1';      --Bez ovoga delta kasnjenje, dva puta d_out !!!
        d_out <= 'Z';       --Prazan registar
    end process;
end architecture; 

--------------------------------------------------
--TEST BENCH
--------------------------------------------------

library IEEE;
use ieee.std_logic_1164.all;

entity testbench is
    generic(width : integer:=4);    --Konstanta za ovaj testbench
end entity;

architecture testbench_tb of testbench is
    signal wr_tb   : std_logic;
    signal d_in_tb : std_logic_vector (width-1 downto 0);
    signal clk     : std_logic := '0';      --Klok na 4 nacin
    signal d_out   : std_logic;

begin
    DUT: entity work.registar(registar_arch)
        generic map (n => width);   --Npr testbenchom testiramo sa 4b umesto 8b, bez ovih konstanti bi bilo podrazumevano 8
        port map (wr => wr_tb,
                  clk => clk_tb,
                  d_in => d_in_tb,
                  d_out => d_out_tb);

    clk_tb <= not clk_tb after 50ns;        --Klok sa periodom od 100ns

    STIMULUS: process
    begin
        d_in_tb <= "0101";
        wr_tb <= '1';
        wait for 50ns;

        wr_tb <= '0';
        wait for 600ns;

        d_in_tb <= "1101";
        wr_tb <= '1';
        wait for 100ns;

        d_in_tb <= "0000";
        wait for 500ns;
    end process;
end architecture;