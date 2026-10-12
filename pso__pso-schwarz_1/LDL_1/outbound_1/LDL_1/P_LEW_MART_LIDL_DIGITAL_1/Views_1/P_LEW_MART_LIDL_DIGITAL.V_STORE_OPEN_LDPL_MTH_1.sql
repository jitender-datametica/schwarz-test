/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#-----------------------------------------------------------------------------
# Interface: 20180801_1778_LidlPlus_KPIs
#            1:1 DDL
#----------------------------------------------------------------------------

#----------------------------------------------------------------------------





#----------------------------------------------------------------------------

#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2020-00-10 Marcin Kikola           Initial version
#                                         20201008_2610_OpenStoreViews
#  1.1 2020-11-16 Pawel Wieczorek         Fix PY measures SD-1508
#
#  1.2 2021-02-05 Pawel Wieczorek         SD-1862 20210205_2737_harmo_cal_2
#                                         put calculation into table
#
#----------------------------------------------------------------------------
*/



/* ==============================================================================
   Object DDL
   ============================================================================== */


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital.v_store_open_ldpl_mth_1 (client_id, cy_month, move_to_store_id,
store_id, aspect_id, cm_mth_str_open_fg, pm_mth_str_open_fg, pym_mth_str_open_fg)
OPTIONS(DESCRIPTION = `PRECALCULATED LIDL PLUS KPIS`) AS SELECT client_id,
 cy_month,
 move_to_store_id,
 store_id,
 aspect_id,
 cm_mth_ending_str_open_fg AS cm_mth_str_open_fg,
 pm_mth_ending_str_open_fg AS pm_mth_str_open_fg,
 pym_mth_ending_str_open_fg AS pym_mth_str_open_fg
FROM ldl_p_lew_mart_lidl_digital.t_store_open_month_1;