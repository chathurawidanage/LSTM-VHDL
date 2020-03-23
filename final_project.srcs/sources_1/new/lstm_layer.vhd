
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity lstm_layer is
    port(
        clk: in std_logic;
        c_in: in std_logic_vector(255 downto 0);
        h_in: in std_logic_vector(255 downto 0);
        x: in std_logic_vector(223 downto 0);
        c_out: out std_logic_vector(255 downto 0);
        h_out: out std_logic_vector(255 downto 0)
    );
end lstm_layer;

architecture lstm_layer of lstm_layer is
    
    component lstm_unit
        port(
        clk: in std_logic;
            c: in std_logic_vector(255 downto 0);
            h: in std_logic_vector(255 downto 0);
            x: in std_logic_vector(31 downto 0);
            c_out: out std_logic_vector(255 downto 0);
            h_out: out std_logic_vector(255 downto 0)
        );
    end component;
    
    signal lstm1_c: std_logic_vector(255 downto 0); 
    signal lstm1_h: std_logic_vector(255 downto 0);
    
    signal lstm2_c: std_logic_vector(255 downto 0); 
    signal lstm2_h: std_logic_vector(255 downto 0);
    
    signal lstm3_c: std_logic_vector(255 downto 0); 
    signal lstm3_h: std_logic_vector(255 downto 0);
    
    signal lstm4_c: std_logic_vector(255 downto 0); 
    signal lstm4_h: std_logic_vector(255 downto 0);
    
    signal lstm5_c: std_logic_vector(255 downto 0); 
    signal lstm5_h: std_logic_vector(255 downto 0);
    
    signal lstm6_c: std_logic_vector(255 downto 0); 
    signal lstm6_h: std_logic_vector(255 downto 0);
    
    signal lstm7_c: std_logic_vector(255 downto 0); 
    signal lstm7_h: std_logic_vector(255 downto 0); 
begin

    lstm1: lstm_unit port map(
        clk => clk,
        c => c_in,
        h => h_in,
        x => x(223 downto 192),
        c_out => lstm1_c,
        h_out => lstm1_h
    );
    
    lstm2: lstm_unit port map(
        clk => clk,
        c => lstm1_c,
        h => lstm1_h,
        x => x(191 downto 160),
        c_out => lstm2_c,
        h_out => lstm2_h
    );
    
    lstm3: lstm_unit port map(
        clk => clk,
        c => lstm2_c,
        h => lstm2_h,
        x => x(159 downto 128),
        c_out => lstm3_c,
        h_out => lstm3_h
    );
    
    lstm4: lstm_unit port map(
        clk => clk,
        c => lstm3_c,
        h => lstm3_h,
        x => x(127 downto 96),
        c_out => lstm4_c,
        h_out => lstm4_h
    );
    
    lstm5: lstm_unit port map(
        clk => clk,
        c => lstm4_c,
        h => lstm4_h,
        x => x(95 downto 64),
        c_out => lstm5_c,
        h_out => lstm5_h
    );
    
    lstm6: lstm_unit port map(
        clk => clk,
        c => lstm5_c,
        h => lstm5_h,
        x => x(63 downto 32),
        c_out => lstm6_c,
        h_out => lstm6_h
    );
    
    lstm7: lstm_unit port map(
        clk => clk,
        c => lstm6_c,
        h => lstm6_h,
        x => x(31 downto 0),
        c_out => lstm7_c,
        h_out => lstm7_h
    );
    
    c_out <= lstm7_c;
    h_out <= lstm7_h;
end lstm_layer;
