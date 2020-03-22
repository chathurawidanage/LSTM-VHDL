
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ht is
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
end ht;

architecture ht of ht is

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
    
    signal gb_o: std_logic_vector(255 downto 0);
    signal sig_o: std_logic_vector(255 downto 0);
    signal tanh_o: std_logic_vector(255 downto 0);
begin
    gb_blck: gb port map (clk=>clk, b=>bo, h=>ht_1, wh=>who, x=>xt, wx=> wxo, o=>gb_o);
    sig_ar: sigmoid_arr port map(clk=>clk, Y=> gb_o, o=>sig_o);
    tanh_ar: tanh_arr port map(clk=>clk, A=> ct, O=>tanh_o);
    em_proc: em port map (CLK=>clk, A=>tanh_o, B=>sig_o, O=>ht);
end ht;
