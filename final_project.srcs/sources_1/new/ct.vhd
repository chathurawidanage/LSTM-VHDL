

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ct is
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
end ct;

architecture ct of ct is
    component gb
        port(
            clk: in std_logic;
            h: in std_logic_vector(255 downto 0);
            wh: in std_logic_vector(2047 downto 0);
            x: in std_logic_vector(31 downto 0);
            wx: in std_logic_vector(255 downto 0);
            b: in std_logic_vector(255 downto 0);
            o: out std_logic_vector(255 downto 0)
        );
    end component;
    
    component em
        Port (
            A,B : in std_logic_vector(255 downto 0);
            O : out std_logic_vector(255 downto 0);
            CLK : in std_logic
        );
    end component;
    
    component sigmoid_arr
        Port ( 
            Y : in STD_LOGIC_VECTOR (255 downto 0);
            O : out STD_LOGIC_VECTOR (255 downto 0);
            clk: in STD_LOGIC 
        );
    end component;
    
    component tanh_arr
        Port (
            A: in std_logic_vector(255 downto 0);
            O: out std_logic_vector(255 downto 0);
            CLK : in std_logic
        );
    end component;
    
    component ma_1_8_to_1_8 is
        port(
            clk: in std_logic;
            x: in std_logic_vector(255 downto 0);
            y: in std_logic_vector(255 downto 0);
            o: out std_logic_vector(255 downto 0)
        );
    end component;
    
    signal gb1_b: std_logic_vector(255 downto 0);
    signal gb1_h: std_logic_vector(255 downto 0);
    signal gb1_wh: std_logic_vector(2047 downto 0);
    signal gb1_x: std_logic_vector(31 downto 0);
    signal gb1_wx: std_logic_vector(255 downto 0);
    signal gb1_out: std_logic_vector(255 downto 0);
    signal gb1_clk: std_logic := '0';
    
    signal gb2_b: std_logic_vector(255 downto 0);
    signal gb2_h: std_logic_vector(255 downto 0);
    signal gb2_wh: std_logic_vector(2047 downto 0);
    signal gb2_x: std_logic_vector(31 downto 0);
    signal gb2_wx: std_logic_vector(255 downto 0);
    signal gb2_out: std_logic_vector(255 downto 0);
    signal gb2_clk: std_logic := '0';
    
    signal gb3_b: std_logic_vector(255 downto 0);
    signal gb3_h: std_logic_vector(255 downto 0);
    signal gb3_wh: std_logic_vector(2047 downto 0);
    signal gb3_x: std_logic_vector(31 downto 0);
    signal gb3_wx: std_logic_vector(255 downto 0);
    signal gb3_out: std_logic_vector(255 downto 0);
    signal gb3_clk: std_logic := '0';
    
    
    signal sig1_out: std_logic_vector(255 downto 0);
    signal sig1_clk: std_logic := '0';
    
    signal sig2_out: std_logic_vector(255 downto 0);
    signal sig2_clk: std_logic := '0';
    
    signal sig3_out: std_logic_vector(255 downto 0);
    signal sig3_clk: std_logic := '0';
    
    signal tanh1_out: std_logic_vector(255 downto 0);
    signal tanh1_clk: std_logic := '0';
    
    signal em1_in1: std_logic_vector(255 downto 0);
    signal em1_out: std_logic_vector(255 downto 0);
    signal em1_clk: std_logic := '0';
    
    signal em2_out: std_logic_vector(255 downto 0);
    signal em2_clk: std_logic := '0';
    
    signal ma1_out: std_logic_vector(255 downto 0);
    signal ma1_clk: std_logic := '0';
    
begin
    
    gb1: gb port map(
        b => gb1_b,
        h => gb1_h,
        wh => gb1_wh,
        x => gb1_x,
        wx => gb1_wx,
        clk => gb1_clk,
        o => gb1_out
    );
    
    gb2: gb port map(
        b => gb2_b,
        h => gb2_h,
        wh => gb2_wh,
        x => gb2_x,
        wx => gb2_wx,
        clk => gb2_clk,
        o => gb2_out
    );
    
    gb3: gb port map(
        b => gb3_b,
        h => gb3_h,
        wh => gb3_wh,
        x => gb3_x,
        wx => gb3_wx,
        clk => gb3_clk,
        o => gb3_out
    );
    
    sig1: sigmoid_arr port map(
        Y => gb1_out,
        O => sig1_out,
        clk => sig1_clk
    );
    
    sig2: sigmoid_arr port map(
        Y => gb2_out,
        O => sig2_out,
        clk => sig2_clk
    );
    
    tanh1: tanh_arr port map(
        A => gb3_out,
        O => tanh1_out,
        CLK => tanh1_clk
    );
    
    em1: em port map(
        A => em1_in1,
        B => sig1_out,
        O => em1_out,
        CLK => em1_clk
    );
    
    em2: em port map(
        A => sig2_out,
        B => tanh1_out,
        O => em2_out,
        CLK => em1_clk
    );
    
    ma1: ma_1_8_to_1_8 port map(
        x => em1_out,
        y => em2_out,
        o => ma1_out,
        clk => ma1_clk
    );
    
    process(clk) is
    begin
         if rising_edge(clk) then
            
            gb1_b <= bf;
            gb1_h <= h;
            gb1_wh <= wfh;
            gb1_x <= x;
            gb1_wx <= wfg;
         
            gb2_b <= bi;
            gb2_h <= h;
            gb2_wh <= wih;
            gb2_x <= x;
            gb2_wx <= wig;
            
            gb3_b <= bm;
            gb3_h <= h;
            gb3_wh <= wmh;
            gb3_x <= x;
            gb3_wx <= wmc;
         
            em1_in1 <= c;
            
            c_out <= ma1_out;
            
            gb1_clk <= '1';
            gb2_clk <= '1';
            gb3_clk <= '1';
            sig1_clk <= '1';
            sig2_clk <= '1';
            tanh1_clk <= '1';
            em1_clk <= '1';
            em2_clk <= '1';
            ma1_clk <= '1';
         else
            gb1_clk <= '0';
            gb2_clk <= '0';
            gb3_clk <= '0';
            sig1_clk <= '0';
            sig2_clk <= '0';
            tanh1_clk <= '0';
            em1_clk <= '0';
            em2_clk <= '0';
            ma1_clk <= '0';
         end if;
        
    end process;

end ct;


