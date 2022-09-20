library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_bfskmodulator is

end tb_bfskmodulator;

architecture Behavioral of tb_bfskmodulator is

component bfsk_modulator is

port ( 
		clk_i	 :  in std_logic;
		data_i   :  in std_logic_vector(7 downto 0);
		tx_start :  in std_logic;
		bfsk_o	 : out std_logic_vector(7 downto 0);
		tx_done  : out std_logic


);
end component;

signal  clk_i	 : std_logic := '0' ;
signal  data_i   : std_logic_vector(7 downto 0) := (others => '0');
signal  tx_start : std_logic := '0';
signal  bfsk_o	 : std_logic_vector(7 downto 0);
signal  tx_done  : std_logic;
constant c_clkperiod	 : time 		:= 10 ns;
		
begin		
P_CLKGEN : process begin
clk_i 	<= '0';
wait for c_clkperiod/2;
clk_i		<= '1';
wait for c_clkperiod/2;
end process P_CLKGEN;

P_STIMULI : process begin

data_i  <= x"aa"; 
tx_start	<= '1'; wait for c_clkperiod; tx_start	<= '0';
wait until (rising_edge(tx_done));tx_start <= '0';	

wait for 5*c_clkperiod;

data_i  <= x"ba"; 
tx_start	<= '1'; wait for c_clkperiod; tx_start	<= '0';
wait until (rising_edge(tx_done));tx_start <= '0';	

wait for 5*c_clkperiod;

data_i  <= x"bb"; 
tx_start	<= '1'; wait for c_clkperiod; tx_start	<= '0';
wait until (rising_edge(tx_done));tx_start <= '0';	

wait for 5*c_clkperiod;


assert false report "SIM DONE" severity failure;


end process P_STIMULI;

uut : bfsk_modulator 

port map ( 
		clk_i	 => clk_i	,
		data_i   => data_i  ,
		tx_start => tx_start,
		bfsk_o	 => bfsk_o	,
		tx_done  => tx_done 
);




end Behavioral;
