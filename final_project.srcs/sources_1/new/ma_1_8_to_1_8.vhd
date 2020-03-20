
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ma_1_8_to_1_8 is
    port(
        clk: in std_logic;
        x: in std_logic_vector(255 downto 0);
        y: in std_logic_vector(255 downto 0);
        o: out std_logic_vector(255 downto 0)
    );
end ma_1_8_to_1_8;

architecture ma_1_8_to_1_8 of ma_1_8_to_1_8 is
    component float_adder
        port (
            clk: in std_logic;
            f1: in std_logic_vector(31 downto 0);
            f2: in std_logic_vector(31 downto 0);
            out1: out std_logic_vector(31 downto 0)
        );
    end component;
    
    signal add_f1_0: std_logic_vector(31 downto 0);
    signal add_f2_0: std_logic_vector(31 downto 0);
    signal add_out_0: std_logic_vector(31 downto 0);
    
    signal add_f1_1: std_logic_vector(31 downto 0);
    signal add_f2_1: std_logic_vector(31 downto 0);
    signal add_out_1: std_logic_vector(31 downto 0);
    
    signal add_f1_2: std_logic_vector(31 downto 0);
    signal add_f2_2: std_logic_vector(31 downto 0);
    signal add_out_2: std_logic_vector(31 downto 0);
    
    signal add_f1_3: std_logic_vector(31 downto 0);
    signal add_f2_3: std_logic_vector(31 downto 0);
    signal add_out_3: std_logic_vector(31 downto 0);
    
    signal add_f1_4: std_logic_vector(31 downto 0);
    signal add_f2_4: std_logic_vector(31 downto 0);
    signal add_out_4: std_logic_vector(31 downto 0);

    signal add_f1_5: std_logic_vector(31 downto 0);
    signal add_f2_5: std_logic_vector(31 downto 0);
    signal add_out_5: std_logic_vector(31 downto 0);    
    
    signal add_f1_6: std_logic_vector(31 downto 0);
    signal add_f2_6: std_logic_vector(31 downto 0);
    signal add_out_6: std_logic_vector(31 downto 0);
    
    signal add_f1_7: std_logic_vector(31 downto 0);
    signal add_f2_7: std_logic_vector(31 downto 0);
    signal add_out_7: std_logic_vector(31 downto 0);

    signal add_clk: std_logic := '0';
begin
    
    fa0: float_adder port map (
        clk => add_clk,
        f1 => add_f1_0,
        f2 => add_f2_0,
        out1 => add_out_0
    );
    
    fa1: float_adder port map (
        clk => add_clk,
        f1 => add_f1_1,
        f2 => add_f2_1,
        out1 => add_out_1
    );
    
    fa2: float_adder port map (
        clk => add_clk,
        f1 => add_f1_2,
        f2 => add_f2_2,
        out1 => add_out_2
    );
    
    fa3: float_adder port map (
        clk => add_clk,
        f1 => add_f1_3,
        f2 => add_f2_3,
        out1 => add_out_3
    );
    
    fa4: float_adder port map (
        clk => add_clk,
        f1 => add_f1_4,
        f2 => add_f2_4,
        out1 => add_out_4
    );
    
    fa5: float_adder port map (
        clk => add_clk,
        f1 => add_f1_5,
        f2 => add_f2_5,
        out1 => add_out_5
    );
    
    fa6: float_adder port map (
        clk => add_clk,
        f1 => add_f1_6,
        f2 => add_f2_6,
        out1 => add_out_6
    );
    
    fa7: float_adder port map (
        clk => add_clk,
        f1 => add_f1_7,
        f2 => add_f2_7,
        out1 => add_out_7
    );
   
   
    process(clk) is
    begin
    
        if rising_edge(clk) then
            
            add_f1_0 <= x(31 downto 0);
            add_f1_1 <= x(63 downto 32);
            add_f1_2 <= x(95 downto 64);
            add_f1_3 <= x(127 downto 96);
            add_f1_4 <= x(159 downto 128);
            add_f1_5 <= x(191 downto 160);
            add_f1_6 <= x(223 downto 192);
            add_f1_7 <= x(255 downto 224);  
            
            add_f2_0 <= y(31 downto 0);
            add_f2_1 <= y(63 downto 32);
            add_f2_2 <= y(95 downto 64);
            add_f2_3 <= y(127 downto 96);
            add_f2_4 <= y(159 downto 128);
            add_f2_5 <= y(191 downto 160);
            add_f2_6 <= y(223 downto 192);
            add_f2_7 <= y(255 downto 224);
            
            o <= add_out_7 & add_out_6 & add_out_5 & add_out_4 & add_out_3 & add_out_2 & add_out_1 & add_out_0;  
            add_clk <= '1';
        else
            add_clk <= '0';
        end if;
    end process;
end ma_1_8_to_1_8;
