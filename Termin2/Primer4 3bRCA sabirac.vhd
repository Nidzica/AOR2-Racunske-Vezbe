entity RCA3b is
    port (op1, op2 : IN bit_vector(2 downto 0);
          cin      : IN bit;
          sum      : OUT bit_vector(2 downto 0);
          cout     : OUT bit);
end entity;

architecture RCA3b_arch of RCA3b is
    SIGNAL c01, c12 : bit;
begin
    bit0 : entity work.sabirac(sabirac_arch)
        port map(a => op1(0), b => op2(0), c_in => cin, s => sum(0), c_out => c01);

    bit1 : entity work.sabirac(sabirac_arch)
        port map(a => op1(1), b => op2(1), c_in => c01, s => sum(1), c_out => c12);

    bit2 : entity work.sabirac(sabirac_arch)
        port map(a => op1(2), b => op2(2), c_in => c12, s => sum(1), c_out => c12);
end architecture;

---------------------------------------------
--TEST BENCH, ne radi posto obican sabirac na njihov nacin ne radi, probaj na drugi nacin da ga napravis
---------------------------------------------

entity testbench is
end entity;

architecture testbench_tb of testbench is
    SIGNAL op1_tb, op2_tb, sum_tb : bit_vector(2 downto 0);
    SIGNAL cin_tb, cout_tb : bit;
begin

    DUT : entity work.sabirac(sabirac_arch)
            port map (op1 => op1_tb,
                      op2 => op2_tb,
                      cin => cin_tb,
                      sum => sum_tb,
                      cout => cout_tb);

    stimuli : process
    begin
        op1_tb <= "001";
        op2_tb <= "010";
        cin_tb <= '0';
        wait for 1ns;

        op1_tb <= "111";
        op2_tb <= "010";
        cin_tb <= '0';
        wait for 1ns;

        op1_tb <= "111";
        op2_tb <= "010";
        cin_tb <= '1';
        wait for 1ns;
        
    end process;
end architecture;