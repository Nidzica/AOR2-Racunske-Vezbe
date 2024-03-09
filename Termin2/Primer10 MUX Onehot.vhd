library IEEE;
use ieee.std_logic_1164.all;

entity muxEx is
    port (a,b : in std_logic_vector(7 downto 0);
          sel : in std_logic_vector(1 downto 0);
          c   : out std_logic_vector(7 downto 0));
end entity;

architecture muxEx_arch of muxEx is
begin
    process(a,b,sel)
    begin
        if (sel = "00") then
            c <= "00000000";
        elsif (sel = "01") then
            c <= a;
        elsif (sel = "10") then
            c <= b;
        else
            c <= "ZZZZZZZZ";
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
    SIGNAL a_tb, b_tb : std_logic_vector(7 downto 0);
    SIGNAL sel_tb : std_logic_vector(1 downto 0);
    SIGNAL c_tb : std_logic_vector(7 downto 0);

begin
    DUT : entity work.muxEx(muxEx_arch)
        port map (a => a_tb,
                  b => b_tb,
                  c => c_tb,
                  sel => sel_tb);

    stimuli : process 
    begin
        a_tb <= "10101010";
        b_tb <= "00001111";
        sel_tb <= "00";
        wait for 10ns;

        a_tb <= "10101010";
        b_tb <= "00001111";
        sel_tb <= "01";
        wait for 10ns;

        a_tb <= "10101010";
        b_tb <= "00001111";
        sel_tb <= "10";
        wait for 10ns;

        a_tb <= "10101010";
        b_tb <= "00001111";
        sel_tb <= "11";
        wait for 10ns;
        wait for 10ns;
    end process;
end architecture;