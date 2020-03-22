library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ct_tb is
--  Port ( );
end ct_tb;

architecture ct_tb of ct_tb is

    constant ClockFrequency : integer := 100e6;
    constant ClockPeriod : time := 1000 ms / ClockFrequency;
    
    signal clk : std_logic := '1';
    
    component ct
        port ( 
            clk: in std_logic;
            wfh: in std_logic_vector(2047 downto 0);
            wih: in std_logic_vector(2047 downto 0);
            wmh: in std_logic_vector(2047 downto 0);
            wfg: in std_logic_vector(255 downto 0);
            wig: in std_logic_vector(255 downto 0);
            wmc: in std_logic_vector(255 downto 0);
            c: in std_logic_vector(255 downto 0);
            h: in std_logic_vector(255 downto 0);
            x: in std_logic_vector(31 downto 0);
            bf: in std_logic_vector(255 downto 0);
            bi: in std_logic_vector(255 downto 0);
            bm: in std_logic_vector(255 downto 0);
            c_out: out std_logic_vector(255 downto 0)
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
    
    signal wfh: std_logic_vector(2047 downto 0);
    signal wih: std_logic_vector(2047 downto 0);
    signal wmh: std_logic_vector(2047 downto 0);
    signal wfg: std_logic_vector(255 downto 0);
    signal wig: std_logic_vector(255 downto 0);
    signal wmc: std_logic_vector(255 downto 0);
    signal c: std_logic_vector(255 downto 0);
    signal h: std_logic_vector(255 downto 0);
    signal x: std_logic_vector(31 downto 0);
    signal bf: std_logic_vector(255 downto 0);
    signal bi: std_logic_vector(255 downto 0);
    signal bm: std_logic_vector(255 downto 0);
    signal c_out: std_logic_vector(255 downto 0);
begin

    clk <= not clk after ClockPeriod / 2;
    
    wights: stock_weights port map (
        wfh => wfh,
        wih => wih,
        wmh => wmh,
        wfg => wfg,
        wig => wig,
        wmc => wmc,
        bf => bf,
        bi => bi,
        bm => bm,
        clk => clk
    );
    
    uut: ct port map (
        wfh => wfh,
        wih => wih,
        wmh => wmh,
        wfg => wfg,
        wig => wig,
        wmc => wmc,
        c => c,
        h => h,
        x => x,
        bf => bf,
        bi => bi,
        bm => bm,
        c_out => c_out,
        clk => clk
    );
    
    stim_proc: process
    begin
        
        c <= x"be11501a3e1953593e1d864fbe1929f13ea01df53e396f2e3e3870d63ded216d";
        h <= x"be568e8e3e5a5f343e5cbeb0be5beee03ed1c52f3e75b5553e7ab6573e2640d5";
        x <= x"3fa7785c";
        
        wait for 200 ns;
    end process;
end ct_tb;
