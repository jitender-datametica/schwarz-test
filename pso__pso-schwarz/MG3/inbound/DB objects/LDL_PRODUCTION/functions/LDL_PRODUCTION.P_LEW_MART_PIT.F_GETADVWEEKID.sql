CREATE OR REPLACE FUNCTION LDL_PRODUCTION.P_LEW_MART_PIT.F_GETADVWEEKID(""PSTARTDATE"" DATE, ""PADVWEEKSTARTDAYID"" NUMBER(38,0))
RETURNS NUMBER(38,0)
LANGUAGE SQL
AS '
				CASE 
					-- Check Input	
					WHEN pAdvWeekStartDayId < 0 OR pAdvWeekStartDayId > 7 OR TRY_TO_DATE(pStartDate) IS NULL 
						THEN 888853::INTEGER 
					
					-- Case Adv.Week starts on Sunday --> than the next KalenderWeek (based on ISO)
					WHEN pAdvWeekStartDayId = 7::INTEGER --AND date_part(''dayofweekiso'', pStartDate) = 7 
						THEN 
							YEAROFWEEKISO( dateadd(''day'',+1::INTEGER ,pStartDate )) * 100::INTEGER  + WEEKISO( dateadd(''day'',+1::INTEGER ,pStartDate ))
					-- Case Adv.Week starts on Monday --> then same as Kalender Week (based on ISO) 
					WHEN pAdvWeekStartDayId = 1 
						THEN 
							YEAROFWEEKISO( pStartDate ) * 100::INTEGER  + WEEKISO( pStartDate )
					-- Tue,Wed,Thu,Fri,Sat
					WHEN date_part(''dayofweekiso'', pStartDate) >= pAdvWeekStartDayId AND pAdvWeekStartDayId <7 
						THEN 
							YEAROFWEEKISO( pStartDate ) * 100::INTEGER  + WEEKISO( pStartDate )
					ELSE
						YEAROFWEEKISO( dateadd(''day'',-7::INTEGER ,pStartDate )) * 100::INTEGER  + WEEKISO( dateadd(''day'',-7::INTEGER ,pStartDate ))
				END
    ';