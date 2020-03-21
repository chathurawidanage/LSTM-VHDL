library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity sigmoid_tb is
--  Port ( );
end sigmoid_tb;

architecture sigmoid_tb of sigmoid_tb is
    constant ClockFrequency : integer := 100e6;
    constant ClockPeriod : time := 1000 ms / ClockFrequency;
    
    signal clk : std_logic := '1';
    
    component sigmoid
        port(
        clk: in std_logic;
        Y: in std_logic_vector(31 downto 0);
        O: out std_logic_vector(31 downto 0)
        );
    end component;
    signal Y: std_logic_vector(31 downto 0) := (others => '0');
    signal O: std_logic_vector(31 downto 0) := (others => '0');
begin
    SIG: sigmoid port map (
        Y => Y,
        O => O,
        clk => clk
    );
    
    clk <= not clk after ClockPeriod / 2;
    
    process is
    begin
    
        Y <= x"bfc00000"; -- -1.5
        
        wait for 160 ns;
        
        Y <= x"bfc66666"; -- -1.55
        
        wait for 160 ns;
        
        Y <= x"bfb9999a"; -- -1.45
        
        wait for 160 ns;
        
    
        Y <= x"3fc00000"; -- 1.5
        
        wait for 160 ns;
        
        Y <= x"3fc66666"; -- 1.55
        
        wait for 160 ns;
        
        Y <= x"3fb9999a"; -- 1.45
        
        wait for 160 ns;
        
        Y <= x"3fa00000"; -- 1.25
        
        wait for 160 ns;

        Y <= x"3e800000"; -- 0.25
        
        wait for 160 ns;
        
      
        Y <= x"bc23d70a";  -- -0.01
    
        wait for 160 ns;
        
        
        Y <= x"bfa00000";  -- -1.25 
        
        wait for 160 ns;
   
        wait;
    end process;

end sigmoid_tb;
