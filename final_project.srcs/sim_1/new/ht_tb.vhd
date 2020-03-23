
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ht_tb is
--  Port ( );
end ht_tb;

architecture Behavioral of ht_tb is
    constant ClockFrequency : integer := 100e6;
    constant ClockPeriod : time := 1000 ms / ClockFrequency;
    
    signal clk : std_logic := '1';
    
    component ht
        Port ( 
            bo: in std_logic_vector(255 downto 0);
            ht_1: in std_logic_vector(255 downto 0);
            who: in std_logic_vector(2047 downto 0);
            xt: in std_logic_vector(31 downto 0);
            wxo: in std_logic_vector(255 downto 0);
            ct: in std_logic_vector(255 downto 0);
            clk: in std_logic;
            ht: out std_logic_vector(255 downto 0)
        );
    end component;
    
    component stock_weights
        port(
            clk : in std_logic;
            bi: out std_logic_vector(255 downto 0);
            wih: out std_logic_vector(2047 downto 0);
            wig: out std_logic_vector(255 downto 0);
    
            bf: out std_logic_vector(255 downto 0);
            wfh: out std_logic_vector(2047 downto 0);
            wfg: out std_logic_vector(255 downto 0);
    
            bo: out std_logic_vector(255 downto 0);
            woh: out std_logic_vector(2047 downto 0);
            wog: out std_logic_vector(255 downto 0);
    
            wmh: out std_logic_vector(2047 downto 0);
            wmc: out std_logic_vector(255 downto 0);
            bm: out std_logic_vector(255 downto 0);
            
            wfc: out std_logic_vector(255 downto 0);
            bfc: out std_logic_vector(31 downto 0)
            
        );
    end component;
    
    signal woh: std_logic_vector(2047 downto 0);
    signal wog: std_logic_vector(255 downto 0);
    signal c: std_logic_vector(255 downto 0);
    signal h: std_logic_vector(255 downto 0);
    signal x: std_logic_vector(31 downto 0);
    signal bo: std_logic_vector(255 downto 0);
    signal h_out: std_logic_vector(255 downto 0);
begin
    clk <= not clk after ClockPeriod / 2;
    
    wights: stock_weights port map (
        woh => woh,
        wog => wog,
        bo => bo,
        clk => clk
    );
    
    uut: ht port map (
        who => woh,
        wxo => wog,
        ct => c,
        ht_1 => h,
        xt => x,
        bo => bo,
        ht => h_out,
        clk => clk
    );
    
    stim_proc: process
    begin
        
        h <= x"be1b134d3e17e3f33e0bbb31be08a08e3eb8f3bd3dbf81263f06bf5f3edf2002";
        x <= x"3fa9056d";
        c <= x"be06dc013e11dac93defbacfbdd533d63eb134113d98aded3f0b00e33ee73499";
        --out <= x"bdbd7e5f 3dd1263d 3db494f3 bd9dbbc4 3e7f645e 3d7a33ed 3ebfbdc8 3ea1d1de"
        --         bdbd83d1 3dd13082 3db4b084 bd9dcb20 3e7f892f 3d7a0cab 3ec01d21 3ea1f6af
        --[[-0.09252619  0.10212371  0.08817472 -0.07701829  0.2494063   0.06108468 0.37449478  0.31605429]]        
        wait for 200 ns;
    end process;
end Behavioral;
