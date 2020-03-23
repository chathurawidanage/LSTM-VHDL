library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity lstm_unit_tb is
--  Port ( );
end lstm_unit_tb;

architecture lstm_unit_tb of lstm_unit_tb is
    constant ClockFrequency : integer := 100e6;
    constant ClockPeriod : time := 1000 ms / ClockFrequency;
    
    signal clk : std_logic := '1';
    
    component lstm_unit
        port(
        clk: in std_logic;
            c: in std_logic_vector(255 downto 0);
            h: in std_logic_vector(255 downto 0);
            x: in std_logic_vector(31 downto 0);
            c_out: out std_logic_vector(255 downto 0);
            h_out: out std_logic_vector(255 downto 0)
        );
    end component;
    
    signal c: std_logic_vector(255 downto 0);
    signal h: std_logic_vector(255 downto 0);
    signal x: std_logic_vector(31 downto 0);
    signal c_out: std_logic_vector(255 downto 0);
    signal h_out: std_logic_vector(255 downto 0);
    
begin

    clk <= not clk after ClockPeriod / 2;
    
    lstm1: lstm_unit port map(
        c => c,
        h => h,
        x => x,
        clk => clk,
        c_out => c_out,
        h_out => h_out
    );
    
    stim_proc: process
    begin
        
        c <= x"be4c19ae3e4797843e2e25fbbf0de3e0bf115070be3076a8be22ff563e49e5f9";
        h <= x"be1dbdc03e09cd883df56bd0beb26c58bec259bdbe0a3c51bdec80053e11329c";
        x <= x"3fabb247";

        -- state <= x"be3d6b32 3e7111b2 3e2e067f bf21aae2 bf20420f be206824 be0a5555 3e4f7d39"
        --            be3d71dc 3e7111e2 3e2e0698 bf21e8c0 bf206f07 be206f4d be0a5569 3e4f7d63
        -- out <= x"be140020 3e261845 3df6caad bec4850a bed08218 bdfe1ae4 bdca69ba 3e160d03"
        --          be14433e 3e261cc1 3df6d4c3 bec56b38 bed168c0 bdfead6f bdca79df 3e161805
        -- [[-0.14453173  0.16220196  0.12050376 -0.38382751 -0.40724253 -0.12407472 -0.09883447  0.14653401]]

        
        wait for 200 ns;
    end process;
end lstm_unit_tb;
