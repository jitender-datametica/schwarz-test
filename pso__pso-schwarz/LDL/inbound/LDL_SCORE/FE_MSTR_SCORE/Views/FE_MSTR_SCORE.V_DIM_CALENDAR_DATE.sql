/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	  |	V_dim_calendar_date
Description		  | Date
Created on        |	29.11.2022
====================================================================================================
*/


CREATE OR REPLACE VIEW FE_MSTR_SCORE.V_DIM_CALENDAR_DATE(
	CAL_DT
	,DAY_OF_WEEK
	,MONTH_OF_YEAR
	,WEEKEND_FG
	,DAY_OF_CY
	,CY_MONTH
	,CY_WEEK
	,CY
	,BUS_YEAR
	,CAL_DT_PREV_7D
	,CAL_DT_SWDAY_PREV_1Y
	,CY_DAY_SEQ
) AS
SELECT
	CAL_DT
	,DAY_OF_WEEK
	,MONTH_OF_YEAR
	,WEEKEND_FG
	,DAY_OF_CY
	,CY_MONTH
	,CY_WEEK
	,CY
	,BUS_YEAR
	,CAL_DT_PREV_7D
	,CAL_DT_SWDAY_PREV_1Y
	,CY_DAY_SEQ
FROM CORE.T_DIM_CALENDAR_DATE;