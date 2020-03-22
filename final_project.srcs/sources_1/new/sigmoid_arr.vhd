library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sigmoid_arr is
    Port ( 
        Y : in STD_LOGIC_VECTOR (255 downto 0);
        O : out STD_LOGIC_VECTOR (255 downto 0);
        clk: in STD_LOGIC 
    );
end sigmoid_arr;

architecture sigmoid_arr of sigmoid_arr is
    component sigmoid
        Port ( 
            Y : in STD_LOGIC_VECTOR (31 downto 0);
            O : out STD_LOGIC_VECTOR (31 downto 0);
            clk: in STD_LOGIC 
        );
    end component;
    
    signal sig1_in: STD_LOGIC_VECTOR (31 downto 0);
    signal sig2_in: STD_LOGIC_VECTOR (31 downto 0);
    signal sig3_in: STD_LOGIC_VECTOR (31 downto 0);
    signal sig4_in: STD_LOGIC_VECTOR (31 downto 0);
    signal sig5_in: STD_LOGIC_VECTOR (31 downto 0);
    signal sig6_in: STD_LOGIC_VECTOR (31 downto 0);
    signal sig7_in: STD_LOGIC_VECTOR (31 downto 0);
    signal sig8_in: STD_LOGIC_VECTOR (31 downto 0);
    
    signal sig1_out: STD_LOGIC_VECTOR (31 downto 0);
    signal sig2_out: STD_LOGIC_VECTOR (31 downto 0);
    signal sig3_out: STD_LOGIC_VECTOR (31 downto 0);
    signal sig4_out: STD_LOGIC_VECTOR (31 downto 0);
    signal sig5_out: STD_LOGIC_VECTOR (31 downto 0);
    signal sig6_out: STD_LOGIC_VECTOR (31 downto 0);
    signal sig7_out: STD_LOGIC_VECTOR (31 downto 0);
    signal sig8_out: STD_LOGIC_VECTOR (31 downto 0);
    
    signal sig1_clk: std_logic := '0';
    signal sig2_clk: std_logic := '0';
    signal sig3_clk: std_logic := '0';
    signal sig4_clk: std_logic := '0';
    signal sig5_clk: std_logic := '0';
    signal sig6_clk: std_logic := '0';
    signal sig7_clk: std_logic := '0';
    signal sig8_clk: std_logic := '0';
begin
    
    sig1: sigmoid port map(
        Y => sig1_in,
        O => sig1_out,
        clk => sig1_clk
    );
    
    sig2: sigmoid port map(
        Y => sig2_in,
        O => sig2_out,
        clk => sig2_clk
    );
    
    sig3: sigmoid port map(
        Y => sig3_in,
        O => sig3_out,
        clk => sig3_clk
    );
    
    sig4: sigmoid port map(
        Y => sig4_in,
        O => sig4_out,
        clk => sig4_clk
    );
    
    sig5: sigmoid port map(
        Y => sig5_in,
        O => sig5_out,
        clk => sig5_clk
    );
    
    sig6: sigmoid port map(
        Y => sig6_in,
        O => sig6_out,
        clk => sig6_clk
    );
    
    sig7: sigmoid port map(
        Y => sig7_in,
        O => sig7_out,
        clk => sig7_clk
    );
    
    sig8: sigmoid port map(
        Y => sig8_in,
        O => sig8_out,
        clk => sig8_clk
    );
    
    process(clk) is
    begin
        if rising_edge(clk) then
            sig1_in <= Y(255 downto 224);
            sig2_in <= Y(223 downto 192);
            sig3_in <= Y(191 downto 160);
            sig4_in <= Y(159 downto 128);
            sig5_in <= Y(127 downto 96);
            sig6_in <= Y(95 downto 64);
            sig7_in <= Y(63 downto 32);
            sig8_in <= Y(31 downto 0);
            
            O <= sig1_out & sig2_out & sig3_out & sig4_out & sig5_out & sig6_out & sig7_out & sig8_out;
            
            sig1_clk <= '1';
            sig2_clk <= '1';
            sig3_clk <= '1';
            sig4_clk <= '1';
            sig5_clk <= '1';
            sig6_clk <= '1';
            sig7_clk <= '1';
            sig8_clk <= '1';
        
        else
            sig1_clk <= '0';
            sig2_clk <= '0';
            sig3_clk <= '0';
            sig4_clk <= '0';
            sig5_clk <= '0';
            sig6_clk <= '0';
            sig7_clk <= '0';
            sig8_clk <= '0';
        
        end if;
    end process;
    

end sigmoid_arr;
