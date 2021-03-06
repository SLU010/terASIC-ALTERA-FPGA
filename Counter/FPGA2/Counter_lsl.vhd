LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY Counter_lsl IS
	PORT(CLK,EN:IN STD_LOGIC;
		COUT:OUT STD_LOGIC;
		Q:BUFFER INTEGER RANGE 0 TO 15);
END Counter_lsl;
ARCHITECTURE ONE OF Counter_lsl IS
BEGIN
PROCESS(CLK,EN)
	BEGIN
	IF CLK'EVENT AND CLK = '1' THEN
		IF EN = '1' THEN
			IF Q = 15 THEN Q<=0;
				COUT<='0';
			ELSIF Q = 14 THEN Q<=Q+1;
				COUT<='1';
			ELSE Q<=Q+1;
			END IF;
		END IF;
	END IF;
END PROCESS;
END ONE;