library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity qpsk_modulation is
generic(
		  c_inputdatalength : integer   := 16

);
port ( 
		
		clk_i	 :  in std_logic;
		data_i   :  in std_logic_vector(c_inputdatalength -1  downto 0);
		tx_start :  in std_logic;
		qpsk_o	 : out std_logic_vector(7 downto 0);
		tx_done  : out std_logic

);
end qpsk_modulation;

architecture Behavioral of qpsk_modulation is

type carrier_look_up is array (0 to 511) of std_logic_vector(7 downto 0);

signal carrier : carrier_look_up := ( x"DA",x"B1",x"80",x"4F",x"26",x"0B",x"01",x"0B",
x"26",x"4F",x"80",x"B1",x"DA",x"F5",x"FF",x"F5",
x"DA",x"B1",x"80",x"4F",x"26",x"0B",x"01",x"0B",
x"26",x"4F",x"80",x"B1",x"DA",x"F5",x"FF",x"F5",
x"DA",x"B1",x"80",x"4F",x"26",x"0B",x"01",x"0B",
x"26",x"4F",x"80",x"B1",x"DA",x"F5",x"FF",x"F5",
x"DA",x"B1",x"80",x"4F",x"26",x"0B",x"01",x"0B",
x"26",x"4F",x"80",x"B1",x"DA",x"F5",x"FF",x"F5",
x"DA",x"B1",x"80",x"4F",x"26",x"0B",x"01",x"0B",
x"26",x"4F",x"80",x"B1",x"DA",x"F5",x"FF",x"F5",
x"DA",x"B1",x"80",x"4F",x"26",x"0B",x"01",x"0B",
x"26",x"4F",x"80",x"B1",x"DA",x"F5",x"FF",x"F5",
x"DA",x"B1",x"80",x"4F",x"26",x"0B",x"01",x"0B",
x"26",x"4F",x"80",x"B1",x"DA",x"F5",x"FF",x"F5",
x"DA",x"B1",x"80",x"4F",x"26",x"0B",x"01",x"0B",
x"26",x"4F",x"80",x"B1",x"DA",x"F5",x"FF",x"F5",

x"26",x"0B",x"01",x"0B",x"26",x"4F",x"80",x"B1",
x"DA",x"F5",x"FF",x"F5",x"DA",x"B1",x"80",x"4F",
x"26",x"0B",x"01",x"0B",x"26",x"4F",x"80",x"B1",
x"DA",x"F5",x"FF",x"F5",x"DA",x"B1",x"80",x"4F",
x"26",x"0B",x"01",x"0B",x"26",x"4F",x"80",x"B1",
x"DA",x"F5",x"FF",x"F5",x"DA",x"B1",x"80",x"4F",
x"26",x"0B",x"01",x"0B",x"26",x"4F",x"80",x"B1",
x"DA",x"F5",x"FF",x"F5",x"DA",x"B1",x"80",x"4F",
x"26",x"0B",x"01",x"0B",x"26",x"4F",x"80",x"B1",
x"DA",x"F5",x"FF",x"F5",x"DA",x"B1",x"80",x"4F",
x"26",x"0B",x"01",x"0B",x"26",x"4F",x"80",x"B1",
x"DA",x"F5",x"FF",x"F5",x"DA",x"B1",x"80",x"4F",
x"26",x"0B",x"01",x"0B",x"26",x"4F",x"80",x"B1",
x"DA",x"F5",x"FF",x"F5",x"DA",x"B1",x"80",x"4F",
x"26",x"0B",x"01",x"0B",x"26",x"4F",x"80",x"B1",
x"DA",x"F5",x"FF",x"F5",x"DA",x"B1",x"80",x"4F",


x"DA",x"F5",x"FF",x"F5",x"DA",x"B1",x"80",x"4F",
x"26",x"0B",x"01",x"0B",x"26",x"4F",x"80",x"B1",
x"DA",x"F5",x"FF",x"F5",x"DA",x"B1",x"80",x"4F",
x"26",x"0B",x"01",x"0B",x"26",x"4F",x"80",x"B1",
x"DA",x"F5",x"FF",x"F5",x"DA",x"B1",x"80",x"4F",
x"26",x"0B",x"01",x"0B",x"26",x"4F",x"80",x"B1",
x"DA",x"F5",x"FF",x"F5",x"DA",x"B1",x"80",x"4F",
x"26",x"0B",x"01",x"0B",x"26",x"4F",x"80",x"B1",
x"DA",x"F5",x"FF",x"F5",x"DA",x"B1",x"80",x"4F",
x"26",x"0B",x"01",x"0B",x"26",x"4F",x"80",x"B1",
x"DA",x"F5",x"FF",x"F5",x"DA",x"B1",x"80",x"4F",
x"26",x"0B",x"01",x"0B",x"26",x"4F",x"80",x"B1",
x"DA",x"F5",x"FF",x"F5",x"DA",x"B1",x"80",x"4F",
x"26",x"0B",x"01",x"0B",x"26",x"4F",x"80",x"B1",
x"DA",x"F5",x"FF",x"F5",x"DA",x"B1",x"80",x"4F",
x"26",x"0B",x"01",x"0B",x"26",x"4F",x"80",x"B1",



x"26",x"4F",x"80",x"B1",x"DA",x"F5",x"FF",x"F5",
x"DA",x"B1",x"80",x"4F",x"26",x"0B",x"01",x"0B",
x"26",x"4F",x"80",x"B1",x"DA",x"F5",x"FF",x"F5",
x"DA",x"B1",x"80",x"4F",x"26",x"0B",x"01",x"0B",
x"26",x"4F",x"80",x"B1",x"DA",x"F5",x"FF",x"F5",
x"DA",x"B1",x"80",x"4F",x"26",x"0B",x"01",x"0B",
x"26",x"4F",x"80",x"B1",x"DA",x"F5",x"FF",x"F5",
x"DA",x"B1",x"80",x"4F",x"26",x"0B",x"01",x"0B",
x"26",x"4F",x"80",x"B1",x"DA",x"F5",x"FF",x"F5",
x"DA",x"B1",x"80",x"4F",x"26",x"0B",x"01",x"0B",
x"26",x"4F",x"80",x"B1",x"DA",x"F5",x"FF",x"F5",
x"DA",x"B1",x"80",x"4F",x"26",x"0B",x"01",x"0B",
x"26",x"4F",x"80",x"B1",x"DA",x"F5",x"FF",x"F5",
x"DA",x"B1",x"80",x"4F",x"26",x"0B",x"01",x"0B",
x"26",x"4F",x"80",x"B1",x"DA",x"F5",x"FF",x"F5",
x"DA",x"B1",x"80",x"4F",x"26",x"0B",x"01",x"0B" );
																																	
signal i_channel     : std_logic_vector(7 downto 0) := (others => '0');
signal q_channel     : std_logic_vector(7 downto 0) := (others => '0');
signal reg_iqchannel : std_logic_vector(c_inputdatalength -1 downto 0) := (others => '0');

signal i_channelcarrier :std_logic_vector (7 downto 0) := (others => '0');
signal q_channelcarrier :std_logic_vector (7 downto 0) := (others => '0');

signal cntr_1 : integer range 0 to 15 := 0;
signal cntr_2 : integer range 0 to 31 := 0;

signal cntr : integer range 0 to 128 := 0;
signal qpsk_00_tick : std_logic := '0';
signal qpsk_01_tick : std_logic := '0';
signal qpsk_10_tick : std_logic := '0';
signal qpsk_11_tick : std_logic := '0';

type states is (S_IDLE,S_START,S_DATA,S_QPSK00,S_QPSK01,S_QPSK10,S_QPSK11,S_DONE);
signal state : states ;



begin


P_MAIN : process (clk_i) begin 
if(rising_edge(clk_i)) then


		case state is 
		
			when S_IDLE  => 
					
					tx_done <= '0';
					q_channel <= (others => '0');
					i_channel <= (others => '0');
					
					if (tx_start = '1') then 
						reg_iqchannel <= data_i;
						state <= S_START ;
					else 
						state <= S_IDLE;
					end if;
			
			when S_START => 
			
					if (cntr_2 = 16) then 
						cntr_1 <= 0;
						cntr_2 <= 0;
						state <= S_DATA;
					else 
						q_channel(cntr_1) <= reg_iqchannel(cntr_2) ;
						i_channel(cntr_1) <= reg_iqchannel(cntr_2+1) ;
						cntr_1 <= cntr_1 + 1 ;
						cntr_2 <= cntr_2 + 2 ;
					
					end if;
			
			
			when S_DATA  => 
					
					qpsk_00_tick <= '0'; qpsk_01_tick <= '0'; qpsk_10_tick <= '0'; qpsk_11_tick <= '0';
					
					if(cntr_1 = 8) then 
						state <= S_DONE;
						cntr_1 <= 0;
					else 
						if(i_channel(cntr_1) = '0' and q_channel(cntr_1) = '0') then 
								state <= S_QPSK00; cntr_1 <= cntr_1 + 1; 
						elsif(i_channel(cntr_1) = '0' and q_channel(cntr_1) = '1') then 
								state <= S_QPSK01; cntr_1 <= cntr_1 + 1; 
						elsif (i_channel(cntr_1) = '1' and q_channel(cntr_1) = '0') then 
								state <= S_QPSK10; cntr_1 <= cntr_1 + 1; 
						elsif (i_channel(cntr_1) = '1' and q_channel(cntr_1) = '1') then 
								state <= S_QPSK11; cntr_1 <= cntr_1 + 1; 
						end if;
					
					end if ;
					 	
			when S_QPSK00  => 
						if(cntr = 128) then 
							state <= S_DATA; cntr <= 0; qpsk_00_tick <= '1';
						else 
							qpsk_o <= carrier(cntr);
							cntr   <= cntr + 1 ;
						end if;

			when S_QPSK01  => 
						if(cntr = 128) then 
							state <= S_DATA; cntr <= 0; qpsk_01_tick <= '1';
						else 
							qpsk_o <= carrier(cntr+128);
							cntr   <= cntr + 1 ;
						end if;
			when S_QPSK10  => 
						if(cntr = 128) then 
							state <= S_DATA; cntr <= 0; qpsk_10_tick <= '1';
						else 
							qpsk_o <= carrier(cntr+256);
							cntr   <= cntr + 1 ;
						end if;
			when S_QPSK11  => 
						if(cntr = 128) then 
							state <= S_DATA; cntr <= 0; qpsk_11_tick <= '1';
						else 
							qpsk_o <= carrier(cntr+384);
							cntr   <= cntr + 1 ;
						end if;
					
			when S_DONE  => 
			state <= S_IDLE;
			tx_done <= '1';
		
		
		end case ;
		
end if;
end process P_MAIN;

end Behavioral;

