
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity lstm_unit is
    port(
        clk: in std_logic;
        c: in std_logic_vector(255 downto 0);
        h: in std_logic_vector(255 downto 0);
        x: in std_logic_vector(31 downto 0);
        c_out: out std_logic_vector(255 downto 0);
        h_out: out std_logic_vector(255 downto 0)
    );
end lstm_unit;

architecture lstm_unit of lstm_unit is
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
    
    signal ct_clk: std_logic := '0';
    signal ct_wfh: std_logic_vector(2047 downto 0);
    signal ct_wih: std_logic_vector(2047 downto 0);
    signal ct_wmh: std_logic_vector(2047 downto 0);
    signal ct_wfg: std_logic_vector(255 downto 0);
    signal ct_wig: std_logic_vector(255 downto 0);
    signal ct_wmc: std_logic_vector(255 downto 0);
    signal ct_c: std_logic_vector(255 downto 0);
    signal ct_h: std_logic_vector(255 downto 0);
    signal ct_x: std_logic_vector(31 downto 0);
    signal ct_bf: std_logic_vector(255 downto 0);
    signal ct_bi: std_logic_vector(255 downto 0);
    signal ct_bm: std_logic_vector(255 downto 0);
    signal ct_c_out: std_logic_vector(255 downto 0);
    
    signal ht_clk: std_logic := '0';
    signal ht_woh: std_logic_vector(2047 downto 0);
    signal ht_wog: std_logic_vector(255 downto 0);
    signal ht_h: std_logic_vector(255 downto 0);
    signal ht_x: std_logic_vector(31 downto 0);
    signal ht_bo: std_logic_vector(255 downto 0);
    signal ht_h_out: std_logic_vector(255 downto 0);
    
    signal stock_clk: std_logic := '0';
begin

    ct1: ct port map(
        clk => ct_clk,
        wfh => ct_wfh,
        wih => ct_wih,
        wmh => ct_wmh,
        wfg => ct_wfg,
        wig => ct_wig,
        wmc => ct_wmc,
        c => ct_c,
        h => ct_h,
        x => ct_x,
        bf => ct_bf,
        bi => ct_bi,
        bm => ct_bm,
        c_out => ct_c_out
    );
    
    ht1: ht port map(
        clk => ht_clk,
        who => ht_woh,
        wxo => ht_wog,
        ct => ct_c_out,
        ht_1 => ht_h,
        xt => ht_x,
        bo => ht_bo,
        ht => ht_h_out
    );
    
    wights: stock_weights port map (
        wfh => ct_wfh,
        wih => ct_wih,
        wmh => ct_wmh,
        wfg => ct_wfg,
        wig => ct_wig,
        wmc => ct_wmc,
        bf => ct_bf,
        bi => ct_bi,
        bm => ct_bm,
        woh => ht_woh,
        wog => ht_wog,
        bo => ht_bo,
        clk => stock_clk
    );
    
    process(clk) is
    begin
    
        if rising_edge(clk) then
            ct_c <= c;
            ct_h <= h;
            ct_x <= x;
            
            ht_h <= h;
            ht_x <= x;
            
            c_out <= ct_c_out;
            h_out <= ht_h_out;
            
            stock_clk <= '1';
            ct_clk <= '1';
            ht_clk <= '1';
        else
            stock_clk <= '0';
            ct_clk <= '0';
            ht_clk <= '0';
        end if;
    end process;
    

end lstm_unit;
