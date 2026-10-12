/*
  Story       : https://jira.schwarz/browse/REP4-9791
  
  Description: Materialisierung P_LEW_MART_MSI.V_MAT_BO_BASE_PERFORMANCE_LIST_2
               Basistab für alle BO_PERFORMANCELIST-Views

  Sources
    CORE:
               t_wawi_agg_wt_store_day_asis
               t_wawi_ptm_plantimeday_wh
    BIL:
               v_agg_sales_store_day_2

  History:
    2021-11-09  zied.nanaa_ext@mail.schwarz
    Script Teradata Migration from svn://l-as616.asp.lidl.net/ddl/lew/lew_mart_msi/lew_mart_msi_t_bo_base_performance_list.sql
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.t_bo_base_performance_list_2 (
client_id INTEGER OPTIONS(description='DWH-Client im DWH = LIDL-Land_2 (country_2)'),
loc_sid_store INTEGER
OPTIONS(description='DWHKey des Stores aus Join mit #X_LEW_BIL#.v_store_2 über #X_LEW_BIL#.v_store_relocation. Angezeigt wird der GewinnerStore bei Fusionen - nicht der untergegangene OriginalStore der Fakten'),
cal_dt DATE OPTIONS(description='MART_MSI:v_bo_perf_cal_list_day_2: Fakten-Kalendertag'),
py_caldt_shifted DATE
OPTIONS(description='MART_MSI:v_bo_perf_cal_list_day_2: Nur für Wochenauswahl: der über die Kalenderfunktion cal_dt_swday_prev_1y ins Currentyear verschobene Tag_2 der PrevYear-Woche_2'),
cy_week INTEGER OPTIONS(description='MART_MSI:v_bo_perf_cal_list_day_2: Woche_2 zum Fakten-Kalendertag'),
py_week_shifted INTEGER
OPTIONS(description='MART_MSI:v_bo_perf_cal_list_day_2: Nur für Wochenauswahl: über Kalenderfunktion cal_dt_swday_prev_1y ins Currentyear verschobene PrevYear-Woche_2'),
cy_week_seq INTEGER
OPTIONS(description='MART_MSI:v_bo_perf_cal_list_day_2: Relativ-Sequenz der Woche_2 zum Fakten-Kalendertag'),
py_week_seq_shifted INTEGER
OPTIONS(description='MART_MSI:v_bo_perf_cal_list_day_2: Nur für Wochenauswahl: Relativ-Sequenz der über die Kalenderfunktion cal_dt_swday_prev_1y ins Currentyear verschobenen PrevYear-Woche_2'),
cy_month INTEGER OPTIONS(description='MART_MSI:v_bo_perf_cal_list_day_2: Monat_2 zum Fakten-Kalendertag'),
orig_store_nr INTEGER
OPTIONS(description='NaturalKey des Stores aus Join mit #X_LEW_BIL#.v_store_2 über #X_LEW_BIL#.v_store_relocation. Angezeigt wird der GewinnerStore bei Fusionen - nicht der untergegangene OriginalStore der Fakten'),
used_store_desc STRING(100) COLLATE 'und:ci'
OPTIONS(description='Benutzt wird loc_name2 vor loc_name aus #X_LEW_BIL#.v_store_2 -> letztlich aus Core:t_location_2'),
used_closing_dt DATE
OPTIONS(description='Ist Opening_DT (#X_LEW_BIL#.v_store.opening_dt vor 30.12.9999) real, dann BIL:v_store.dat_closing_ovis vor BIL:v_store.closing_dt vor 30.12.9999'),
city STRING(100) COLLATE 'und:ci' OPTIONS(description='AUS CORE.n_address'),
country_id INTEGER OPTIONS(description='= client_id'),
country_desc STRING(35) COLLATE 'und:ci'
OPTIONS(description='AUS MART_MSI.v_ref_country_act_bo_2 (letztlich aus CORE:t_wawi_ref_country_act_2 - für mehrsprachige Ländernamen)'),
country_iso_cd STRING COLLATE 'und:ci'
OPTIONS(description='AUS MART_MSI.v_ref_country_act_bo_2 (letztlich aus CORE:t_wawi_ref_country_act_2 - für mehrsprachige Ländernamen)'),
curr_cd STRING(20) COLLATE 'und:ci' OPTIONS(description='AUS CORE:v_client_2'),
plan_val_turnover NUMERIC(18,4) OPTIONS(description='CORE:v_wawi_ptm_plantimeday_wh.val_turnover'),
plan_val_turnover_net NUMERIC(18,4)
OPTIONS(description='CORE:v_wawi_ptm_plantimeday_wh.val_turnover (kein Schreibfehler!)'),
plan_val_hours NUMERIC(18,4) OPTIONS(description='CORE:v_wawi_ptm_plantimeday_wh.val_hours'),
plan_val_inv_training NUMERIC(18,4) OPTIONS(description='CORE:v_wawi_ptm_plantimeday_wh.(val_inventory + val_training)'),
val_retail NUMERIC(18,5) OPTIONS(description='CORE:v_agg_sales_store_day.val_retail'),
val_retail_net NUMERIC(18,5) OPTIONS(description='CORE:v_agg_sales_store_day.val_retail_net'),
cnt_customer NUMERIC(18,4) OPTIONS(description='CORE:v_agg_sales_store_day.cnt_customer'),
time_working_netto_std NUMERIC(18,4) OPTIONS(description='CORE:v_wawi_agg_wt_store_day_asis.time_working_netto_hrs'),
miss_times_perf NUMERIC(18,4) OPTIONS(description='CORE:v_wawi_agg_wt_store_day_asis.perf_rel_absence_hrs'),
is_daily_level_row INTEGER
OPTIONS(description='MART_MSI:v_bo_perf_cal_list_day_2: 1= Kalendertag ist Teil der Normal-Auswahl Tagesebene. 0= außerhalb'),
is_weekly_normal_level_row INTEGER
OPTIONS(description='MART_MSI:v_bo_perf_cal_list_day_2: 1= Kalendertag ist Teil der Normal-Auswahl Wochenebene. 0= außerhalb'),
is_weekly_pyshift_level_row INTEGER
OPTIONS(description='MART_MSI:v_bo_perf_cal_list_day_2: 1= Kalendertag ist Teil der PrevYear-Auswahl Wochenebene. 0= außerhalb'),
is_monthly_level_row INTEGER
OPTIONS(description='MART_MSI:v_bo_perf_cal_list_day_2: 1= Kalendertag ist Teil der Normal-Auswahl Monatsebene. 0= außerhalb'),
sales_qty_asis NUMERIC(18,5) OPTIONS(description='Abverkaufte Stück ist'),
avg_item_price NUMERIC(18,5) OPTIONS(description='Average item_2 price'),
plan_sales_pieces NUMERIC(18,5) OPTIONS(description='Plan Abverkauf Stk/Kg'),
plan_avg_sales_price NUMERIC(18,5) OPTIONS(description='Plan durchschnittliche Artikelpreis'),
plan_piece_performance NUMERIC(18,5) OPTIONS(description='Plan Stückleistung'),
piece_receipt NUMERIC(18,5) OPTIONS(description='Durchschnittliche Anzahl Artikeln/Bon'),
piece_performance NUMERIC(18,5) OPTIONS(description='IST Stückleistung')
)
OPTIONS(description='Materialisierung der P_LEW_MART_MSI.V_MAT_BO_BASE_PERFORMANCE_LIST. Basistab für alle BO_PERFORMANCELIST-Views');