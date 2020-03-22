library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity gb is
    port(
        clk: std_logic;
        h: in std_logic_vector(255 downto 0);
        wh: in std_logic_vector(2047 downto 0);
        x: in std_logic_vector(31 downto 0);
        wx: in std_logic_vector(255 downto 0);
        b: in std_logic_vector(255 downto 0);
        o: out std_logic_vector(255 downto 0)
    );
end gb;

architecture gb of gb is

    component mm_1_1_by_1_8
        port(
        clk: in std_logic;
        x: in std_logic_vector(31 downto 0);
        y: in std_logic_vector(255 downto 0);
        o: out std_logic_vector(255 downto 0)
        );
    end component;
    
    component m2_1n_to_nn is
        Port ( 
            A: in std_logic_vector(255 downto 0);
            B: in std_logic_vector(2047 downto 0);
            O : out std_logic_vector(255 downto 0);
            CLK : in std_logic
        );
    end component;
    
    component ma_1_8_to_1_8
        port(
        clk: in std_logic;
        x: in std_logic_vector(255 downto 0);
        y: in std_logic_vector(255 downto 0);
        o: out std_logic_vector(255 downto 0)
        );
    end component;
    
    signal mm2_h: std_logic_vector(255 downto 0);
    signal mm2_wh: std_logic_vector(2047 downto 0);
    signal mm1_x: std_logic_vector(31 downto 0);
    signal mm1_wx: std_logic_vector(255 downto 0);
    signal ma1_f0: std_logic_vector(255 downto 0);
    signal ma1_f1: std_logic_vector(255 downto 0);
    signal ma2_f0: std_logic_vector(255 downto 0);
    signal ma2_b: std_logic_vector(255 downto 0);
    signal ma2_out: std_logic_vector(255 downto 0);
    
    signal mm2_clk: std_logic := '0';
    signal mm1_clk: std_logic := '0';
    signal ma2_clk: std_logic := '0';
    signal ma1_clk: std_logic := '0';
begin

    mm2: m2_1n_to_nn port map (
        A => mm2_h,
        B => mm2_wh,
        CLK => mm2_clk,
        O => ma1_f0
    );
    
    mm1: mm_1_1_by_1_8 port map (
        x => mm1_x,
        y => mm1_wx,
        o => ma1_f1,
        clk => mm1_clk
    );

    ma1: ma_1_8_to_1_8 port map (
        x => ma1_f0,
        y => ma1_f1,
        o => ma2_f0,
        clk => ma1_clk
    );
    
    ma2: ma_1_8_to_1_8 port map (
        x => ma2_f0,
        y => ma2_b,
        o => ma2_out,
        clk => ma2_clk
    );
    
    process(clk) is
    begin
        if rising_edge(clk) then
            mm2_h <= h;
            mm2_wh <= wh;
            mm1_x <= x;
            mm1_wx <= wx;
            ma2_b <= b;
            
            o <= ma2_out;
            
            mm1_clk <= '1';
            mm2_clk <= '1';
            ma1_clk <= '1';
            ma2_clk <= '1';
        else
            mm1_clk <= '0';
            mm2_clk <= '0';
            ma1_clk <= '0';
            ma2_clk <= '0';
        end if;
    end process;    
   
    
end gb;
