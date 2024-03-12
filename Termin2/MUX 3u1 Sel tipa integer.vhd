library IEEE;
use ieee.std_logic_1164.all;

entity muxEx is
    port (a,b,c : in std_logic_vector(7 downto 0);
          sel : in integer;
          d   : out std_logic_vector(7 downto 0));
end entity;

architecture muxEx_arch of muxEx is
begin
    process(a,b,c,sel)
    begin
        if (sel = 0) then
            d <= a;
        elsif (sel = 1) then
            d <= b;
        elsif (sel = 2) then            --Ili neka druga varijanta da pokrije ceo opseg, tipa else d<=c bi prosledio bilo kakav c na d
            d <= c;
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

 architecture testbench_tb of testbench is
    SIGNAL a_tb, b_tb,c_tb : std_logic_vector(7 downto 0);
    SIGNAL sel_tb : integer;
    SIGNAL d_tb : std_logic_vector(7 downto 0);

begin
    DUT : entity work.muxEx(muxEx_arch)
        port map (a => a_tb,
                  b => b_tb,
                  c => c_tb,
                  d => d_tb,
                  sel => sel_tb);

    stimuli : process 
    begin
        a_tb <= "10101010";
        b_tb <= "00001111";
        c_tb <= "11110000";
        sel_tb <= 0;
        wait for 10ns;

        a_tb <= "10101010";
        b_tb <= "00001111";
        c_tb <= "11110000";
        sel_tb <= 1;
        wait for 10ns;

        a_tb <= "10101010";
        b_tb <= "00001111";
        c_tb <= "11110000";
        sel_tb <= 2;
        wait for 10ns;

        a_tb <= "10101010";
        b_tb <= "00001111";
        c_tb <= "11110000";
        sel_tb <= 3;
        wait for 10ns;
        wait for 10ns;
    end process;
end architecture;