ibrary IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity bfsk_modulator is

port ( 
		clk_i	 :  in std_logic;
		data_i   :  in std_logic_vector(7 downto 0);
		tx_start :  in std_logic;
		bfsk_o	 : out std_logic_vector(7 downto 0);
		tx_done  : out std_logic


);
end bfsk_modulator;

architecture Behavioral of bfsk_modulator is

type carrier_look_up is array (0 to 255) of std_logic_vector(7 downto 0);

signal carrier : carrier_look_up := ( x"80",x"99",x"B1",x"C7",x"DA",x"EA",x"F5",x"FD",
									  x"FF",x"FD",x"F5",x"EA",x"DA",x"C7",x"B1",x"99",
									  x"80",x"67",x"4F",x"39",x"26",x"16",x"0B",x"03",
									  x"01",x"03",x"0B",x"16",x"26",x"39",x"4F",x"67",
									  x"80",x"99",x"B1",x"C7",x"DA",x"EA",x"F5",x"FD",
									  x"FF",x"FD",x"F5",x"EA",x"DA",x"C7",x"B1",x"99",
									  x"80",x"67",x"4F",x"39",x"26",x"16",x"0B",x"03",
									  x"01",x"03",x"0B",x"16",x"26",x"39",x"4F",x"67",
									  x"80",x"99",x"B1",x"C7",x"DA",x"EA",x"F5",x"FD",
									  x"FF",x"FD",x"F5",x"EA",x"DA",x"C7",x"B1",x"99",
									  x"80",x"67",x"4F",x"39",x"26",x"16",x"0B",x"03",
									  x"01",x"03",x"0B",x"16",x"26",x"39",x"4F",x"67",
									  x"80",x"99",x"B1",x"C7",x"DA",x"EA",x"F5",x"FD",
									  x"FF",x"FD",x"F5",x"EA",x"DA",x"C7",x"B1",x"99",
									  x"80",x"67",x"4F",x"39",x"26",x"16",x"0B",x"03",
									  x"01",x"03",x"0B",x"16",x"26",x"39",x"4F",x"67",
									  
									  x"80",x"B1",x"DA",x"F5",x"FF",x"F5",x"DA",x"B1",
									  x"80",x"4F",x"26",x"0B",x"01",x"0B",x"26",x"4F",
									  x"80",x"B1",x"DA",x"F5",x"FF",x"F5",x"DA",x"B1",
									  x"80",x"4F",x"26",x"0B",x"01",x"0B",x"26",x"4F",
									  x"80",x"B1",x"DA",x"F5",x"FF",x"F5",x"DA",x"B1",
									  x"80",x"4F",x"26",x"0B",x"01",x"0B",x"26",x"4F",
									  x"80",x"B1",x"DA",x"F5",x"FF",x"F5",x"DA",x"B1",
									  x"80",x"4F",x"26",x"0B",x"01",x"0B",x"26",x"4F",
									  x"80",x"B1",x"DA",x"F5",x"FF",x"F5",x"DA",x"B1",
									  x"80",x"4F",x"26",x"0B",x"01",x"0B",x"26",x"4F",
									  x"80",x"B1",x"DA",x"F5",x"FF",x"F5",x"DA",x"B1",
									  x"80",x"4F",x"26",x"0B",x"01",x"0B",x"26",x"4F",
									  x"80",x"B1",x"DA",x"F5",x"FF",x"F5",x"DA",x"B1",
									  x"80",x"4F",x"26",x"0B",x"01",x"0B",x"26",x"4F",
									  x"80",x"B1",x"DA",x"F5",x"FF",x"F5",x"DA",x"B1",
									  x"80",x"4F",x"26",x"0B",x"01",x"0B",x"26",x"4F"  );


signal symbol : std_logic_vector(7 downto 0) := (others => '0');
type states is (S_IDLE,S_START,S_LOGIC0,S_LOGIC1,S_DONE);
signal state : states ;
signal cntr : integer range 0 to 128 := 0 ;
signal cntr2 : integer range 0 to 8;

begin

P_MAIN : process (clk_i) begin 
if(rising_edge(clk_i)) then
		
		
		case state is 
			
			
			when S_IDLE     => 
			
					tx_done <= '0';
					cntr <= 0; cntr2 <= 0;
					if (tx_start = '1') then 
						symbol <= data_i;
						state <= S_START ;
					else 
						state <= S_IDLE;
					end if;
			
			
			when S_START    =>
			
					if (cntr2 = 8) then 
						cntr2 <= 0;
						state <= S_DONE;
					else 
						
						if(symbol(cntr2) = '0') then 
							state <= S_LOGIC0; 
							cntr2 <= cntr2 + 1;
						elsif(symbol(cntr2) = '1')then
							state <= S_LOGIC1;
							cntr2 <= cntr2 + 1;
						end if;
					
					end if;
			
			
			when S_LOGIC0   => 
					if(cntr = 128) then 
						state <= S_START;
						cntr <= 0;
					else 
						bfsk_o <= carrier(cntr);
						cntr <= cntr + 1;
					end if;
			
			when S_LOGIC1  => 
					if(cntr = 128) then 
						state <= S_START;
						cntr <= 0;
					else 
						bfsk_o <= carrier(cntr+128);
						cntr <= cntr + 1;
					end if;
			
			when S_DONE     => 
					tx_done <= '1';
					state <= S_IDLE;
		
		end case ;
		
end if;
end process P_MAIN;

end Behavioral;
