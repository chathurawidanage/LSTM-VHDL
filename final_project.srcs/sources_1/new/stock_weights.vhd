
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity stock_weights is
    port(
        
        clk : in std_logic;
        bi: out std_logic_vector(255 downto 0);
        wih: out std_logic_vector(2047 downto 0);
        wig: out std_logic_vector(255 downto 0);

        bf: out std_logic_vector(255 downto 0);
        wfh: out std_logic_vector(2047 downto 0);
        wfg: out std_logic_vector(255 downto 0);

        bo: out std_logic_vector(255 downto 0);
        woh: out std_logic_vector(2047 downto 0);
        wog: out std_logic_vector(255 downto 0);

        wmh: out std_logic_vector(2047 downto 0);
        wmc: out std_logic_vector(255 downto 0);
        bm: out std_logic_vector(255 downto 0);
        
        wfc: out std_logic_vector(255 downto 0);
        bfc: out std_logic_vector(31 downto 0)
        
    );
end stock_weights;

architecture stock_weights of stock_weights is

begin

    process(clk) is
    begin
        bi <= x"3e9f92483e1f11be3e1a8e333eb4e4d83ee1c6823eb5ba7d3e785fce3e3d894a";
        wih <= x"be2c63c6be1cbd53bd0003763b9e347a3e2fb6d7be5bf08bbd39b3c73d02cb883d133f6b3d54daa23cd7467ebe053d31be3fe4053d95f4433db641dc3cbe57863e5a72113e48d3af3cd816e7bd39fb32bde4db643e6ce7f53e20f7a9bd560c18bd211ec73dc6f3cd3daceb663edc475d3ed44c87bc8a9f603e06f9693e4bd8ca3e03561b3e6ce3263e43428e3f04c15c3f0976a33d418ddd3e9a3f0a3e79ae59be470617be219993bdb723f53cf515cb3de43bbbbe88e08bbe13531dbdddcf9fbe177a78be208518bdaeed303e2155a23e7c0108be292062bd2cdb53bd143a683e12323f3d659cb9bc1af3acb9b82fc0bdb85d3e3e5f17f53e02bd44bd1d0bd3";
        wig <= x"3eea08c63e7c2d4a3ea998d93e8851c43e3e09973ed19ed63e98cd133ec6c4c8";
        bf <= x"3d17b8a23dbf20f4bcad2d753ea56a833ef1ca923c863be33de0548a3cfa9206";
        wfh <= x"3e6ed0b63bc46c973e5964f13c75bf573e3882ad3e2156783e8366d83e2c8230be9f71333d0a93c9be263743bddf8adabe9592cebe52d682be49ea7abe3e4803be8e098bbcd43dadbe169545bcbe1376be0c9543be491d02be459cb3bdeaecbf3e3a3df43e1e3c8d3e9ed70a3eb8e2a93ed203693e3943be3ec9e5213e8352e43ea96e483e3088ef3eb1d1913eebe50e3f0f7f4b3eaf6d9a3ef6cfd23eb8c0133e812c9bbcca3e583e6002a4bd2de1d43d9d119c3e93b6973e94c9533e1432bc3e476eab3dd0692d3e90a3b13e25ca8b3ea546243e7ccea83e9a1a833e8c2d20be6681223cc98c75be8d722cbe01d487be411ca3be1ab9fbbe4ae37dbe420a29";
        wfg <= x"3e3489033e5082da3e87b2413e5b878e3e8dde303e1df48d3e76efa53e5294bc";
        bo <= x"3ec38d8f3e6a65f43e593a033eca0dcf3f1793dc3ef8e8173eb1f5e83e861122";
        woh <= x"bec2bf50bd71c9eebe3183f5bdf1e667be4044e8beab4226be3e82e8be44ce5d3e28dade3e0766793e7b882a3d4cec2f3cc96d6a3e3571e53e8652a03e02b6913e91c7b03e3c3afd3e375e4c3e1e65913ce1b9e83ea4b88d3e78229b3e4da208be0b275a3d9e45c43d9601693e5fbb0e3e806e0fbe5ee9193cdd34c0bd8710acbe0f057a3dd03d673cbe3ac63ee0a7483ed40230bd55d7613d4c14163d880ed7be9c94a3be181facbe3fda2fbe2bc9babe629e13bea47082bea51021be5bbb3cbec45a3bbd8b1e12be4e33c63d86fda2bd215e7dbe9a3839be71f897be547e533e5657c33e484d673e82845e3db968843d7e544c3ea29e5d3e96aaae3e37cb7d";
        wog <= x"3eea4e933ee031243edd8b003ed5fb953edf815e3ed512873ebf262d3ee581d0";
        bm <= x"3e1237c5be6578a7be2d63bf3cc53419bc95b8653e45d7bb3e500d81be2d9ffa";
        wmh <= x"be0691e7bd2ee8d13df1b52fbd039549be89b8c0be16f153be03c9f23e15556d3e547b98be1719e9bdc2b7113e8603343eccf2293e8309683e9cb6f3bdd826263e676490be0e4192be6016d43e39aa853e99c41d3e5394123e68ff8bbe4cc0debe149807bb0c7ed33dd283e8bcf513fabcc28c3ebd72d157bdd47a7a3d0a87003d7c15e3bda5ac56bd03e3e53e12e9ab3e0e5942bc244980bc814e903b48cc7bbe86b4fcbc9ea4393df0b30fbe0b0195bed11a32be22014cbe2aeb4d3d58ee3bbe47b8efbd8e43493de05089bd2760a6be4d4d13be17429fbe4a71f23da772903e4b84acbdef21d6bddc3da43e7f3b213eae26883e5a62713e4f79a6be1e3aa1";
        wmc <= x"beae2db23ea6c0a43ea6257ebf095447bf16a62dbeb3ffa6bebed8183eaca024";
        bfc <= x"3e09ffb8";
        wfc <= x"bf4bbb833f23e9363f30f835bf2db3e9bf42bc8fbf4cde9dbf302b533f2ec6e9";

    end process;
end stock_weights;
