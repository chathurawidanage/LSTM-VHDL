library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ma_1_8_to_1_8_tb is
--  Port ( );
end ma_1_8_to_1_8_tb;

architecture ma_1_8_to_1_8_tb of ma_1_8_to_1_8_tb is
    constant ClockFrequency : integer := 100e6;
    constant ClockPeriod : time := 1000 ms / ClockFrequency;
    
    signal clk : std_logic := '1';
    
    component ma_1_8_to_1_8
        port(
        clk: in std_logic;
        x: in std_logic_vector(255 downto 0);
        y: in std_logic_vector(255 downto 0);
        o: out std_logic_vector(255 downto 0)
        );
    end component;
    signal x: std_logic_vector(255 downto 0) := (others => '0');
    signal y: std_logic_vector(255 downto 0) := (others => '0');
    signal o: std_logic_vector(255 downto 0) := (others => '0');
begin

    MA: ma_1_8_to_1_8 port map (
        x => x,
        y => y,
        o => o,
        clk => clk
    );
    
    clk <= not clk after ClockPeriod / 2;
    
    process is
    begin
        x <= x"3fa000003fa000003fa000003fa000003fa000003fa000003fa000003e800000"; -- 1.25
        y <= x"3e8000003e8000003e8000003e8000003e8000003e8000003e8000003fa00000"; -- 0.25
        
        wait for 60 ns;
        x <= x"3fa000003fa000003fa000003fa000003fa000003fa000003fa000003e800000";
        y <= x"3fa000003fa000003fa000003fa000003fa000003fa000003fa000003e800000";
    
        wait for 60 ns;
        
        wait;
    end process;
end ma_1_8_to_1_8_tb;
