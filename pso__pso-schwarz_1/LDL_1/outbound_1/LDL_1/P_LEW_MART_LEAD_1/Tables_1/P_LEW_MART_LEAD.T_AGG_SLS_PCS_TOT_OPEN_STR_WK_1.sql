/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for table P_LEW_MART_LEAD.t_agg_sls_pcs_tot_open_str_wk_1 
#-------------------------------------------------------------------------------
# History:
#  1.0    2022-11-24         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_agg_sls_pcs_tot_open_str_wk_1 (
client_id BIGNUMERIC NOT NULL,
loc_sid_store_move_to BIGNUMERIC NOT NULL,
currency_iso_cd STRING(3) COLLATE 'und:ci',
busyear BIGNUMERIC NOT NULL,
cy_month BIGNUMERIC NOT NULL,
cy_week_partial_week_id BIGNUMERIC NOT NULL,
sls_pcs_tot_wd1_val BIGNUMERIC(38,8),
sls_pcs_tot_wd2_val BIGNUMERIC(38,8),
sls_pcs_tot_wd3_val BIGNUMERIC(38,8),
sls_pcs_tot_wd4_val BIGNUMERIC(38,8),
sls_pcs_tot_wd5_val BIGNUMERIC(38,8),
sls_pcs_tot_wd6_val BIGNUMERIC(38,8),
sls_pcs_tot_wd7_val BIGNUMERIC(38,8),
sls_pcs_tot_wktd_val BIGNUMERIC(38,8),
sls_pcs_tot_mtd_val BIGNUMERIC(38,8),
sls_pcs_tot_bytd_val BIGNUMERIC(38,8),
plan_sls_pcs_tot_wktd_val BIGNUMERIC(38,8),
plan_sls_pcs_tot_mtd_val BIGNUMERIC(38,8),
plan_sls_pcs_tot_bytd_val BIGNUMERIC(38,8),
pep_sls_pcs_tot_wktd_val BIGNUMERIC(38,8),
pep_sls_pcs_tot_mtd_val BIGNUMERIC(38,8),
pep_sls_pcs_tot_bytd_val BIGNUMERIC(38,8),
prev1y_sls_pcs_tot_wktd_val BIGNUMERIC(38,8),
prev1y_sls_pcs_tot_mtd_val BIGNUMERIC(38,8),
prev1y_sls_pcs_tot_bytd_val BIGNUMERIC(38,8),
adj_inc_rev_wktd_val BIGNUMERIC(38,8)
) CLUSTER BY client_id, cy_month
OPTIONS(description='Durchschnitt Abverkauf Fil./Wo. Gesamt for Filiale Cockpit');