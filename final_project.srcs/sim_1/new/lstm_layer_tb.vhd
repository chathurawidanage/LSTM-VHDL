
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity lstm_layer_tb is
--  Port ( );
end lstm_layer_tb;

architecture Behavioral of lstm_layer_tb is

    constant ClockFrequency : integer := 400e6;
    constant ClockPeriod : time := 1000 ms / ClockFrequency;
    
    signal clk : std_logic := '1';
    
    component lstm_layer
    port(
        clk: in std_logic;
        c_in: in std_logic_vector(255 downto 0);
        h_in: in std_logic_vector(255 downto 0);
        x: in std_logic_vector(223 downto 0);
        c_out: out std_logic_vector(255 downto 0);
        h_out: out std_logic_vector(255 downto 0)
    );
    
    end component;
    
    signal c_in: std_logic_vector(255 downto 0);
    signal h_in: std_logic_vector(255 downto 0);
    signal x: std_logic_vector(223 downto 0);
    signal c_out: std_logic_vector(255 downto 0);
    signal h_out: std_logic_vector(255 downto 0);
    
begin
    clk <= not clk after ClockPeriod / 2;

    lay: lstm_layer port map(
        clk => clk,
        c_in => c_in,
        h_in => h_in,
        x => x,
        c_out => c_out,
        h_out => h_out
    );

    stim_proc: process
    begin
        
        c_in <= x"0000000000000000000000000000000000000000000000000000000000000000";
        x <= x"3fabb2473fa9056d3fb956093fc70cbd3fcb38a53fc1b7033fc1d031";
        h_in <= x"0000000000000000000000000000000000000000000000000000000000000000";
        --out <= x"be1e5f2e 3e73593d 3e182810 bee1eff5 bee46fbd be09d098 bdc18509 3e399789"
        --         BE1E8E83 3E7363DA 3E17CE61 BEE1DF3D BEE5F300 BE09825A BDC09851 3E395869
        -- -0.154840514064, 0.237685590982 0.148248210549 -0.441156297922 -0.449119567871 -0.134286314249 -0.0940405204892 0.181001320481
        --[-0.15465996  0.2376451   0.14859032 -0.44128385 -0.44616498 -0.13458479 -0.09449203  0.18124212]       
        wait for 200 ns;
    end process;
end Behavioral;
