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


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital.v_harmo_calendar_ldpl_day_2 (client_id, cal_dt, cy_week, cy_month,
last_day_week_fg, last_day_month_fg, harmo_start_dt, harmo_cal_day_no, harmo_cal_week_no, harmo_cal_month_no,
harmo_cal_year_no, load_id, dwh_inserted, dwh_updated) OPTIONS(DESCRIPTION = `LIDL PLUS HARMONIZED CALENDAR_2`) AS SELECT
 client_id,
 cal_dt,
 cy_week,
 cy_month,
 last_day_week_fg,
 last_day_month_fg,
 harmo_start_dt,
 harmo_cal_day_no,
 harmo_cal_week_no,
 harmo_cal_month_no,
 harmo_cal_year_no,
 load_id,
 dwh_inserted,
 dwh_updated
FROM ldl_p_lew_mart_lidl_digital.t_harmo_calendar_ldpl_day_2;