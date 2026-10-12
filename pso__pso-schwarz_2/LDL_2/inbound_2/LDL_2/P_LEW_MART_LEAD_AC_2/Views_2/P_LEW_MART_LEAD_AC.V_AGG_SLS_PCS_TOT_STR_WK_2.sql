/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface : DDL for P_LEW_MART_LEAD_AC.v_agg_sls_pcs_tot_str_wk_2
#-------------------------------------------------------------------------------
# History:
#  1.0    2022-11-24         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.v_agg_sls_pcs_tot_str_wk_2
(
      client_id
    , loc_sid_store_move_to
    , currency_iso_cd
    , busyear
    , cy_month
    , cy_week_partial_week_id
    , sls_pcs_tot_wd1_val
    , sls_pcs_tot_wd2_val
    , sls_pcs_tot_wd3_val
    , sls_pcs_tot_wd4_val
    , sls_pcs_tot_wd5_val
    , sls_pcs_tot_wd6_val
    , sls_pcs_tot_wd7_val
    , sls_pcs_tot_wktd_val 
    , sls_pcs_tot_mtd_val
    , sls_pcs_tot_bytd_val
    , plan_sls_pcs_tot_wktd_val 
    , plan_sls_pcs_tot_mtd_val
    , plan_sls_pcs_tot_bytd_val
    , pep_sls_pcs_tot_wktd_val 
    , pep_sls_pcs_tot_mtd_val
    , pep_sls_pcs_tot_bytd_val
    , prev1y_sls_pcs_tot_wktd_val 
    , prev1y_sls_pcs_tot_mtd_val
    , prev1y_sls_pcs_tot_bytd_val
    , adj_inc_rev_wktd_val
) COMMENT = 'Abverkauf Filiale Gesamt (Sales_2 Pieces total) for Filiale Cockpit'
AS
SELECT
      client_id
    , loc_sid_store_move_to
    , currency_iso_cd
    , busyear
    , cy_month
    , cy_week_partial_week_id
    , sls_pcs_tot_wd1_val
    , sls_pcs_tot_wd2_val
    , sls_pcs_tot_wd3_val
    , sls_pcs_tot_wd4_val
    , sls_pcs_tot_wd5_val
    , sls_pcs_tot_wd6_val
    , sls_pcs_tot_wd7_val
    , sls_pcs_tot_wktd_val 
    , sls_pcs_tot_mtd_val
    , sls_pcs_tot_bytd_val
    , plan_sls_pcs_tot_wktd_val 
    , plan_sls_pcs_tot_mtd_val
    , plan_sls_pcs_tot_bytd_val
    , pep_sls_pcs_tot_wktd_val 
    , pep_sls_pcs_tot_mtd_val
    , pep_sls_pcs_tot_bytd_val
    , prev1y_sls_pcs_tot_wktd_val 
    , prev1y_sls_pcs_tot_mtd_val
    , prev1y_sls_pcs_tot_bytd_val
    , adj_inc_rev_wktd_val
FROM P_LEW_MART_LEAD.t_agg_sls_pcs_tot_str_wk_2
;
