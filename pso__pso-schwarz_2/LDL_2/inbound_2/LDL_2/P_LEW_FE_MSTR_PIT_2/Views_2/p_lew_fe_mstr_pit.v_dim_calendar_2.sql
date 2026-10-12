/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for DIM_CALENDAR
#-------------------------------------------------------------------------------
# Describtion: Create View for Calendar_2 Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 ANDreas Kurz	   	Initial version
#  2.0	2022-07-16 Nikolai Toknov  	Changing the script for DevOps
#  2.1	2022-07-18 Andreas Kurz		Reworked structure 
#  2.2  2025-01-15 Nikolai Toknov	Drop part of columns
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 


SELECT get_ddl('table','P_LEW_MART_PIT.T_DIM_CALENDAR_2');

DESC TABLE P_LEW_MART_PIT.T_DIM_CALENDAR_2;

DROP VIEW P_LEW_MART_PIT.V_DIM_CALENDAR_2

*/

/* 
---------------------------------------------------------------------
0. Create View Table in V_DIM_CALENDAR_2
------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_FE_MSTR_PIT.V_DIM_CALENDAR_2
COMMENT = 'View table PIT calendar_2'
AS
SELECT
	 dt.DAY_DT
	,dt.DAY_OF_WEEK_ID
	,dt.DAY_OF_WEEK_ISO_ID
	,dt.WEEK_ID
	,dt.WEEK_ISO_ID
	,dt.MONTH_ID
	,dt.MONTH_NBR
	,dt.YEAR_ID
	,dt.YEAR_ISO_ID
	,dt.FISCALYEAR_ID
	--,dt.WORKING_DAY_FG
	--,dt.WEEKEND_FG
	--,dt.SATURDAY_FG
	--,dt.SUNDAY_FG
	--,dt.FRIDAY_FG
	--,dt.THURSDAY_FG
	--,dt.WEDNESDAY_FG
	--,dt.TUESDAY_FG
	--,dt.MONDAY_FG
	,dt.MOVING_DAY_START_NBR
	,dt.MOV_DAY_NBR_PER_YEAR
	,dt.MOV_DAY_NBR_PER_MONTH
	,dt.FISCAL_YEAR_START_FG
	,dt.FISCAL_YEAR_END_FG
	,dt.YEAR_END_FG
	,dt.YEAR_START_FG
	,dt.MONTH_END_FG
	,dt.MONTH_START_FG
	--,dt.WEEK_START_FG
	--,dt.WEEK_END_FG
	--,dt.WEEK_ISO_START_FG
	--,dt.WEEK_ISO_END_FG
	,dt.DAY_CHAR
	,dt.DAY_INT
	,dt.NEXT_DAY_DT
	,dt.PREV_DAY_DT
	,dt.SAMEDAY_PREV_1_YEAR_DAY_DT
	,dt.SAMEDAY_PREV_2_YEAR_DAY_DT
	,dt.SAMEDAY_PREV_3_YEAR_DAY_DT
	,dt.SAMEDAY_PREV_4_YEAR_DAY_DT
	,dt.SAMEDAY_PREV_1_YEAR_WEEK_ID
	,dt.SAMEDAY_PREV_2_YEAR_WEEK_ID
	,dt.SAMEDAY_PREV_3_YEAR_WEEK_ID
	,dt.SAMEDAY_PREV_4_YEAR_WEEK_ID
	,dt.SAMEDAY_PREV_1_YEAR_WEEK_ISO_ID
	,dt.SAMEDAY_PREV_2_YEAR_WEEK_ISO_ID
	,dt.SAMEDAY_PREV_3_YEAR_WEEK_ISO_ID
	,dt.SAMEDAY_PREV_4_YEAR_WEEK_ISO_ID
	,dt.SAMEDAY_PREV_1_YEAR_MONTH_ID
	,dt.SAMEDAY_PREV_2_YEAR_MONTH_ID
	,dt.SAMEDAY_PREV_3_YEAR_MONTH_ID
	,dt.SAMEDAY_PREV_4_YEAR_MONTH_ID
	,dt.SAMEDAY_PREV_1_YEAR_YEAR_ID
	,dt.SAMEDAY_PREV_2_YEAR_YEAR_ID
	,dt.SAMEDAY_PREV_3_YEAR_YEAR_ID
	,dt.SAMEDAY_PREV_4_YEAR_YEAR_ID
	,dt.PREV_1_MONTH_ID
	,dt.PREV_3_MONTH_ID
	,dt.PREV_6_MONTH_ID
	,dt.PREV_9_MONTH_ID
	,dt.PREV_12_MONTH_ID
	,dt.NEXT_1_MONTH_ID
	,dt.PREV_1_YEAR_ID
	,dt.PREV_2_YEAR_ID
	,dt.PREV_3_YEAR_ID
	,dt.PREV_4_YEAR_ID
	,dt.NEXT_1_YEAR_ID
	,dt.PREV_1_WEEK_ISO_ID
	,dt.PREV_2_WEEK_ISO_ID
	,dt.PREV_3_WEEK_ISO_ID
	,dt.PREV_4_WEEK_ISO_ID
	,dt.PREV_5_WEEK_ISO_ID
	,dt.PREV_6_WEEK_ISO_ID
	,dt.PREV_7_WEEK_ISO_ID
	,dt.PREV_8_WEEK_ISO_ID
	,dt.PREV_9_WEEK_ISO_ID
	,dt.PREV_1_YEAR_WEEK_ISO_ID
	,dt.NEXT_1_WEEK_ISO_ID
	,dt.LEAP_YEAR_FG
	,dt.PREV_MONTH_YEAR_ID
	,dt.NEXT_MONTH_YEAR_ID
	,dt.MOVING_DAY_FROM_START
	,dt.MOVING_WEEK_FROM_START
	,dt.MOVING_WEEK_ISO_FROM_START
	,dt.MOVING_MONTH_FROM_START
	,dt.MOVING_YEAR_FROM_START
	,dt.WEEK_START_DAY_DT
	,dt.WEEK_END_DAY_DT
	,dt.WEEK_NBR
	,dt.WEEK_ISO_NBR
	,dt.WEEK_ISO_SDESC
	,dt.WEEK_ISO_LDESC
	,dt.MONTH_SDESC
	,dt.MONTH_DISPLAY_NAME
	,dt.MONTH_DISPLAY_NAME_SDESC	
	,dt.MONTH_LDESC
	,dt.MONTH_START_DAY_DT
	,dt.MONTH_END_DAY_DT
	,dt.YEAR_START_DAY_DT
	,dt.YEAR_END_DAY_DT
	,dt.NBR_OF_DAYS_PER_WEEK
	,dt.NBR_OF_DAYS_PER_MONTH
	,dt.NBR_OF_DAYS_PER_YEAR
	,dt.DAY_OF_WEEK_SDESC
	,dt.DAY_OF_WEEK_LDESC
	,dt.PREV_DAY_OF_WEEK
	,dt.NEXT_DAY_OF_WEEK
	,dt.SPLITTED_WEEK_FG
	,dt.SPLITTED_WEEK_PART1_NBR_OF_DAYS
	,dt.SPLITTED_WEEK_PART2_NBR_OF_DAYS
	,dt.ANNOTATION

	/* Calcualted columns */		    
    , IFF(CURRENT_DATE::DATE = DT.DAY_DT, 1::SMALLINT,0::SMALLINT) 
							AS CURRENT_DAY_FG 								
	, IFF(YEAROFWEEKISO( CURRENT_DATE::DATE ) * 100 + WEEKISO( CURRENT_DATE::DATE ) = DT.WEEK_ISO_ID, 1::SMALLINT,0::SMALLINT) 
							AS CURRENT_WEEK_FG 	
	, IFF(DATE_PART('year', CURRENT_DATE::DATE) * 100 + DATE_PART('month', CURRENT_DATE::DATE) = DT.MONTH_ID, 1::SMALLINT,0::SMALLINT) 
							AS CURRENT_MONTH_FG	
	, IFF(DATE_PART('year', CURRENT_DATE::DATE) = DT.YEAR_ID,1::SMALLINT,0::SMALLINT) 
							AS CURRENT_YEAR_FG	
																						

    , DATEDIFF ('day', DT.DAY_DT, CURRENT_DATE::DATE) * (-1) 
							AS MOV_DAY_START_FROM_CURRENT	
	, DATEDIFF ('week', DT.DAY_DT, CURRENT_DATE::DATE) * (-1)  
							AS MOV_WEEK_START_FROM_CURRENT																																											
	, DATEDIFF ('month', DT.DAY_DT, CURRENT_DATE::DATE) * (-1) 
							AS MOV_MONTH_START_FROM_CURRENT																																			
																					
	--, dt.SPECIAL_DAY_FG
	, dt.DWH_CREATED_TS
FROM
	P_LEW_MART_PIT.T_DIM_CALENDAR_2 dt
WHERE TRUE 	
;

-- SELECT * FROM P_LEW_FE_MSTR_PIT.V_DIM_CALENDAR_2 LIMIT 10;