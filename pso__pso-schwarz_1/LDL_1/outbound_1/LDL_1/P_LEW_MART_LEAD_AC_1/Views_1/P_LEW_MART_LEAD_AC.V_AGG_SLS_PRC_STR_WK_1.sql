/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface : DDL for P_LEW_MART_LEAD_AC.V_AGG_SLS_PRC_STR_WK_1
#-------------------------------------------------------------------------------
# History:
#  1.0    2021-07-21         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_sls_prc_str_wk_1 (client_id, loc_sid_store_move_to, currency_iso_cd,
busyear, cy_month, cy_week_partial_week_id, sls_prc_wd1_val, sls_prc_wd2_val, sls_prc_wd3_val, sls_prc_wd4_val,
sls_prc_wd5_val, sls_prc_wd6_val, sls_prc_wd7_val, sls_prc_wktd_val, sls_prc_mtd_val, sls_prc_bytd_val,
plan_sls_prc_wktd_val, plan_sls_prc_mtd_val, plan_sls_prc_bytd_val, pep_sls_prc_wktd_val, pep_sls_prc_mtd_val,
pep_sls_prc_bytd_val, prev1y_sls_prc_wktd_val, prev1y_sls_prc_mtd_val, prev1y_sls_prc_bytd_val)
OPTIONS(DESCRIPTION = `DURCHSCHNITT ARTIKELPREIS (AVG SALES_1 PRICE) FOR FILIALE COCKPIT`) AS SELECT client_id,
 loc_sid_store_move_to,
 currency_iso_cd,
 busyear,
 cy_month,
 cy_week_partial_week_id,
 sls_prc_wd1_val,
 sls_prc_wd2_val,
 sls_prc_wd3_val,
 sls_prc_wd4_val,
 sls_prc_wd5_val,
 sls_prc_wd6_val,
 sls_prc_wd7_val,
 sls_prc_wktd_val,
 sls_prc_mtd_val,
 sls_prc_bytd_val,
 plan_sls_prc_wktd_val,
 plan_sls_prc_mtd_val,
 plan_sls_prc_bytd_val,
 pep_sls_prc_wktd_val,
 pep_sls_prc_mtd_val,
 pep_sls_prc_bytd_val,
 prev1y_sls_prc_wktd_val,
 prev1y_sls_prc_mtd_val,
 prev1y_sls_prc_bytd_val
FROM ldl_p_lew_mart_lead.t_agg_sls_prc_str_wk_1;