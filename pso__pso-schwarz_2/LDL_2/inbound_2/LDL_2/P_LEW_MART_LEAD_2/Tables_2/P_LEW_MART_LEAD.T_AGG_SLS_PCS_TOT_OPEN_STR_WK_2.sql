/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS LEAD
#----------------------------------------------------------------------------
# Interface : DDL for table P_LEW_MART_LEAD.t_agg_sls_pcs_tot_open_str_wk_2 
#-------------------------------------------------------------------------------
# History:
#  1.0    2022-11-24         Marcin Malec              Initial version.
#----------------------------------------------------------------------------
*/


CREATE TABLE P_LEW_MART_LEAD.t_agg_sls_pcs_tot_open_str_wk_2 CLUSTER BY (client_id, cy_month) 
(
      client_id NUMBER NOT NULL,
      loc_sid_store_move_to NUMBER NOT NULL,
      currency_iso_cd VARCHAR(3) COLLATE 'en-ci',
      busyear NUMBER NOT NULL,
      cy_month NUMBER NOT NULL,
      cy_week_partial_week_id NUMBER NOT NULL,
      sls_pcs_tot_wd1_val NUMBER(38,8),
      sls_pcs_tot_wd2_val NUMBER(38,8),
      sls_pcs_tot_wd3_val NUMBER(38,8),
      sls_pcs_tot_wd4_val NUMBER(38,8),
      sls_pcs_tot_wd5_val NUMBER(38,8),
      sls_pcs_tot_wd6_val NUMBER(38,8),
      sls_pcs_tot_wd7_val NUMBER(38,8),
      sls_pcs_tot_wktd_val NUMBER(38,8),
      sls_pcs_tot_mtd_val NUMBER(38,8),
      sls_pcs_tot_bytd_val NUMBER(38,8),
      plan_sls_pcs_tot_wktd_val NUMBER(38,8),
      plan_sls_pcs_tot_mtd_val NUMBER(38,8),
      plan_sls_pcs_tot_bytd_val NUMBER(38,8),
      pep_sls_pcs_tot_wktd_val NUMBER(38,8),
      pep_sls_pcs_tot_mtd_val NUMBER(38,8),
      pep_sls_pcs_tot_bytd_val NUMBER(38,8),
      prev1y_sls_pcs_tot_wktd_val NUMBER(38,8),
      prev1y_sls_pcs_tot_mtd_val NUMBER(38,8),
      prev1y_sls_pcs_tot_bytd_val NUMBER(38,8),
      adj_inc_rev_wktd_val NUMBER(38,8)
) COMMENT = 'Durchschnitt Abverkauf Fil./Wo. Gesamt for Filiale Cockpit'
;
