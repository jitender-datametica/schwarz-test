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
#  1.0 2021-05-11 Pawel Wieczork   Initial version SD-2094
#----------------------------------------------------------------------------
*/



/* ==============================================================================
View DDL
============================================================================== */

CREATE OR REPLACE VIEW P_LEW_MART_LIDL_DIGITAL_AC.v_adjust_growth_cal_ldpl_day_1
COMMENT = 'Lidl Plus adjust growth calendar_1'
(
 client_id
,cal_dt
,cy_month
,adjust_growth_mth_fg
,cy_week
,adjust_growth_wk_fg
,day_of_week
,day_of_month
,adjust_growth_pm_fg
,load_id
,dwh_inserted
,dwh_updated
)
AS
SELECT
 client_id
,cal_dt
,cy_month
,adjust_growth_mth_fg
,cy_week
,adjust_growth_wk_fg
,day_of_week
,day_of_month
,adjust_growth_pm_fg
,load_id
,dwh_inserted
,dwh_updated
FROM P_LEW_MART_LIDL_DIGITAL.t_adjust_growth_cal_ldpl_day_1
;
