/*
  Story     : https://jira.schwarz/browse/REP4-9791
  Target    : P_LEW_MART_MSI_AC.V_BO_PERFORMANCE_LIST_DAY
  Source    : P_LEW_MART_MSI.V_BO_PERFORMANCE_LIST_DAY
  Logic     : Keine. 1:1 Mapping from Source

  History:
    2021-11-11  zied.nanaa_ext@mail.schwarz
    Script Teradata Migration from svn://l-as616.asp.lidl.net/ddl/lew/lew_mart_msi_ac/lew_mart_msi_ac_v_bo_performance_list_day.sql 
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_bo_performance_list_day (client_id
OPTIONS(description='DWH-Client im DWH = LIDL-Land (country)'), country_id OPTIONS(description='= client_id'),
country_desc
OPTIONS(description='AUS MART_MSI.v_ref_country_act_bo (letztlich aus CORE:t_wawi_ref_country_act - für mehrsprachige Ländernamen)'),
country_iso_cd
OPTIONS(description='AUS MART_MSI.v_ref_country_act_bo (letztlich aus CORE:t_wawi_ref_country_act - für mehrsprachige Ländernamen)'),
store_id
OPTIONS(description='DWHKey des Stores aus Join mit #X_LEW_BIL#.v_store über #X_LEW_BIL#.v_store_relocation. Angezeigt wird der GewinnerStore bei Fusionen - nicht der untergegangene OriginalStore der Fakten'),
orig_store_nr
OPTIONS(description='NaturalKey des Stores aus Join mit #X_LEW_BIL#.v_store über #X_LEW_BIL#.v_store_relocation. Angezeigt wird der GewinnerStore bei Fusionen - nicht der untergegangene OriginalStore der Fakten'),
store_desc
OPTIONS(description='Benutzt wird loc_name2 vor loc_name (used_store_desc) aus #X_LEW_BIL#.v_store -> letztlich aus Core:t_location'),
city OPTIONS(description='AUS CORE.t_address'), wh_id
OPTIONS(description='NaturalKey (src_wh_id) des dem Store (Gewinnerstore! - siehe loc_sid_store) über die Hauptlieferbeziehung zugeordneten Warehouse (aus BIL:v_store_to_warehouse_lastknown)'),
wh_desc
OPTIONS(description='Benutzt wird loc_name2 vor loc_name (used_wh_desc) aus CORE:t_location über die dem Store (Gewinnerstore! - siehe loc_sid_store) in der Hauptlieferbeziehung zugeordneten Warehouse (aus BIL:v_store_to_warehouse_lastknown)'),
sales_manager_id OPTIONS(description='AUS BIL:v_location_organization'), sales_manager_name
OPTIONS(description='AUS BIL:v_location_organization'), account_manager_id
OPTIONS(description='AUS BIL:v_location_organization'), account_manager_name
OPTIONS(description='AUS BIL:v_location_organization'), dat_calendar
OPTIONS(description='MART_MSI:v_bo_perf_cal_list_day: Fakten-Kalendertag'), cy_week
OPTIONS(description='MART_MSI:v_bo_perf_cal_list_day: Woche zum Fakten-Kalendertag'), currency_iso_cd
OPTIONS(description='AUS CORE:v_client'), plan_val_turnover
OPTIONS(description='CORE:v_wawi_ptm_plantimeday_wh.val_turnover'), plan_val_turnover_net
OPTIONS(description='CORE:v_wawi_ptm_plantimeday_wh.val_turnover (kein Schreibfehler!)'), plan_val_hours
OPTIONS(description='CORE:v_wawi_ptm_plantimeday_wh.val_hours'), plan_val_inv_training
OPTIONS(description='CORE:v_wawi_ptm_plantimeday_wh.(val_inventory + val_training)'), val_retail_asis
OPTIONS(description='CORE:v_agg_sales_store_day.val_retail'), val_retail_net_asis
OPTIONS(description='CORE:v_agg_sales_store_day.val_retail_net'), cnt_customer_asis
OPTIONS(description='CORE:v_agg_sales_store_day.cnt_customer'), time_working_netto_std
OPTIONS(description='CORE:v_wawi_agg_wt_store_day_asis.time_working_netto_hrs'), miss_times_perf
OPTIONS(description='CORE:v_wawi_agg_wt_store_day_asis.perf_rel_absence_hrs'), diff_val_retail_pct
OPTIONS(description='MART_MSI:t_bo_base_performance_list: Formel: 100*(val_retail-plan_val_turnover) / plan_val_turnover'),
diff_val_retail_net_pct
OPTIONS(description='MART_MSI:t_bo_base_performance_list: Formel: 100*(val_retail_net-plan_val_turnover_net) / plan_val_turnover_net (wobei aktuell plan_val_turnover=plan_val_turnover_net)'),
diff_sales_qty_asis_pct OPTIONS(description='Unterschied zwischen Plan-Abverkaufe und IST-Abverkaufe in %'),
diff_piece_perf_asis_pct OPTIONS(description='Unterschied zwischen Stückleistung (Plan) und Stückleistung (IST) in %'),
diff_hours
OPTIONS(description='MART_MSI:t_bo_base_performance_list: Formel: time_working_netto_std + miss_times_perf - plan_val_hours. Realstunden(Arbeit+Schulung)-Planstunden'),
plan_productivity OPTIONS(description='MART_MSI:t_bo_base_performance_list: Formel: plan_val_turnover / plan_val_hours'),
plan_productivity_net
OPTIONS(description='MART_MSI:t_bo_base_performance_list: Formel: plan_val_turnover_net / plan_val_hours (wobei aktuell plan_val_turnover=plan_val_turnover_net)'),
act_productivity
OPTIONS(description='MART_MSI:t_bo_base_performance_list: Formel: val_retail / (time_working_netto_std + miss_times_perf)'),
act_productivity_net
OPTIONS(description='MART_MSI:t_bo_base_performance_list: Formel: val_retail_net / (time_working_netto_std + miss_times_perf)'),
max_umsdate OPTIONS(description=''), max_hrsdate OPTIONS(description=''), plan_turnover_calc_ums_diff
OPTIONS(description='CORE:v_wawi_ptm_plantimeday_wh.val_turnover; Wertausweis nur bis zum Maximalen Umsatztag der Tagesauswahl pro Store!'),
plan_turnover_calc_ums_dif_net
OPTIONS(description='CORE:v_wawi_ptm_plantimeday_wh.val_turnover (kein Schreibfehler!); Wertausweis nur bis zum Maximalen Umsatztag der Tagesauswahl pro Store!'),
plan_turnover_calc_prod_diff
OPTIONS(description='CORE:v_wawi_ptm_plantimeday_wh.val_turnover; Wertausweis nur bis zum früheren Tag aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der Tagesauswahl pro Store!'),
plan_turnover_calc_pro_dif_net
OPTIONS(description='CORE:v_wawi_ptm_plantimeday_wh.val_turnover (kein Schreibfehler!); Wertausweis nur bis zum früheren Tag aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der Tagesauswahl pro Store!'),
plan_sales_qty_calc_abv_diff
OPTIONS(description='MART_MSI:t_bo_base_performance_list.plan_sales_pieces; Wertausweis nur bis zum Maximalen Umsatztag der Tagesauswahl pro Store!'),
plan_sales_qty_calc_prod_diff
OPTIONS(description='MART_MSI:t_bo_base_performance_list.plan_sales_pieces; Wertausweis nur bis zum Maximalen Umsatztag der Tagesauswahl pro Store!'),
plan_hours_calc_hrs_diff
OPTIONS(description='CORE:v_wawi_ptm_plantimeday_wh.val_hours; Wertausweis nur bis zum Maximalen Umsatztag der Tagesauswahl pro Store!'),
plan_hours_calc_prod_diff
OPTIONS(description='CORE:v_wawi_ptm_plantimeday_wh.val_hours; Wertausweis nur bis zum früheren Tag aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der Tagesauswahl pro Store!'),
val_retail_calc_prod_diff
OPTIONS(description='CORE:v_agg_sales_store_day.val_retail; Wertausweis nur bis zum früheren Tag aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der Tagesauswahl pro Store!'),
val_retail_calc_prod_diff_net
OPTIONS(description='CORE:v_agg_sales_store_day.val_retail_net; Wertausweis nur bis zum früheren Tag aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der Tagesauswahl pro Store!'),
hrs_calc_prod_diff
OPTIONS(description='CORE:v_wawi_agg_wt_store_day_asis.time_working_netto_hrs; Wertausweis nur bis zum früheren Tag aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der Tagesauswahl pro Store!'),
miss_times_perf_calc_prod_diff
OPTIONS(description='CORE:v_wawi_agg_wt_store_day_asis.perf_rel_absence_hrs; Wertausweis nur bis zum früheren Tag aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der Tagesauswahl pro Store!'),
sales_qty_asis OPTIONS(description='Abverkaufte Stück/Kg IST'), plan_sales_qty
OPTIONS(description='Plan Abverkaufte Stück/Kg'), piece_perf_asis OPTIONS(description='Stückleistung IST'),
plan_perf_piece OPTIONS(description='Plan Stückleistung'), item_price_asis
OPTIONS(description='Durchschnittliche Artikelpreis IST'))
OPTIONS(DESCRIPTION = `Schnittstellenview Cube-Beladung BO; Performancelist DAY`) AS SELECT client_id,
 country_id,
 country_desc,
 country_iso_cd,
 store_id,
 orig_store_nr,
 store_desc,
 city,
 wh_id,
 wh_desc,
 sales_manager_id,
 sales_manager_name,
 account_manager_id,
 account_manager_name,
 dat_calendar,
 cy_week,
 currency_iso_cd,
 plan_val_turnover,
 plan_val_turnover_net,
 plan_val_hours,
 plan_val_inv_training,
 val_retail_asis,
 val_retail_net_asis,
 cnt_customer_asis,
 time_working_netto_std,
 miss_times_perf,
 diff_val_retail_pct,
 diff_val_retail_net_pct,
 diff_sales_qty_asis_pct,
 diff_piece_perf_asis_pct,
 diff_hours,
 plan_productivity,
 plan_productivity_net,
 act_productivity,
 act_productivity_net,
 max_umsdate,
 max_hrsdate,
 plan_turnover_calc_ums_diff,
 plan_turnover_calc_ums_dif_net,
 plan_turnover_calc_prod_diff,
 plan_turnover_calc_pro_dif_net,
 plan_sales_qty_calc_abv_diff,
 plan_sales_qty_calc_prod_diff,
 plan_hours_calc_hrs_diff,
 plan_hours_calc_prod_diff,
 val_retail_calc_prod_diff,
 val_retail_calc_prod_diff_net,
 hrs_calc_prod_diff,
 miss_times_perf_calc_prod_diff,
 sales_qty_asis,
 plan_sales_qty,
 piece_perf_asis,
 plan_perf_piece,
 item_price_asis
FROM ldl_p_lew_mart_msi.v_bo_performance_list_day;