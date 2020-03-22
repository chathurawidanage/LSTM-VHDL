library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ct_tb is
--  Port ( );
end ct_tb;

architecture ct_tb of ct_tb is

    constant ClockFrequency : integer := 100e6;
    constant ClockPeriod : time := 1000 ms / ClockFrequency;
    
    signal clk : std_logic := '1';
    
    component ct
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
    
    end component;
    
    signal wfh: std_logic_vector(2047 downto 0);
    signal wih: std_logic_vector(2047 downto 0);
    signal wmh: std_logic_vector(2047 downto 0);
    signal wfg: std_logic_vector(255 downto 0);
    signal wig: std_logic_vector(255 downto 0);
    signal wmc: std_logic_vector(255 downto 0);
    signal c: std_logic_vector(255 downto 0);
    signal h: std_logic_vector(255 downto 0);
    signal x: std_logic_vector(31 downto 0);
    signal bf: std_logic_vector(255 downto 0);
    signal bi: std_logic_vector(255 downto 0);
    signal bm: std_logic_vector(255 downto 0);
    signal c_out: std_logic_vector(255 downto 0);
begin

    clk <= not clk after ClockPeriod / 2;
    
    uut: ct port map (
        wfh => wfh,
        wih => wih,
        wmh => wmh,
        wfg => wfg,
        wig => wig,
        wmc => wmc,
        c => c,
        h => h,
        x => x,
        bf => bf,
        bi => bi,
        bm => bm,
        c_out => c_out,
        clk => clk
    );
    
    stim_proc: process
    begin
        
        c <= x"be11501a3e1953593e1d864fbe1929f13ea01df53e396f2e3e3870d63ded216d";

        bf <= x"bd8dc00bbd21bd643c0d180fbc5689b2bec174943d690ad43e4d17ef3dee76de";
        
        h <= x"be568e8e3e5a5f343e5cbeb0be5beee03ed1c52f3e75b5553e7ab6573e2640d5";
        
        wfh <= x"3e0b48b03db236d43e00b4433cebddad3f8fb42d3d33536c3e42b319bda81082bddffa27bdf91502bdd6272c3ba032d2bf769088bd3049a2be6142213e028155bdc7c95fbe0675fbbe0d6e98bd0853c6bf2b699ebd8d8b6abe8ae5dd3ddc5fd03cf670523df33a4e3d0bd16d3ce0f0aa3f5117c13df3700f3e3d909bbe2b2227be88e1adbe93d274beb74123be9fb14bbf285a7dbf0844ddbefa7cb0be8289adbdd71f97be4576d0bdbe0d33bde7296dbebe8c71be072fffbebcf34f3d9ae7ebbe05c567be091e9ebe457022bd26ce6abf0decb1bd833ee7bcbcbe9cbd47064fbd9b59bebe313350bd5e725abdc7b704bf41088dbe01be80bdc838cebd1b2419";
        
        x <= x"3fa7785c";
        
        wfg <= x"3e91f8983ecb6d143ead2b1a3eb854e5bfa31fb53e6bddc23ec5b9683e978a65";
        
        bi <= x"3dddedd8bcf8b1e53e050a353d7b84653ee644473eaf36253e6c8a923dd755c1";
        
        wih <= x"be27e56ebe452eeabe3a8155be34fdd83d26d967be9c63053de3b4793c8490383e4d95e73e398c9f3e871fb43e198a0ebe04fda93e934053be1e02d33c9985933e5b77933ea603013e870fa63e3a2b24be41da463e8fb8edbe54ff11bbb82b87be3c4533bec78fddbe9eaeafbeaeda213e27380ebeb03a4c3ddf595dbd31265fbe8df93abedb7716bebfebd4beb865edbf37ab42bebada54beed40d0bed1435e3e8a56383ecd92233ebf94fc3e896978be2c127c3eb61b77be50493bbd49b3583d918d5ebd000ddf3c7914fcbd9b07bfbe70707cbc47921cbcf66770bde8461f3cad5db53d9a56ea3dd3cd443db7b664bd4e1db33dfeb5473d5e05903bd59d17";
        
        wig <= x"3e9ac5e23e99486f3e9e10263eaa095e3eceb7063ed8075a3e6a3fa93e8ff07c";
        
        bm <= x"3cb43f0dbd151261bd94c22d3d8ec18abdfc2986bde60ca4be2cfb7dbd98365f";
        
        wmh <= x"bdd301ee3e37e8b93dcc0ecebda7b3a33c93cc7c3e410ad1bdeb0815be3561a03e406a9cbe767554bdf0cf353e6fd499bdd49314be3423f73d96a3a83d9fe47b3d6532b5be5b56fbbe3ba57f3dee94a03d967a20be5d63533e96ae143ddfe15bbe1e06b63e3de8eb3e72430dbe1bde92bdad6acc3e4c522dbe92b3cbbe5972733c7de3063d4be5f6bc1e4a8a3d06bf1e3c0e1b02bd61bb123e59123f3e847c4f3cecd68ebe383c2fbdbcea4f3c746d993e8ea323be2e35263ec9e39d3e4edb773e4fc8b6bdb266b2bdebc0e33e561d8d3b2593ebbe0089dd3d1a178c3d72f2303dbf6e17be2c8967be647fbb3e2f782abe047573be502ec53d1f4cb83cbeada3";
        wmc <= x"be8f6e423ea043b93ea58d85bea5f8693f12e8023eb32cec3edfc1ec3e84e0ee";
        

        wait for 200 ns;
    end process;
end ct_tb;
