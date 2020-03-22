library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity gb_tb is
--  Port ( );
end gb_tb;

architecture Behavioral of gb_tb is
    
    constant ClockFrequency : integer := 100e6;
    constant ClockPeriod : time := 1000 ms / ClockFrequency;
    
    signal clk : std_logic := '1';
    
    component gb
        Port(
            clk: std_logic;
            h: in std_logic_vector(255 downto 0);
            wh: in std_logic_vector(2047 downto 0);
            x: in std_logic_vector(31 downto 0);
            wx: in std_logic_vector(255 downto 0);
            b: in std_logic_vector(255 downto 0);
            o: out std_logic_vector(255 downto 0)
        );
    end component;
    
    signal h: std_logic_vector(255 downto 0);
    signal wh: std_logic_vector(2047 downto 0);
    signal x: std_logic_vector(31 downto 0);
    signal wx: std_logic_vector(255 downto 0);
    signal b: std_logic_vector(255 downto 0);
    signal o: std_logic_vector(255 downto 0);
begin

    clk <= not clk after ClockPeriod / 2;
    
    uut: gb port map (clk=>clk, h=>h, wh=>wh, x=>x, wx=>wx, b=>b, o=>o);
    stim_proc: process
    begin
        
        wx <= x"3e9ac5e23e99486f3e9e10263eaa095e3eceb7063ed8075a3e6a3fa93e8ff07c";
        
        x <= x"3fabb247";
        
    
        wh <= x"be27e56ebe452eeabe3a8155be34fdd83d26d966be9c63053de3b4793c8490383e4d95e73e398c9f3e871fb43e198a0ebe04fda93e934053be1e02d33c9985923e5b77933ea603013e870fa63e3a2b24be41da463e8fb8edbe54ff11bbb82b80be3c4533bec78fddbe9eaeafbeaeda213e27380ebeb03a4c3ddf595ebd31265ebe8df93abedb7716bebfebd4beb865edbf37ab42bebada54beed40d0bed1435e3e8a56383ecd92233ebf94fc3e896978be2c127c3eb61b77be50493bbd49b3583d918d5ebd000ddf3c7914ffbd9b07bfbe70707cbc47921bbcf66770bde846203cad5db73d9a56ea3dd3cd443db7b664bd4e1db23dfeb5473d5e058f3bd59d15";
        b <= x"3dddedd8bcf8b1e33e050a353d7b84653ee644473eaf36253e6c8a923dd755c1";
        -- h <= x"3e9ac5e23e99486f3e9e10263eaa095e3eceb7063ed8075a3e6a3fa93e8ff07c";
        h <= x"be344f803e2396d73e28b0cdbe2dd9a63ec053683e0542d13ee5990e3eb9004b";
        --out = 0.61183435, 0.45811522, 0.66640993, 0.54799445, 0.48962879, 1.06126315, 0.24640113, 0.28036817

        
        wait for 200 ns;
    end process;

end Behavioral;
