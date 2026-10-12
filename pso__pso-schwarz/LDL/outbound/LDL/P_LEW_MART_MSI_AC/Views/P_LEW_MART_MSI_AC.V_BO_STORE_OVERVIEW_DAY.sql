/*
  Story     : https://jira.schwarz/browse/REP4-10237
  Database  : LDL_PRODUCTION_CLONE_LEAD_LEW_MART
  Target    : P_LEW_MART_MSI_AC.V_BO_STORE_OVERVIEW_DAY
  Source    : P_LEW_MART_MSI.V_BO_STORE_OVERVIEW_DAY
  Logic     : Keine. 1:1 Mapping from Source

  History:
    2021-11-04  zied.nanaa_ext@mail.schwarz     Script Teradata Migration from svn://l-as616.asp.lidl.net/ddl/lew/lew_mart_msi_ac/lew_mart_msi_ac_v_bo_store_overview_day.sql
    2022-08-23  Marcin Malec                    Stueckleistung part 2 / SPEC0165308 - Adding column sales_pieces_py.
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_bo_store_overview_day (account_manager_id
OPTIONS(description='AUS BIL:v_location_organization'), account_manager_name
OPTIONS(description='AUS BIL:v_location_organization'), act_productivity
OPTIONS(description='MART_MSI:t_bo_base_performance_list: Formel: val_retail / (time_working_netto_std + miss_times_perf)'),
act_productivity_net
OPTIONS(description='MART_MSI:t_bo_base_performance_list: Formel: val_retail_net / (time_working_netto_std + miss_times_perf)'),
city OPTIONS(description='AUS CORE.t_address'), client_id OPTIONS(description='DWH-Client im DWH = LIDL-Land (country)'),
cnt_customer_asis OPTIONS(description='CORE:v_agg_sales_store_day.cnt_customer'), country_desc
OPTIONS(description='AUS MART_MSI.v_ref_country_act_bo (letztlich aus CORE:t_wawi_ref_country_act - für mehrsprachige Ländernamen)'),
country_id OPTIONS(description='Wie client_id'), country_iso_cd
OPTIONS(description='AUS MART_MSI.v_ref_country_act_bo (letztlich aus CORE:t_wawi_ref_country_act - für mehrsprachige Ländernamen)'),
currency_iso_cd OPTIONS(description='AUS CORE:v_client'), dat_calendar
OPTIONS(description='MART_MSI:v_bo_perf_cal_list_day: Fakten-Kalendertag'), diff_hours
OPTIONS(description='MART_MSI:t_bo_base_performance_list: Formel: time_working_netto_std + miss_times_perf - plan_val_hours'),
diff_val_retail_pct
OPTIONS(description='MART_MSI:t_bo_base_performance_list: Formel: 100*(val_retail-plan_val_turnover) / plan_val_turnover'),
diff_val_retail_net_pct
OPTIONS(description='MART_MSI:t_bo_base_performance_list: Formel: 100*(val_retail_net-plan_val_turnover_net) / plan_val_turnover_net (wobei aktuell plan_val_turnover=plan_val_turnover_net)'),
hrs_calc_prod_diff
OPTIONS(description='CORE:v_wawi_agg_wt_store_day_asis.time_working_netto_hrs; Wertausweis nur bis zum früheren Tag aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der Tagesauswahl pro Store!'),
miss_times_perf OPTIONS(description='CORE:v_wawi_agg_wt_store_day_asis.perf_rel_absence_hrs'),
miss_times_perf_calc_prod_diff
OPTIONS(description='CORE:v_wawi_agg_wt_store_day_asis.perf_rel_absence_hrs; Wertausweis nur bis zum früheren Tag aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der Tagesauswahl pro Store!'),
orig_store_nr
OPTIONS(description='NaturalKey des Stores aus CROSS JOIN mit v_lew_bil.v_store über v_lew_bil.v_store_relocation; angezeigt wird der GewinnerStore bei Fusionen - nicht der untergegangene OriginalStore der Fakten'),
plan_hours_calc_hrs_diff
OPTIONS(description='CORE:v_wawi_ptm_plantimeday_wh.val_hours; Wertausweis nur bis zum Maximalen Umsatztag der Tagesauswahl pro Store!'),
plan_hours_calc_prod_diff
OPTIONS(description='CORE:v_wawi_ptm_plantimeday_wh.val_hours; Wertausweis nur bis zum früheren Tag aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der Tagesauswahl pro Store!'),
plan_productivity OPTIONS(description='MART_MSI:t_bo_base_performance_list: Formel: plan_val_turnover / plan_val_hours'),
plan_productivity_net
OPTIONS(description='MART_MSI:t_bo_base_performance_list: Formel: plan_val_turnover_net / plan_val_hours (wobei aktuell plan_val_turnover=plan_val_turnover_net)'),
plan_turnover_calc_prod_diff
OPTIONS(description='CORE:v_wawi_ptm_plantimeday_wh.val_turnover; Wertausweis nur bis zum früheren Tag aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der Tagesauswahl pro Store!'),
plan_turnover_calc_pro_dif_net
OPTIONS(description='CORE:v_wawi_ptm_plantimeday_wh.val_turnover (kein Schreibfehler!); Wertausweis nur bis zum früheren Tag aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der Tagesauswahl pro Store!'),
plan_turnover_calc_ums_diff
OPTIONS(description='CORE:v_wawi_ptm_plantimeday_wh.val_turnover; Wertausweis nur bis zum Maximalen Umsatztag der Tagesauswahl pro Store!'),
plan_turnover_calc_ums_dif_net
OPTIONS(description='CORE:v_wawi_ptm_plantimeday_wh.val_turnover (kein Schreibfehler!); Wertausweis nur bis zum Maximalen Umsatztag der Tagesauswahl pro Store!'),
plan_val_hours OPTIONS(description='CORE:v_wawi_ptm_plantimeday_wh.val_hours'), plan_val_inv_training
OPTIONS(description='CORE:v_wawi_ptm_plantimeday_wh.(val_inventory + val_training)'), plan_val_turnover
OPTIONS(description='CORE:v_wawi_ptm_plantimeday_wh.val_turnover'), plan_val_turnover_net
OPTIONS(description='CORE:v_wawi_ptm_plantimeday_wh.val_turnover (kein Schreibfehler!)'), plan_sales_pieces
OPTIONS(description='Plan durchschnittliche Artikelpreis'), plan_avg_sales_price
OPTIONS(description='Plan durchschnittliche Artikelpreis'), plan_piece_performance
OPTIONS(description='Plan Stückleistung'), sales_pieces OPTIONS(description='Anzahl der abverkäuften Stk./Kg.'),
sales_pieces_py OPTIONS(description='Anzahl der abverkäuften Stk./Kg aus dem Vorjahr'), avg_sales_price
OPTIONS(description='Durchschnittliche Abverkaufspreis'), piece_receipt
OPTIONS(description='Durchschnittliche Artikelanzahl pro Bon'), piece_performance OPTIONS(description='Stückleistung '),
sales_manager_id OPTIONS(description='AUS BIL:v_location_organization'), sales_manager_name
OPTIONS(description='AUS BIL:v_location_organization'), sfo_to_val_retail_pct
OPTIONS(description='Sfo_To_k Bez. Einheit pct'), sfo_to_val_retail_net_pct
OPTIONS(description='Sfo_To_k Bez. Einheit pct'), store_desc
OPTIONS(description='Benutzt wird loc_name2 vor loc_name (used_store_desc) aus v_lew_bil.v_store -> letztlich aus Core:t_location'),
store_id
OPTIONS(description='DWHKey des Stores aus CROSS JOIN mit v_lew_bil.v_store über v_lew_bil.v_store_relocation; angezeigt wird der GewinnerStore bei Fusionen - nicht der untergegangene OriginalStore der Fakten'),
time_working_netto_std OPTIONS(description='CORE:v_wawi_agg_wt_store_day_asis.time_working_netto_hrs'), val_retail_asis
OPTIONS(description='CORE:v_agg_sales_store_day.val_retail'), val_retail_net_asis
OPTIONS(description='CORE:v_agg_sales_store_day.val_retail_net'), val_retail_calc_prod_diff
OPTIONS(description='CORE:v_agg_sales_store_day.val_retail; Wertausweis nur bis zum früheren Tag aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der Tagesauswahl pro Store!'),
val_retail_calc_prod_diff_net
OPTIONS(description='CORE:v_agg_sales_store_day.val_retail_net; Wertausweis nur bis zum früheren Tag aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der Tagesauswahl pro Store!'),
val_rtl_rl_sfo_store OPTIONS(description='Val_Rtlk Bez. Einheit store'), val_rtl_rl_net_sfo_store
OPTIONS(description='Val_Rtlk Bez. Einheit store'), val_rtl_net_sfo_mhd_break
OPTIONS(description='Abschritften MHD & Bruch'), val_rtl_net_sfo_other_stc_loss
OPTIONS(description='Abschritften Sonstige Warenverluste'), val_rtl_net_sfo_str_deliv_qlty
OPTIONS(description='Abschritften Anlieferung Qualität'), wh_desc
OPTIONS(description='Benutzt wird loc_name2 vor loc_name (used_wh_desc) aus CORE:t_location über die dem Store (Gewinnerstore! - siehe loc_sid_store) in der Hauptlieferbeziehung zugeordneten Warehouse (aus BIL:v_store_to_warehouse_lastknown)'),
wh_id
OPTIONS(description='NaturalKey (src_wh_id) des dem Store (Gewinnerstore! - siehe loc_sid_store) über die Hauptlieferbeziehung zugeordneten Warehouse (aus BIL:v_store_to_warehouse_lastknown)'))
OPTIONS(DESCRIPTION = `STÜCKLEISTUNG OVERVIEW DAY (FILIALÜBERSICHT)`) AS SELECT *
FROM ldl_p_lew_mart_msi.v_bo_store_overview_day;