library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mm_1_1_by_1_8 is
    port(
        clk: std_logic;
        x : in std_logic_vector(31 downto 0);
        y : in std_logic_vector(255 downto 0);
        o : out std_logic_vector(255 downto 0)
    );
end mm_1_1_by_1_8;

architecture mm_1_1_by_1_8 of mm_1_1_by_1_8 is

    component float_multiplier
        Port (
            A, B: in std_logic_vector(31 downto 0);
            O : out std_logic_vector(31 downto 0);
            CLK : in std_logic
        );
    end component;
    
    
    signal mult_f2_0: std_logic_vector(31 downto 0);
    signal mult_out_0: std_logic_vector(31 downto 0);
    
    signal mult_f2_1: std_logic_vector(31 downto 0);
    signal mult_out_1: std_logic_vector(31 downto 0);
    
    signal mult_f2_2: std_logic_vector(31 downto 0);
    signal mult_out_2: std_logic_vector(31 downto 0);
    
    signal mult_f2_3: std_logic_vector(31 downto 0);
    signal mult_out_3: std_logic_vector(31 downto 0);
    
    signal mult_f2_4: std_logic_vector(31 downto 0);
    signal mult_out_4: std_logic_vector(31 downto 0);
    
    signal mult_f2_5: std_logic_vector(31 downto 0);
    signal mult_out_5: std_logic_vector(31 downto 0);
    
    signal mult_f2_6: std_logic_vector(31 downto 0);
    signal mult_out_6: std_logic_vector(31 downto 0);
    
    signal mult_f2_7: std_logic_vector(31 downto 0);
    signal mult_out_7: std_logic_vector(31 downto 0);
    
    signal mult_clk: std_logic := '0';
    
begin

    
    fm0: float_multiplier port map (
        CLK => mult_clk,
        A => x,
        B => mult_f2_0,
        O => mult_out_0
    );
    
    fm1: float_multiplier port map (
        CLK => mult_clk,
        A => x,
        B => mult_f2_1,
        O => mult_out_1
    );
    
    fm2: float_multiplier port map (
        CLK => mult_clk,
        A => x,
        B => mult_f2_2,
        O => mult_out_2
    );
    
    fm3: float_multiplier port map (
        CLK => mult_clk,
        A => x,
        B => mult_f2_3,
        O => mult_out_3
    );
    
    fm4: float_multiplier port map (
        CLK => mult_clk,
        A => x,
        B => mult_f2_4,
        O => mult_out_4
    );
    
    fm5: float_multiplier port map (
        CLK => mult_clk,
        A => x,
        B => mult_f2_5,
        O => mult_out_5
    );
    
    fm6: float_multiplier port map (
        CLK => mult_clk,
        A => x,
        B => mult_f2_6,
        O => mult_out_6
    );
    
    fm7: float_multiplier port map (
        CLK => mult_clk,
        A => x,
        B => mult_f2_7,
        O => mult_out_7
    );
    
    process(clk) is
    begin
        if rising_edge(clk) then
            
            mult_f2_0 <= y(31 downto 0);
            mult_f2_1 <= y(63 downto 32);
            mult_f2_2 <= y(95 downto 64);
            mult_f2_3 <= y(127 downto 96);
            mult_f2_4 <= y(159 downto 128);
            mult_f2_5 <= y(191 downto 160);
            mult_f2_6 <= y(223 downto 192);
            mult_f2_7 <= y(255 downto 224);

            o <= mult_out_7 & mult_out_6 & mult_out_5 & mult_out_4 & mult_out_3 & mult_out_2 & mult_out_1 & mult_out_0;
            
            mult_clk <= '1';
        else
            mult_clk <= '0';
        end if;
    end process;
end mm_1_1_by_1_8;

