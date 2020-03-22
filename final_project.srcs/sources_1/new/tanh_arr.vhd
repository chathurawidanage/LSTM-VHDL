library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tanh_arr is
    Port ( 
        A : in STD_LOGIC_VECTOR (255 downto 0);
        O : out STD_LOGIC_VECTOR (255 downto 0);
        clk: in STD_LOGIC 
    );
end tanh_arr;

architecture tanh_arr of tanh_arr is
    component tanh
        Port ( 
            A : in STD_LOGIC_VECTOR (31 downto 0);
            O : out STD_LOGIC_VECTOR (31 downto 0);
            clk: in STD_LOGIC 
        );
    end component;
    
    signal tanh1_in: STD_LOGIC_VECTOR (31 downto 0);
    signal tanh2_in: STD_LOGIC_VECTOR (31 downto 0);
    signal tanh3_in: STD_LOGIC_VECTOR (31 downto 0);
    signal tanh4_in: STD_LOGIC_VECTOR (31 downto 0);
    signal tanh5_in: STD_LOGIC_VECTOR (31 downto 0);
    signal tanh6_in: STD_LOGIC_VECTOR (31 downto 0);
    signal tanh7_in: STD_LOGIC_VECTOR (31 downto 0);
    signal tanh8_in: STD_LOGIC_VECTOR (31 downto 0);
    
    signal tanh1_out: STD_LOGIC_VECTOR (31 downto 0);
    signal tanh2_out: STD_LOGIC_VECTOR (31 downto 0);
    signal tanh3_out: STD_LOGIC_VECTOR (31 downto 0);
    signal tanh4_out: STD_LOGIC_VECTOR (31 downto 0);
    signal tanh5_out: STD_LOGIC_VECTOR (31 downto 0);
    signal tanh6_out: STD_LOGIC_VECTOR (31 downto 0);
    signal tanh7_out: STD_LOGIC_VECTOR (31 downto 0);
    signal tanh8_out: STD_LOGIC_VECTOR (31 downto 0);
    
    signal tanh1_clk: std_logic := '0';
    signal tanh2_clk: std_logic := '0';
    signal tanh3_clk: std_logic := '0';
    signal tanh4_clk: std_logic := '0';
    signal tanh5_clk: std_logic := '0';
    signal tanh6_clk: std_logic := '0';
    signal tanh7_clk: std_logic := '0';
    signal tanh8_clk: std_logic := '0';
begin
    
    tanh1: tanh port map(
        A => tanh1_in,
        O => tanh1_out,
        clk => tanh1_clk
    );
    
    tanh2: tanh port map(
        A => tanh2_in,
        O => tanh2_out,
        clk => tanh2_clk
    );
    
    tanh3: tanh port map(
        A => tanh3_in,
        O => tanh3_out,
        clk => tanh3_clk
    );
    
    tanh4: tanh port map(
        A => tanh4_in,
        O => tanh4_out,
        clk => tanh4_clk
    );
    
    tanh5: tanh port map(
        A => tanh5_in,
        O => tanh5_out,
        clk => tanh5_clk
    );
    
    tanh6: tanh port map(
        A => tanh6_in,
        O => tanh6_out,
        clk => tanh6_clk
    );
    
    tanh7: tanh port map(
        A => tanh7_in,
        O => tanh7_out,
        clk => tanh7_clk
    );
    
    tanh8: tanh port map(
        A => tanh8_in,
        O => tanh8_out,
        clk => tanh8_clk
    );
    
    process(clk) is
    begin
        if rising_edge(clk) then
            tanh1_in <= A(255 downto 224);
            tanh2_in <= A(223 downto 192);
            tanh3_in <= A(191 downto 160);
            tanh4_in <= A(159 downto 128);
            tanh5_in <= A(127 downto 96);
            tanh6_in <= A(95 downto 64);
            tanh7_in <= A(63 downto 32);
            tanh8_in <= A(31 downto 0);
            
            O <= tanh1_out & tanh2_out & tanh3_out & tanh4_out & tanh5_out & tanh6_out & tanh7_out & tanh8_out;
            
            tanh1_clk <= '1';
            tanh2_clk <= '1';
            tanh3_clk <= '1';
            tanh4_clk <= '1';
            tanh5_clk <= '1';
            tanh6_clk <= '1';
            tanh7_clk <= '1';
            tanh8_clk <= '1';
        
        else
            tanh1_clk <= '0';
            tanh2_clk <= '0';
            tanh3_clk <= '0';
            tanh4_clk <= '0';
            tanh5_clk <= '0';
            tanh6_clk <= '0';
            tanh7_clk <= '0';
            tanh8_clk <= '0';
        
        end if;
    end process;
    

end tanh_arr;
