/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface : DDL for P_LEW_MART_LEAD_AC.V_AGG_SLS_PCS_STR_WK_1
#-------------------------------------------------------------------------------
# History:
#  1.0    2021-07-21         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.v_agg_sls_pcs_str_wk_1
(
      client_id
    , loc_sid_store_move_to
    , currency_iso_cd
    , busyear
    , cy_month
    , cy_week_partial_week_id
    , sls_pcs_wd1_val
    , sls_pcs_wd2_val
    , sls_pcs_wd3_val
    , sls_pcs_wd4_val
    , sls_pcs_wd5_val
    , sls_pcs_wd6_val
    , sls_pcs_wd7_val
    , sls_pcs_wktd_val 
    , sls_pcs_mtd_val
    , sls_pcs_bytd_val
    , plan_sls_pcs_wktd_val 
    , plan_sls_pcs_mtd_val
    , plan_sls_pcs_bytd_val
    , pep_sls_pcs_wktd_val 
    , pep_sls_pcs_mtd_val
    , pep_sls_pcs_bytd_val
    , prev1y_sls_pcs_wktd_val 
    , prev1y_sls_pcs_mtd_val
    , prev1y_sls_pcs_bytd_val
) COMMENT = 'Abverkauf Filiale (Sales_1 Pieces) for Filiale Cockpit'
AS
SELECT
      client_id
    , loc_sid_store_move_to
    , currency_iso_cd
    , busyear
    , cy_month
    , cy_week_partial_week_id
    , sls_pcs_wd1_val
    , sls_pcs_wd2_val
    , sls_pcs_wd3_val
    , sls_pcs_wd4_val
    , sls_pcs_wd5_val
    , sls_pcs_wd6_val
    , sls_pcs_wd7_val
    , sls_pcs_wktd_val 
    , sls_pcs_mtd_val
    , sls_pcs_bytd_val
    , plan_sls_pcs_wktd_val 
    , plan_sls_pcs_mtd_val
    , plan_sls_pcs_bytd_val
    , pep_sls_pcs_wktd_val 
    , pep_sls_pcs_mtd_val
    , pep_sls_pcs_bytd_val
    , prev1y_sls_pcs_wktd_val 
    , prev1y_sls_pcs_mtd_val
    , prev1y_sls_pcs_bytd_val
FROM P_LEW_MART_LEAD.t_agg_sls_pcs_str_wk_1
;
