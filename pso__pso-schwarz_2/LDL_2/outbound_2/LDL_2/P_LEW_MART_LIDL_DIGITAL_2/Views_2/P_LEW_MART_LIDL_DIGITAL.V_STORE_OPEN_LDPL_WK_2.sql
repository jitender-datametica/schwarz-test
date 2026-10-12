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


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital.v_store_open_ldpl_wk_2 (client_id, cy_week, move_to_store_id, store_id
, aspect_id, cw_wk_str_open_fg, pw_wk_str_open_fg, pyw_wk_str_open_fg) AS SELECT client_id,
 cy_week,
 move_to_store_id,
 store_id,
 aspect_id,
 cw_wk_ending_str_open_fg AS cw_wk_str_open_fg,
 pw_wk_ending_str_open_fg AS pw_wk_str_open_fg,
 pyw_wk_ending_str_open_fg AS pyw_wk_str_open_fg
FROM ldl_p_lew_mart_lidl_digital.t_store_open_week_2;