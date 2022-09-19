library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tb_bpsk is
end tb_bpsk;

architecture Behavioral of tb_bpsk is

component bpsk_modulator is
port ( 
		clk 	  : in std_logic;
		tx_start  : in std_logic;
		tx_data_i : in std_logic_vector(7 downto 0);
		bpsk_o	  : out std_logic_vector(7 downto 0);
		tx_done   : out std_logic


);
end component;

signal clk 	     : std_logic := '0';
signal tx_start  : std_logic := '0';
signal tx_data_i : std_logic_vector(7 downto 0) := (others => '0');
signal bpsk_o	 :  std_logic_vector(7 downto 0);
signal tx_done   : std_logic;

constant c_clkperiod	 : time 		:= 10 ns;

begin

P_CLKGEN : process begin
clk 	<= '0';
wait for c_clkperiod/2;
clk		<= '1';
wait for c_clkperiod/2;
end process P_CLKGEN;

P_STIMULI : process begin

tx_data_i  <= x"51"; 
tx_start	<= '1'; wait for c_clkperiod; tx_start	<= '0';
wait until (rising_edge(tx_done));tx_start <= '0';	

wait for 5*c_clkperiod;

tx_data_i  <= x"a3"; 
tx_start	<= '1'; wait for c_clkperiod; tx_start	<= '0';
wait until (rising_edge(tx_done));tx_start <= '0';	

wait for 10*c_clkperiod;

assert false report "SIM DONE" severity failure;


end process P_STIMULI;

uut:  bpsk_modulator 
port map ( 
		clk 	  => clk 	   ,
		tx_start  => tx_start  ,
		tx_data_i => tx_data_i ,
		bpsk_o	  => bpsk_o	   ,
		tx_done   => tx_done  


);

end Behavioral;

