library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_net_tb is
--  Port ( );
end full_net_tb;

architecture full_net_tb of full_net_tb is

    constant ClockFrequency : integer := 500e6;
    constant ClockPeriod : time := 1000 ms / ClockFrequency;
    
    signal clk : std_logic := '1';

    component full_net
        port(
            clk: in std_logic;
            net_in: in std_logic_vector(223 downto 0);
            net_out: out std_logic_vector(31 downto 0)
        );
     end component;
     
     signal net_in : std_logic_vector(223 downto 0);
     signal net_out :  std_logic_vector(31 downto 0);
begin

    UUT: full_net port map(net_in=>net_in, net_out=>net_out, clk=>clk);

    clk <= not clk after ClockPeriod / 2;

    stim_proc: process
    begin
        
        net_in <= x"406089e840452e0f40460634405447bd4045d503405fff1e406c785c";
        -- 40612aae   3.5182299614
        -- 40607297   3.50699400902
        wait for 200 ns;
        wait;
    end process;
end full_net_tb;
