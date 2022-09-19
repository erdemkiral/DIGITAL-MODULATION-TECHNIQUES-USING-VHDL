library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bpsk_modulator is
port ( 
		clk 	  : in std_logic;
		tx_start  : in std_logic;
		tx_data_i : in std_logic_vector(7 downto 0);
		bpsk_o	  : out std_logic_vector(7 downto 0);
		tx_done   : out std_logic


);
end bpsk_modulator;

architecture Behavioral of bpsk_modulator is

type sinelut is array (0 to 127) of std_logic_vector(7 downto 0);

constant sine_normal : sinelut := (x"86",x"8C",x"93",x"99",x"9F",x"A5",x"AB",x"B1",
								   x"B6",x"BC",x"C1",x"C7",x"CC",x"D1",x"D5",x"DA",
								   x"DE",x"E2",x"E6",x"EA",x"ED",x"F0",x"F3",x"F5",
								   x"F8",x"FA",x"FB",x"FD",x"FE",x"FE",x"FF",x"FF",
								   x"FF",x"FE",x"FE",x"FD",x"FB",x"FA",x"F8",x"F5",
								   x"F3",x"F0",x"ED",x"EA",x"E6",x"E2",x"DE",x"DA",
								   x"D5",x"D1",x"CC",x"C7",x"C1",x"BC",x"B6",x"B1",
								   x"AB",x"A5",x"9F",x"99",x"93",x"8C",x"86",x"80",
								   x"7A",x"74",x"6D",x"67",x"61",x"5B",x"55",x"4F",
								   x"4A",x"44",x"3F",x"39",x"34",x"2F",x"2B",x"26",
								   x"22",x"1E",x"1A",x"16",x"13",x"10",x"0D",x"0B",
								   x"08",x"06",x"05",x"03",x"02",x"02",x"01",x"01",
								   x"01",x"02",x"02",x"03",x"05",x"06",x"08",x"0B",
								   x"0D",x"10",x"13",x"16",x"1A",x"1E",x"22",x"26",
								   x"2B",x"2F",x"34",x"39",x"3F",x"44",x"4A",x"4F",
								   x"55",x"5B",x"61",x"67",x"6D",x"74",x"7A",x"80");
							
constant sine_inverted : sinelut := (x"7A",x"74",x"6D",x"67",x"61",x"5B",x"55",x"4F",
									 x"4A",x"44",x"3F",x"39",x"34",x"2F",x"2B",x"26",
									 x"22",x"1E",x"1A",x"16",x"13",x"10",x"0D",x"0B",
									 x"08",x"06",x"05",x"03",x"02",x"02",x"01",x"01",
									 x"01",x"02",x"02",x"03",x"05",x"06",x"08",x"0B",
									 x"0D",x"10",x"13",x"16",x"1A",x"1E",x"22",x"26",
									 x"2B",x"2F",x"34",x"39",x"3F",x"44",x"4A",x"4F",
									 x"55",x"5B",x"61",x"67",x"6D",x"74",x"7A",x"80",
									 x"86",x"8C",x"93",x"99",x"9F",x"A5",x"AB",x"B1",
									 x"B6",x"BC",x"C1",x"C7",x"CC",x"D1",x"D5",x"DA",
									 x"DE",x"E2",x"E6",x"EA",x"ED",x"F0",x"F3",x"F5",
									 x"F8",x"FA",x"FB",x"FD",x"FE",x"FE",x"FF",x"FF",
									 x"FF",x"FE",x"FE",x"FD",x"FB",x"FA",x"F8",x"F5",
									 x"F3",x"F0",x"ED",x"EA",x"E6",x"E2",x"DE",x"DA",
									 x"D5",x"D1",x"CC",x"C7",x"C1",x"BC",x"B6",x"B1",
									 x"AB",x"A5",x"9F",x"99",x"93",x"8C",x"86",x"80");
									 					 
						
type states is (S_IDLE,S_DATA,S_LOGIC1,S_LOGIC0,S_DONE);
signal state : states := S_IDLE;

signal bitcntr : integer range 0 to 8 := 0;
signal cntr    : integer range 0 to 127 := 0;


begin

P_MAIN : process(clk) begin 
if(rising_edge(clk)) then
	
	case state is 
		
		
		when S_IDLE => 
			
			tx_done <= '0';
			cntr <= 0;
			bitcntr <= 0;
			if(tx_start = '1') then
				state <= S_DATA;
			else 
				state <= S_IDLE;
			end if;
			
		when S_DATA    =>
			
			
			if(bitcntr = 8) then 
				state <= S_DONE;
				bitcntr <= 0;
			else 
				if(tx_data_i(bitcntr) = '0') then 
					state <= S_LOGIC0;
				else 
					state <= S_LOGIC1;
				end if;
			
			end if;
		
		when S_LOGIC1  =>
		
				if(cntr = 127) then 
					state <= S_DATA;
					bitcntr <= bitcntr + 1;
					cntr <= 0;
				else 
					bpsk_o <= sine_normal(cntr);
					cntr <= cntr + 1;
				end if;
				
		when S_LOGIC0  =>
				
				if(cntr = 127) then 
					state <= S_DATA;
					bitcntr <= bitcntr + 1;
					cntr <= 0;
				else 
					bpsk_o <= sine_inverted(cntr);
					cntr <= cntr + 1;
				end if;
		
		when S_DONE    =>
				tx_done <= '1';
				cntr <= 0;
				bitcntr <= 0;
				state <= S_IDLE;
	
	end case;

end if;
end process P_MAIN;

end Behavioral;

