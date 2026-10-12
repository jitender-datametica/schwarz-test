/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_QV_AGG_WH_DAY_DISPO_QTY_PRCLC_1
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2020-08-19 Tris Bayliff            20200309_2424_QuickView_remove_dum
#  2.0 2021-04-09 Tris Bayliff            Transfer to Snowflake
#                                         https://jira.schwarz/browse/REP2-9207
#
#----------------------------------------------------------------------------
*/ 

CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_QV_AGG_WH_DAY_DISPO_QTY_PRCLC_1 COMMENT = 'QuickView view : Data is provided by wh and day.'
(
  client_id
, client_desc
, country_group_id
, country_group_desc
, gl_region_id
, gl_region_desc
, wh_id
, wh_desc
, aspect_id
, aspect_desc
, currency_iso_cd
, curr_tot_id
, dat_formdate
, cnt_miss_item
, cnt_miss_item_py
, cnt_dat_miss_item
, cnt_dat_miss_item_py
, val_roc_prclc_wh
, val_roc_prclc_wh_py
, avg_stc_wh
, avg_stc_wh_py
, dwh_load_id
, dwh_created
, dwh_updated
)
AS
SELECT
  client_id
, client_desc
, country_group_id
, country_group_desc
, gl_region_id
, gl_region_desc
, wh_id
, wh_desc
, aspect_id
, aspect_desc
, currency_iso_cd
, curr_tot_id
, dat_formdate
, cnt_miss_item
, cnt_miss_item_py
, cnt_dat_miss_item
, cnt_dat_miss_item_py
, val_roc_prclc_wh
, val_roc_prclc_wh_py
, avg_stc_wh
, avg_stc_wh_py
, dwh_load_id
, dwh_created
, dwh_updated
FROM P_LEW_MART_LEAD.V_QV_AGG_WH_DAY_DISPO_QTY_PRCLC_1
;
