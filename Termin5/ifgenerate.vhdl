---------------------Dflipflop

library IEEE;
use ieee.std_logic_1164.all;



entity dflipflop is
    port(clk,d: IN std_logic;
         q: OUT std_logic );
end entity;

architecture simple of dflipflop is
begin
    process(clk)
    begin
        if clk'event and clk='1' then
            q<=d;
        end if;
    end process;
end architecture;



library IEEE;
use ieee.std_logic_1164.all;

entity shift_reg is
    generic(n:natural :=4);
    port(clk : in std_logic;
         serial_data_in : in std_logic;
         parallel_data: INOUT std_logic_vector(n-1 downto 0));
end entity;

architecture cell_level of shift_reg is
begin
    reg_array: for index in parallel_data'range GENERATE
        begin
            first_cell: IF index = parallel_data'left GENERATE
                begin
                    cell: entity work.dflipflop(simple)
                        port map (clk => clk,
                                  d=>serial_data_in,
                                  q=>parallel_data(index));
            end GENERATE first_cell;

            not_first_cell: IF index /= parallel_data'left GENERATE
                begin
                    cell: entity work.dflipflop(simple)
                        port map (clk => clk,
                                  d=>parallel_data(index+1),
                                  q=>parallel_data(index));
            end GENERATE not_first_cell;
    end GENERATE reg_array;
end architecture;



--------------------------------------------------
--TEST BENCH
--------------------------------------------------

library IEEE;
use ieee.std_logic_1164.all;

entity testbench is
    generic(width : integer := 4);
end entity;
   
architecture testbench_tb of testbench is
    SIGNAL clk_tb,serial_data_in_tb : std_logic;
    SIGNAL parallel_data_tb : std_logic_vector(width-1 downto 0);

begin
    DUT : entity work.shift_reg(cell_level)
        generic map (n => width)
        port map (clk => clk_tb,
                  serial_data_in => serial_data_in_tb,
                  parallel_data => parallel_data_tb);

    clock: process
    begin
        clk_tb <= '1';
        wait for 10ns;
        clk_tb <= '0';
        wait for 10ns;
    end process;
   
    stimuli : process
    begin
        serial_data_in_tb <= '1';
        wait for 50ns;

        serial_data_in_tb <= '0';
        wait for 50ns;

        serial_data_in_tb <= '0';
        wait for 50ns;

        serial_data_in_tb <= '1';
        wait for 50ns;

        serial_data_in_tb <= '1';
        wait for 50ns;

        serial_data_in_tb <= '0';
        wait for 50ns;

        wait;
    end process;
end architecture;