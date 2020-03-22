
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ht_tb is
--  Port ( );
end ht_tb;

architecture ht_tb of ht_tb is

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
    signal c_out: std_logic_vector(255 downto 0);

begin

    clk <= not clk after ClockPeriod / 2;
    
    wights: stock_weights port map (
        woh=>woh,
        wog=>wog,
        bo => bo,
        clk => clk
    );
    
    uut: ht port map (clk=>clk, xt=>x, bo=>bo,ht_1=>h,who=>woh, wxo=>wog,ct=>c, ht=>c_out);
    
    stim_proc: process
    begin
        
        c <= x"be11501a3e1953593e1d864fbe1929f13ea01df53e396f2e3e3870d63ded216d";
        h <= x"be568e8e3e5a5f343e5cbeb0be5beee03ed1c52f3e75b5553e7ab6573e2640d5";
        x <= x"3fa7785c";
        
        wait for 200 ns;
    end process;
    


end ht_tb;
