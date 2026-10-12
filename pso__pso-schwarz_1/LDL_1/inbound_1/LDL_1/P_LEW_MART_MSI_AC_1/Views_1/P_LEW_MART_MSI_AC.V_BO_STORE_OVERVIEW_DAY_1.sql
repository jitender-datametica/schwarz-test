/*
  Story     : https://jira.schwarz/browse/REP4-10237
  Database  : LDL_PRODUCTION_CLONE_LEAD_LEW_MART
  Target    : P_LEW_MART_MSI_AC.V_BO_STORE_OVERVIEW_DAY_1
  Source    : P_LEW_MART_MSI.V_BO_STORE_OVERVIEW_DAY_1
  Logic     : Keine. 1:1 Mapping from Source

  History:
    2021-11-04  zied.nanaa_ext@mail.schwarz     Script Teradata Migration from svn://l-as616.asp.lidl.net/ddl/lew/lew_mart_msi_ac/lew_mart_msi_ac_v_bo_store_overview_day.sql
    2022-08-23  Marcin Malec                    Stueckleistung part 2 / SPEC0165308 - Adding column sales_pieces_py.
*/

CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_BO_STORE_OVERVIEW_DAY_1 COMMENT='Stückleistung Overview Day (Filialübersicht)'
(  
    account_manager_id                COMMENT 'AUS BIL:v_location_organization_1'
  , account_manager_name              COMMENT 'AUS BIL:v_location_organization_1'
  , act_productivity                  COMMENT 'MART_MSI:t_bo_base_performance_list_1: Formel: val_retail / (time_working_netto_std + miss_times_perf)'
  , act_productivity_net              COMMENT 'MART_MSI:t_bo_base_performance_list_1: Formel: val_retail_net / (time_working_netto_std + miss_times_perf)'
  , city                              COMMENT 'AUS CORE.t_address_1'
  , client_id                         COMMENT 'DWH-Client im DWH = LIDL-Land_1 (country_1)'
  , cnt_customer_asis                 COMMENT 'CORE:v_agg_sales_store_day.cnt_customer'
  , country_desc                      COMMENT 'AUS MART_MSI.v_ref_country_act_bo_1 (letztlich aus CORE:t_wawi_ref_country_act_1 - für mehrsprachige Ländernamen)'
  , country_id                        COMMENT 'Wie client_id'
  , country_iso_cd                    COMMENT 'AUS MART_MSI.v_ref_country_act_bo_1 (letztlich aus CORE:t_wawi_ref_country_act_1 - für mehrsprachige Ländernamen)'
  , currency_iso_cd                   COMMENT 'AUS CORE:v_client_1'
  , dat_calendar                      COMMENT 'MART_MSI:v_bo_perf_cal_list_day_1: Fakten-Kalendertag'
  , diff_hours                        COMMENT 'MART_MSI:t_bo_base_performance_list_1: Formel: time_working_netto_std + miss_times_perf - plan_val_hours'
  , diff_val_retail_pct               COMMENT 'MART_MSI:t_bo_base_performance_list_1: Formel: 100*(val_retail-plan_val_turnover) / plan_val_turnover'
  , diff_val_retail_net_pct           COMMENT 'MART_MSI:t_bo_base_performance_list_1: Formel: 100*(val_retail_net-plan_val_turnover_net) / plan_val_turnover_net (wobei aktuell plan_val_turnover=plan_val_turnover_net)'
  , hrs_calc_prod_diff                COMMENT 'CORE:v_wawi_agg_wt_store_day_asis.time_working_netto_hrs; Wertausweis nur bis zum früheren Tag_1 aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der Tagesauswahl pro Store!'
  , miss_times_perf                   COMMENT 'CORE:v_wawi_agg_wt_store_day_asis.perf_rel_absence_hrs'
  , miss_times_perf_calc_prod_diff    COMMENT 'CORE:v_wawi_agg_wt_store_day_asis.perf_rel_absence_hrs; Wertausweis nur bis zum früheren Tag_1 aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der Tagesauswahl pro Store!'
  , orig_store_nr                     COMMENT 'NaturalKey des Stores aus Join mit v_lew_bil.v_store_1 über v_lew_bil.v_store_relocation_1; angezeigt wird der GewinnerStore bei Fusionen - nicht der untergegangene OriginalStore der Fakten'
  , plan_hours_calc_hrs_diff          COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_hours; Wertausweis nur bis zum Maximalen Umsatztag der Tagesauswahl pro Store!'
  , plan_hours_calc_prod_diff         COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_hours; Wertausweis nur bis zum früheren Tag_1 aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der Tagesauswahl pro Store!'
  , plan_productivity                 COMMENT 'MART_MSI:t_bo_base_performance_list_1: Formel: plan_val_turnover / plan_val_hours'
  , plan_productivity_net             COMMENT 'MART_MSI:t_bo_base_performance_list_1: Formel: plan_val_turnover_net / plan_val_hours (wobei aktuell plan_val_turnover=plan_val_turnover_net)'
  , plan_turnover_calc_prod_diff      COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover; Wertausweis nur bis zum früheren Tag_1 aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der Tagesauswahl pro Store!'
  , plan_turnover_calc_pro_dif_net    COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover (kein Schreibfehler!); Wertausweis nur bis zum früheren Tag_1 aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der Tagesauswahl pro Store!'
  , plan_turnover_calc_ums_diff       COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover; Wertausweis nur bis zum Maximalen Umsatztag der Tagesauswahl pro Store!'
  , plan_turnover_calc_ums_dif_net    COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover (kein Schreibfehler!); Wertausweis nur bis zum Maximalen Umsatztag der Tagesauswahl pro Store!'
  , plan_val_hours                    COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_hours'
  , plan_val_inv_training             COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.(val_inventory + val_training)'
  , plan_val_turnover                 COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover'
  , plan_val_turnover_net             COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover (kein Schreibfehler!)'
  , plan_sales_pieces                 COMMENT 'Plan durchschnittliche Artikelpreis'
  , plan_avg_sales_price              COMMENT 'Plan durchschnittliche Artikelpreis'
  , plan_piece_performance            COMMENT 'Plan Stückleistung'
  , sales_pieces                      COMMENT 'Anzahl der abverkäuften Stk./Kg.'
  , sales_pieces_py                   COMMENT 'Anzahl der abverkäuften Stk./Kg aus dem Vorjahr'
  , avg_sales_price                   COMMENT 'Durchschnittliche Abverkaufspreis'
  , piece_receipt                     COMMENT 'Durchschnittliche Artikelanzahl pro Bon'
  , piece_performance                 COMMENT 'Stückleistung '
  , sales_manager_id                  COMMENT 'AUS BIL:v_location_organization_1'
  , sales_manager_name                COMMENT 'AUS BIL:v_location_organization_1'
  , sfo_to_val_retail_pct             COMMENT 'Sfo_To_k Bez. Einheit pct'
  , sfo_to_val_retail_net_pct         COMMENT 'Sfo_To_k Bez. Einheit pct'
  , store_desc                        COMMENT 'Benutzt wird loc_name2 vor loc_name (used_store_desc) aus v_lew_bil.v_store_1 -> letztlich aus Core:t_location_1'
  , store_id                          COMMENT 'DWHKey des Stores aus Join mit v_lew_bil.v_store_1 über v_lew_bil.v_store_relocation_1; angezeigt wird der GewinnerStore bei Fusionen - nicht der untergegangene OriginalStore der Fakten'
  , time_working_netto_std            COMMENT 'CORE:v_wawi_agg_wt_store_day_asis.time_working_netto_hrs'
  , val_retail_asis                   COMMENT 'CORE:v_agg_sales_store_day.val_retail'
  , val_retail_net_asis               COMMENT 'CORE:v_agg_sales_store_day.val_retail_net'
  , val_retail_calc_prod_diff         COMMENT 'CORE:v_agg_sales_store_day.val_retail; Wertausweis nur bis zum früheren Tag_1 aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der Tagesauswahl pro Store!'
  , val_retail_calc_prod_diff_net     COMMENT 'CORE:v_agg_sales_store_day.val_retail_net; Wertausweis nur bis zum früheren Tag_1 aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der Tagesauswahl pro Store!'
  , val_rtl_rl_sfo_store              COMMENT 'Val_Rtlk Bez. Einheit store'
  , val_rtl_rl_net_sfo_store          COMMENT 'Val_Rtlk Bez. Einheit store'
  , val_rtl_net_sfo_mhd_break         COMMENT 'Abschritften MHD & Bruch'
  , val_rtl_net_sfo_other_stc_loss    COMMENT 'Abschritften Sonstige Warenverluste'
  , val_rtl_net_sfo_str_deliv_qlty    COMMENT 'Abschritften Anlieferung Qualität'
  , wh_desc                           COMMENT 'Benutzt wird loc_name2 vor loc_name (used_wh_desc) aus CORE:t_location_1 über die dem Store (Gewinnerstore! - siehe loc_sid_store) in der Hauptlieferbeziehung zugeordneten Warehouse (aus BIL:v_store_to_warehouse_lastknown_1)'
  , wh_id                             COMMENT 'NaturalKey (src_wh_id) des dem Store (Gewinnerstore! - siehe loc_sid_store) über die Hauptlieferbeziehung zugeordneten Warehouse (aus BIL:v_store_to_warehouse_lastknown_1)'
)

AS

SELECT
    account_manager_id
  , account_manager_name
  , act_productivity
  , act_productivity_net
  , city
  , client_id
  , cnt_customer_asis
  , country_desc
  , country_id
  , country_iso_cd
  , currency_iso_cd
  , dat_calendar
  , diff_hours
  , diff_val_retail_pct
  , diff_val_retail_net_pct
  , hrs_calc_prod_diff
  , miss_times_perf
  , miss_times_perf_calc_prod_diff
  , orig_store_nr
  , plan_hours_calc_hrs_diff
  , plan_hours_calc_prod_diff
  , plan_productivity
  , plan_productivity_net
  , plan_turnover_calc_prod_diff
  , plan_turnover_calc_pro_dif_net
  , plan_turnover_calc_ums_diff
  , plan_turnover_calc_ums_dif_net
  , plan_val_hours
  , plan_val_inv_training
  , plan_val_turnover
  , plan_val_turnover_net
  , plan_sales_pieces
  , plan_avg_sales_price
  , plan_piece_performance
  , sales_pieces
  , sales_pieces_py
  , avg_sales_price
  , piece_receipt
  , piece_performance
  , sales_manager_id
  , sales_manager_name
  , sfo_to_val_retail_pct
  , sfo_to_val_retail_net_pct
  , store_desc
  , store_id
  , time_working_netto_std
  , val_retail_asis
  , val_retail_net_asis
  , val_retail_calc_prod_diff
  , val_retail_calc_prod_diff_net
  , val_rtl_rl_sfo_store
  , val_rtl_rl_net_sfo_store
  , val_rtl_net_sfo_mhd_break
  , val_rtl_net_sfo_other_stc_loss
  , val_rtl_net_sfo_str_deliv_qlty
  , wh_desc
  , wh_id
FROM
  P_LEW_MART_MSI.V_BO_STORE_OVERVIEW_DAY_1
;