library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

entity komparator is
    generic (n : integer := 7);
    port (a, b: IN SIGNED(n downto 0);
          x1,x2,x3 : OUT STD_LOGIC);
end entity;

architecture komparator_arch of komparator is
    begin
        x1 <= '1' WHEN a > b ELSE '0';
        x2 <= '1' WHEN a = b ELSE '0';
        x3 <= '1' WHEN a < b ELSE '0';
end architecture;


---------------------------------------------
--TEST BENCH
---------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

entity testbench is
    generic (n_tb : integer := 7);
end entity;

architecture testbench_arch of testbench is
    SIGNAL x1_tb,x2_tb,x3_tb : STD_LOGIC;
    SIGNAL a_tb,b_tb      : SIGNED(n_tb downto 0);

begin
    DUT : entity work.komparator(komparator_arch)
            generic map (n => n_tb)
            port map (x1 => x1_tb,
                      x2 => x2_tb,
                      x3 => x3_tb,
                      a => a_tb,
                      b => b_tb);
    stimuli : process
    begin
     	a_tb <= "00001000"; 
        b_tb <= "00000010"; 
        wait for 10ns;
        
        a_tb <= "10011111"; 
        b_tb <= "10011111"; 
        wait for 10ns;
        
        a_tb <= "10001000"; 
        b_tb <= "00000111"; 
        wait for 10ns;

    end process;
end architecture;

