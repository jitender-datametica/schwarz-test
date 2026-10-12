/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : DDL for function f_GetAdvWeekId
#-------------------------------------------------------------------------------
# Description: Get the action type from buying list type and international item_1 group code
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-10-27 Mike Davis      	Initial version
#                                  	Now Returns -1 for invalid buying list type
#                                  	or invalid international group code.
#                                  	Converted case statement to nested Iff()set
#                                  	because case caused trouble in DBeaver.
#                                  	Added tests.
# 1.1	2022-03-09 Andreas Kurz		Changes needed for @2nd Increment on PV 
#-------------------------------------------------------------------------------
*/

/*
---------------------------------------------------------------------
Function    :   f_GetAdvWeekId(DATE, INTEGER)
Input       :   pStartDate 			DATE
                pAdvWeekStartDayId 	INTEGER
Return      :   ADV_WEEK_ID INTEGER --> Format YYYYWW Default is 888853 unkonw AdvWeek
Convert     :   None
Description :   For a specific Date based on the AdvWeek Start Day ID (Mon, Thu, Sun, etc.) the coressponding 
				Adv-Week ID will be calcualted. 
				Important to notice that the Date Calculations are based on ISO Calender weeks
Examples    :   SELECT f_GetAdvWeekId(to_date('2021-09-29','YYYY-MM_1-DD'), 1) AS ADV_WEEK_ID
------------------------------------------------------------------------
*/

CREATE OR REPLACE FUNCTION ldl_p_lew_mart_pit.f_getadvweekid(
  pStartDate DATE, 
  pAdvWeekStartDayId INT64
)
RETURNS INT64
AS (
    CASE 
        -- Check Input	
        WHEN pAdvWeekStartDayId < 0 OR pAdvWeekStartDayId > 7 OR pStartDate IS NULL
            THEN 888853
        
        -- Case Adv.Week starts on Sunday --> than the next KalenderWeek (based on ISO)
        WHEN pAdvWeekStartDayId = 7
            THEN EXTRACT(ISOYEAR FROM DATE_ADD(pStartDate, INTERVAL 1 DAY)) * 100
                 + EXTRACT(ISOWEEK FROM DATE_ADD(pStartDate, INTERVAL 1 DAY))
        
        -- Case Adv.Week starts on Monday --> then same as Kalender Week (based on ISO) 
        WHEN pAdvWeekStartDayId = 1
            THEN EXTRACT(ISOYEAR FROM pStartDate) * 100
                 + EXTRACT(ISOWEEK FROM pStartDate)
        
        -- Tue,Wed,Thu,Fri,Sat
        WHEN (MOD(EXTRACT(DAYOFWEEK FROM pStartDate) + 5, 7) + 1) >= pAdvWeekStartDayId AND pAdvWeekStartDayId < 7
            THEN EXTRACT(ISOYEAR FROM pStartDate) * 100
                 + EXTRACT(ISOWEEK FROM pStartDate)
        
        ELSE
            EXTRACT(ISOYEAR FROM DATE_SUB(pStartDate, INTERVAL 7 DAY)) * 100
            + EXTRACT(ISOWEEK FROM DATE_SUB(pStartDate, INTERVAL 7 DAY))
    END
);
-- Usage

/*  
SELECT 
	 dt.DAY_DT
	 ,dt.DAY_OF_WEEK_LDESC
	 -- Case AT
	,f_GetAdvWeekId(dt.DAY_DT, 1) AS ADV_WEEK_1_ID
	,f_GetAdvWeekId(dt.DAY_DT, 3) AS ADV_WEEK_3_ID	
	-- Chase CH
	,f_GetAdvWeekId(dt.DAY_DT, 4) AS ADV_WEEK_4_ID
	-- Chase Denmark 8 ,29 SLOvenien
	,f_GetAdvWeekId(dt.DAY_DT, 7) AS ADV_WEEK_7_ID
FROM

(SELECT * FROM T_DIM_CALENDAR_1 WHERE YEAR_ID IN (2021,2022) ORDER BY DAY_DT --DAY_DT BETWEEN '2022-03-06'::DATE AND '2022-03-20'::DATE
) dt
--(SELECT * FROM T_DIM_CALENDAR_1 WHERE DAY_DT BETWEEN '2021-12-03'::DATE AND '2021-12-11'::DATE) dt
;

SELECT f_GetAdvWeekId(null, 1) AS ADV_WEEK_ID
;

--SELECT * FROM T_DIM_CLIENT_1
*/     