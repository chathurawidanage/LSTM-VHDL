library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity sigmoid is
    Port ( 
        Y : in STD_LOGIC_VECTOR (31 downto 0);
        O : out STD_LOGIC_VECTOR (31 downto 0);
        clk: in STD_LOGIC 
        );
end sigmoid;

architecture Behavioral of sigmoid is
    component float_adder
        port (
            clk: in std_logic;
            f1: in std_logic_vector(31 downto 0);
            f2: in std_logic_vector(31 downto 0);
            out1: out std_logic_vector(31 downto 0)
        );
    end component;
    
    component float_multiplier
        Port (
            A, B: in std_logic_vector(31 downto 0);
            O : out std_logic_vector(31 downto 0);
            CLK : in std_logic
        );
    end component;
    
    signal mult_clk: std_logic := '0';
    signal add_clk: std_logic := '0';
    
    signal x: std_logic_vector(31 downto 0);
    signal x2: std_logic_vector(31 downto 0);
    signal x3: std_logic_vector(31 downto 0);
    signal x4: std_logic_vector(31 downto 0);
    signal x5: std_logic_vector(31 downto 0);
    
    signal xfac: std_logic_vector(31 downto 0);
    signal x2fac: std_logic_vector(31 downto 0);
    signal x3fac: std_logic_vector(31 downto 0);
    signal x4fac: std_logic_vector(31 downto 0);
    signal x5fac: std_logic_vector(31 downto 0);
    
    signal const: std_logic_vector(31 downto 0);
    
    signal xfac_out: std_logic_vector(31 downto 0);
    signal x2fac_out: std_logic_vector(31 downto 0);
    signal x3fac_out: std_logic_vector(31 downto 0);
    signal x4fac_out: std_logic_vector(31 downto 0);
    signal x5fac_out: std_logic_vector(31 downto 0);
    
    signal add0_out: std_logic_vector(31 downto 0);
    signal add1_out: std_logic_vector(31 downto 0);
    signal add2_out: std_logic_vector(31 downto 0);
    signal add3_out: std_logic_vector(31 downto 0);
    signal add4_out: std_logic_vector(31 downto 0);
    
     
       
begin

   fm0: float_multiplier port map (
        CLK => mult_clk,
        A => x,
        B => x,
        O => x2
    );
    
    fm1: float_multiplier port map (
        CLK => mult_clk,
        A => x,
        B => x2,
        O => x3
    );
    
    fm2: float_multiplier port map (
        CLK => mult_clk,
        A => x2,
        B => x2,
        O => x4
    );
    
    fm3: float_multiplier port map (
        CLK => mult_clk,
        A => x2,
        B => x3,
        O => x5
    );
    
    fm4: float_multiplier port map (
        CLK => mult_clk,
        A => x,
        B => xfac,
        O => xfac_out
    );
    
    
    fm5: float_multiplier port map (
        CLK => mult_clk,
        A => x2,
        B => x2fac,
        O => x2fac_out
    );
    
    fm6: float_multiplier port map (
        CLK => mult_clk,
        A => x3,
        B => x3fac,
        O => x3fac_out
    );
    
    fm7: float_multiplier port map (
        CLK => mult_clk,
        A => x4,
        B => x4fac,
        O => x4fac_out
    );
    
    fm8: float_multiplier port map (
        CLK => mult_clk,
        A => x5,
        B => x5fac,
        O => x5fac_out
    );
    
    fa0: float_adder port map (
        clk => add_clk,
        f1 => const,
        f2 => xfac_out,
        out1 => add0_out
    );
    
    fa1: float_adder port map (
        clk => add_clk,
        f1 => x2fac_out,
        f2 => x3fac_out,
        out1 => add1_out
    );
    
    fa2: float_adder port map (
        clk => add_clk,
        f1 => x4fac_out,
        f2 => x5fac_out,
        out1 => add2_out
    );
    
    fa3: float_adder port map (
        clk => add_clk,
        f1 => add0_out,
        f2 => add1_out,
        out1 => add3_out
    );
    
    fa4: float_adder port map (
        clk => add_clk,
        f1 => add3_out,
        f2 => add2_out,
        out1 => add4_out
    );

    process (clk) 
    
        variable exponent: integer := 0;
        variable mant: integer := 0;
        variable sign: std_logic := '0';
            
    
    begin
        if rising_edge(clk) then
        
           
           x <= Y;
           O <= x5;
           
           exponent := to_integer(unsigned(Y(30 downto 23)));
           mant := to_integer(unsigned(Y(22 downto 0)));
           sign := Y(31);
           
           const <= x"3f000000"; -- 1/2
           xfac <= x"3e800000"; -- 1/4
           x2fac <= x"00000000";
           x3fac <= x"bcaaaaa9"; -- -1/48
           x4fac <= x"00000000"; -- 0.0
           x5fac <= x"3b088887"; -- 1/480
           
           if sign = '0' then
                if exponent > 126 then
                    if mant > 4194303 then -- if Y >= 1.5
                        const <= x"3edb354c"; -- 0.428141
                        xfac <= x"3ec9198b"; -- 0.392773
                        x2fac <= x"bddea140"; -- -0.108706
                        x3fac <= x"3c690364"; -- 0.014222
                        x4fac <= x"ba4069e8"; -- -0.000734
                        x5fac <= x"00000000"; -- 0.0
                        --report "1.5 <= x";
                    end if;
                end if;
           else
                if exponent > 126 then
                    if mant > 4194303 then -- if Y <= -1.5
                        const <= x"3f12655a"; -- 0.571859
                        xfac <= x"3ec9198b"; -- 0.392773
                        x2fac <= x"3ddea140"; -- 0.108706
                        x3fac <= x"3c690364"; -- 0.014222
                        x4fac <= x"3a4069e8"; -- 0.000734
                        x5fac <= x"00000000"; -- 0.0
                        --report "-1.5 >= x";
                    end if;
                end if;
           end if;
           o <= add4_out;
           mult_clk <= '1';
           add_clk <= '1';
        else
        
            mult_clk <= '0';
            add_clk <= '0';
        end if;
    end process;

    

end Behavioral;
