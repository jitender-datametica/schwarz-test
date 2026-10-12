/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface:
#            DDL for v_cal_harmo_ldpl_day
#----------------------------------------------------------------------------

#----------------------------------------------------------------------------





#----------------------------------------------------------------------------

#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2020-11-25 Pawel Wieczork          Initial version 20201117_2664_harmo_cal SD-1544
#----------------------------------------------------------------------------
*/



/* ==============================================================================
View DDL
============================================================================== */

CREATE OR REPLACE VIEW P_LEW_MART_LIDL_DIGITAL_AC.v_harmo_calendar_ldpl_day_2
(
 client_id
,cal_dt
,cy_week
,cy_month
,last_day_week_fg
,last_day_month_fg
,harmo_start_dt
,harmo_cal_day_no
,harmo_cal_week_no
,harmo_cal_month_no
,harmo_cal_year_no
,load_id
,dwh_inserted
,dwh_updated
)
COMMENT = 'Lidl Plus Harmonized calendar_2' 
AS 
SELECT
 client_id
,cal_dt
,cy_week
,cy_month
,last_day_week_fg
,last_day_month_fg
,harmo_start_dt
,harmo_cal_day_no
,harmo_cal_week_no
,harmo_cal_month_no
,harmo_cal_year_no
,load_id
,dwh_inserted
,dwh_updated
FROM P_LEW_MART_LIDL_DIGITAL.T_HARMO_CALENDAR_LDPL_DAY_2
;


