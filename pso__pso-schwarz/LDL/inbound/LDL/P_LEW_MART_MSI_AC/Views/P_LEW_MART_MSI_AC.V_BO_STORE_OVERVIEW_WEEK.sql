/*
  Story     : https://jira.schwarz/browse/REP4-10237
  Database  : LDL_PRODUCTION_CLONE_LEAD_LEW_MART
  Target    : P_LEW_MART_MSI_AC.V_BO_STORE_OVERVIEW_WEEK
  Source    : P_LEW_MART_MSI.V_BO_STORE_OVERVIEW_WEEK
  Logic     : Keine. 1:1 Mapping from Source

  History:
    2021-11-05  zied.nanaa_ext@mail.schwarz     Script Teradata Migration from svn://l-as616.asp.lidl.net/ddl/lew/lew_mart_msi_ac/lew_mart_msi_ac_v_bo_store_overview_week.sql
    2022-08-23  Marcin Malec                    Stueckleistung part 2 / SPEC0165308 - Adding columns sales_pieces_ber, sales_pieces_py.

*/

CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_BO_STORE_OVERVIEW_WEEK COMMENT='Stückleistung Overview Week (Filialübersicht)' 
(
    client_id                           COMMENT 'DWH-Client im DWH = LIDL-Land (country)'
  , country_desc                        COMMENT 'AUS MART_MSI.v_ref_country_act_bo (letztlich aus CORE:t_wawi_ref_country_act - für mehrsprachige Ländernamen)'
  , country_id                          COMMENT 'Wie client_id'
  , country_iso_cd                      COMMENT 'AUS MART_MSI.v_ref_country_act_bo (letztlich aus CORE:t_wawi_ref_country_act - für mehrsprachige Ländernamen)'
  , store_id                            COMMENT 'DWHKey des Stores aus Join mit v_lew_bil.v_store über v_lew_bil.v_store_relocation; angezeigt wird der GewinnerStore bei Fusionen - nicht der untergegangene OriginalStore der Fakten'
  , orig_store_nr                       COMMENT 'NaturalKey des Stores aus Join mit v_lew_bil.v_store über v_lew_bil.v_store_relocation; angezeigt wird der GewinnerStore bei Fusionen - nicht der untergegangene OriginalStore der Fakten'
  , store_desc                          COMMENT 'Benutzt wird loc_name2 vor loc_name (used_store_desc) aus v_lew_bil.v_store -> letztlich aus Core:t_location'
  , city                                COMMENT 'AUS CORE.t_address'
  , wh_id                               COMMENT 'NaturalKey (src_wh_id) des dem Store (Gewinnerstore! - siehe loc_sid_store) über die Hauptlieferbeziehung zugeordneten Warehouse (aus BIL:v_store_to_warehouse_lastknown)'
  , wh_desc                             COMMENT 'Benutzt wird loc_name2 vor loc_name (used_wh_desc) aus CORE:t_location über die dem Store (Gewinnerstore! - siehe loc_sid_store) in der Hauptlieferbeziehung zugeordneten Warehouse (aus BIL:v_store_to_warehouse_lastknown)'
  , sales_manager_id                    COMMENT 'AUS BIL:v_location_organization'
  , sales_manager_name                  COMMENT 'AUS BIL:v_location_organization'
  , account_manager_id                  COMMENT 'AUS BIL:v_location_organization'
  , account_manager_name                COMMENT 'AUS BIL:v_location_organization'
  , dat_calendar                        COMMENT 'Datum zum Fakten-Kalendertag'
  , cy_week                             COMMENT 'MART_MSI:v_bo_perf_cal_list_day: Woche zum Fakten-Kalendertag'
  , currency_iso_cd                     COMMENT 'AUS CORE:v_client'
  , plan_val_turnover                   COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover'
  , plan_val_turnover_net               COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover (kein Schreibfehler!)'
  , plan_val_hours                      COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_hours'
  , plan_val_inv_training               COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.(val_inventory + val_training)'
  , plan_sales_pieces                   COMMENT 'Plan durchschnittliche Artikelpreis'
  , plan_avg_sales_price                COMMENT 'Plan durchschnittliche Artikelpreis'
  , plan_piece_performance              COMMENT 'Plan Stückleistung'
  , plan_piece_perf_calc_diff           COMMENT 'MART_MSI:t_bo_base_performance_list.plan_sales_pieces; Wertausweis nur bis zum Maximalen Umsatztag der Tagesauswahl pro Store!'
  , sales_pieces                        COMMENT 'Anzahl der abverkäuften Stk./Kg.'
  , sales_pieces_ber                    COMMENT 'Anzahl der abverkäuften Stk./Kg.'
  , sales_pieces_py                     COMMENT 'Anzahl der abverkäuften Stk./Kg aus dem Vorjahr'
  , avg_sales_price                     COMMENT 'Durchschnittliche Abverkaufspreis'
  , piece_receipt                       COMMENT 'Durchschnittliche Artikelanzahl pro Bon'
  , piece_performance                   COMMENT 'Stückleistung '
  , val_retail_asis                     COMMENT 'CORE:v_agg_sales_store_day.val_retail'
  , val_retail_net_asis                 COMMENT 'CORE:v_agg_sales_store_day.val_retail_net'
  , cnt_customer_asis                   COMMENT 'CORE:v_agg_sales_store_day.cnt_customer'
  , val_retail_asis_ber                 COMMENT 'CORE:v_agg_sales_store_day.val_retail_net'
  , val_retail_net_asis_ber             COMMENT 'CORE:v_agg_sales_store_day.val_retail_net'
  , cnt_customer_asis_ber               COMMENT 'CORE:v_agg_sales_store_day.cnt_customer'
  , val_retail_asis_py                  COMMENT 'CORE:v_agg_sales_store_day.val_retail_net; Vorjahresauswahl über die der ReportWoche (week_page) zugeordneten Intervallgrenzen aus MART_MSI:v_bo_perf_cal_list_week'
  , val_retail_net_asis_py              COMMENT 'CORE:v_agg_sales_store_day.val_retail_net; Vorjahresauswahl über die der ReportWoche (week_page) zugeordneten Intervallgrenzen aus MART_MSI:v_bo_perf_cal_list_week'
  , cnt_customer_asis_py                COMMENT 'CORE:v_agg_sales_store_day.cnt_customer; Vorjahresauswahl über die der ReportWoche (week_page) zugeordneten Intervallgrenzen aus MART_MSI:v_bo_perf_cal_list_week'
  , sales_pieces_asis_py                COMMENT 'Anzahl der abverkäuften Stk./Kg aus dem Vorjahr'
  , piece_performance_py                COMMENT 'Stückleistung aus dem Vorjahr'
  , time_working_netto_std              COMMENT 'CORE:v_wawi_agg_wt_store_day_asis.time_working_netto_hrs'
  , miss_times_perf                     COMMENT 'CORE:v_wawi_agg_wt_store_day_asis.perf_rel_absence_hrs'
  , diff_val_retail_pct                 COMMENT 'MART_MSI:t_bo_base_performance_list: Formel: 100*(val_retail-plan_val_turnover) / plan_val_turnover'
  , diff_val_retail_net_pct             COMMENT 'MART_MSI:t_bo_base_performance_list: Formel: 100*(val_retail_net-plan_val_turnover_net) / plan_val_turnover_net (wobei aktuell plan_val_turnover=plan_val_turnover_net)'
  , diff_hours                          COMMENT 'MART_MSI:t_bo_base_performance_list: Formel: time_working_netto_std + miss_times_perf - plan_val_hours'
  , plan_turnover_calc_ums_diff         COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover; Monatssumme nur bis zum Maximalen Umsatztag der RepWoche!'
  , plan_turnover_calc_ums_dif_net      COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover (kein Schreibfehler!); Monatssumme nur bis zum Maximalen Umsatztag der RepWoche!'
  , plan_sales_qty_calc_abv_diff        COMMENT 'MART_MSI:t_bo_base_performance_list.plan_sales_pieces; Wertausweis nur bis zum Maximalen Umsatztag der Tagesauswahl pro Store!'
  , plan_sales_qty_calc_prod_diff       COMMENT 'MART_MSI:t_bo_base_performance_list.plan_sales_pieces; Wertausweis nur bis zum Maximalen Umsatztag der Tagesauswahl pro Store!'
  , plan_hours_calc_hrs_diff            COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_hours; Monatssumme nur bis zum Maximalen Umsatztag der RepWoche!'
  , plan_productivity                   COMMENT 'Plan_Prk Bez. Einheit productivity'
  , plan_productivity_net               COMMENT 'Plan_Prk Bez. Einheit productivity net'
  , val_retail_calc_prod_diff           COMMENT 'Val_Retk Bez. Einheit diff'
  , val_retail_calc_prod_diff_net       COMMENT 'Val_Retk Bez. Einheit net'
  , hrs_calc_prod_diff                  COMMENT '??? Iststunden Hok Bez. Einheit diff'
  , miss_times_perf_calc_prod_diff      COMMENT 'Miss_Tik Bez. Einheit diff'
  , val_rtl_rl_sfo_store                COMMENT 'Val_Rtlk Bez. Einheit store'
  , val_rtl_rl_net_sfo_store            COMMENT 'Val_Rtlk Bez. Einheit store'
  , sfo_to_val_retail_pct               COMMENT 'Sfo_To_k Bez. Einheit pct'
  , sfo_to_val_retail_net_pct           COMMENT 'Sfo_To_k Bez. Einheit pct'
  , val_rtl_net_sfo_mhd_break           COMMENT 'Abschritften MHD & Bruch'
  , val_rtl_net_sfo_other_stc_loss      COMMENT 'Abschritften Sonstige Warenverluste'
  , val_rtl_net_sfo_str_deliv_qlty      COMMENT 'Abschritften Anlieferung Qualität'
  , plan_turnover_calc_prod_diff        COMMENT 'Plan_Tuk Bez. Einheit diff'
  , plan_turnover_calc_pro_dif_net      COMMENT 'Geplante Umsatz - Verwendet im Berich für Metrik Kalkulation'
  , plan_hours_calc_prod_diff           COMMENT 'Plan_Hok Bez. Einheit diff'
  , act_productivity                    COMMENT 'MART_MSI:t_bo_base_performance_list: Formel: val_retail / (time_working_netto_std + miss_times_perf)'
  , act_productivity_net                COMMENT 'MART_MSI:t_bo_base_performance_list: Formel: val_retail_net / (time_working_netto_std + miss_times_perf)'
  , diff_plan_act_productivity          COMMENT '??? Differenz Planung aktive Produktivität'
  , diff_plan_act_productivity_net      COMMENT '??? Differenz Planung aktive Produktivität net'
) 

AS

SELECT
    client_id
  , country_desc
  , country_id
  , country_iso_cd
  , store_id
  , orig_store_nr
  , store_desc
  , city
  , wh_id
  , wh_desc
  , sales_manager_id
  , sales_manager_name
  , account_manager_id
  , account_manager_name
  , dat_calendar
  , cy_week
  , currency_iso_cd
  , plan_val_turnover
  , plan_val_turnover_net
  , plan_val_hours
  , plan_val_inv_training
  , plan_sales_pieces
  , plan_avg_sales_price
  , plan_piece_performance
  , plan_piece_perf_calc_diff
  , sales_pieces
  , sales_pieces_ber
  , sales_pieces_py
  , avg_sales_price
  , piece_receipt
  , piece_performance
  , val_retail_asis
  , val_retail_net_asis
  , cnt_customer_asis
  , val_retail_asis_ber
  , val_retail_net_asis_ber
  , cnt_customer_asis_ber
  , val_retail_asis_py
  , val_retail_net_asis_py
  , cnt_customer_asis_py
  , sales_pieces_asis_py
  , piece_performance_py
  , time_working_netto_std
  , miss_times_perf
  , diff_val_retail_pct
  , diff_val_retail_net_pct
  , diff_hours
  , plan_turnover_calc_ums_diff
  , plan_turnover_calc_ums_dif_net
  , plan_sales_qty_calc_abv_diff
  , plan_sales_qty_calc_prod_diff
  , plan_hours_calc_hrs_diff
  , plan_productivity
  , plan_productivity_net
  , val_retail_calc_prod_diff
  , val_retail_calc_prod_diff_net
  , hrs_calc_prod_diff
  , miss_times_perf_calc_prod_diff
  , val_rtl_rl_sfo_store
  , val_rtl_rl_net_sfo_store
  , sfo_to_val_retail_pct
  , sfo_to_val_retail_net_pct
  , val_rtl_net_sfo_mhd_break
  , val_rtl_net_sfo_other_stc_loss
  , val_rtl_net_sfo_str_deliv_qlty
  , plan_turnover_calc_prod_diff
  , plan_turnover_calc_pro_dif_net
  , plan_hours_calc_prod_diff
  , act_productivity
  , act_productivity_net
  , diff_plan_act_productivity
  , diff_plan_act_productivity_net
FROM
  P_LEW_MART_MSI.V_BO_STORE_OVERVIEW_WEEK
;