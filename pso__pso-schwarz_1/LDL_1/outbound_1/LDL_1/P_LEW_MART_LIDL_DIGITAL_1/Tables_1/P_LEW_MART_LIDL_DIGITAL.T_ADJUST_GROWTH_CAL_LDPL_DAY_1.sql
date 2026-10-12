/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: t_harmo_calendar_ldpl_day_1
#----------------------------------------------------------------------------

#----------------------------------------------------------------------------





#----------------------------------------------------------------------------

#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2021-05-11 Pawel Wieczork   Initial version SD-2094
#
#----------------------------------------------------------------------------
*/




/* ==============================================================================
   Table DDL
   ============================================================================== */


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lidl_digital.t_adjust_growth_cal_ldpl_day_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
cal_dt DATE,
cy_month BIGNUMERIC(38,0) NOT NULL,
adjust_growth_mth_fg BIGNUMERIC(38,0) NOT NULL,
cy_week BIGNUMERIC(38,0) NOT NULL,
adjust_growth_wk_fg BIGNUMERIC(38,0) NOT NULL,
day_of_week BIGNUMERIC(38,0) NOT NULL,
day_of_month BIGNUMERIC(38,0) NOT NULL,
adjust_growth_pm_fg BIGNUMERIC(38,0) NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL,
dwh_inserted DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);