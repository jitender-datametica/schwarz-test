/*
  Story      : https://jira.schwarz/browse/REP4-9791
  
  Description: Basis View für alle BO_PERFORMANCELIST-Views

  Source
    P_LEW_CORE_AC
      V_LOCATION

    P_LEW_BIL_AC
      V_STORE_RELOCATION
      V_STORE_TO_WAREHOUSE_LASTKNOWN
      V_LOCATION_ORGANIZATION

    P_LEW_MART_MSI
      T_BO_BASE_PERFORMANCE_LIST

  History:
    2021-11-09  zied.nanaa_ext@mail.schwarz
    Script Teradata Migration from svn://l-as616.asp.lidl.net/ddl/lew/lew_mart_msi/lew_mart_msi_v_bo_base_performance_list.sql
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_bo_base_performance_list (client_id
OPTIONS(description='DWH-Client im DWH = LIDL-Land (country)'), loc_sid_store
OPTIONS(description='DWHKey des Stores aus Join mit #X_LEW_BIL#.v_store über #X_LEW_BIL#.v_store_relocation. Angezeigt wird der GewinnerStore bei Fusionen - nicht der untergegangene OriginalStore der Fakten'),
cal_dt OPTIONS(description='MART_MSI:v_bo_perf_cal_list_day: Fakten-Kalendertag'), py_caldt_shifted
OPTIONS(description='MART_MSI:v_bo_perf_cal_list_day: Nur für Wochenauswahl: der über die Kalenderfunktion cal_dt_swday_prev_1y ins Currentyear verschobene Tag der PrevYear-Woche'),
cy_week OPTIONS(description='MART_MSI:v_bo_perf_cal_list_day: Woche zum Fakten-Kalendertag'), py_week_shifted
OPTIONS(description='MART_MSI:v_bo_perf_cal_list_day: Nur für Wochenauswahl: über Kalenderfunktion cal_dt_swday_prev_1y ins Currentyear verschobene PrevYear-Woche'),
cy_week_seq OPTIONS(description='MART_MSI:v_bo_perf_cal_list_day: Relativ-Sequenz der Woche zum Fakten-Kalendertag'),
py_week_seq_shifted
OPTIONS(description='MART_MSI:v_bo_perf_cal_list_day: Nur für Wochenauswahl: Relativ-Sequenz der über die Kalenderfunktion cal_dt_swday_prev_1y ins Currentyear verschobenen PrevYear-Woche'),
cy_month OPTIONS(description='MART_MSI:v_bo_perf_cal_list_day: Monat zum Fakten-Kalendertag'), orig_store_nr
OPTIONS(description='NaturalKey des Stores aus Join mit #X_LEW_BIL#.v_store über #X_LEW_BIL#.v_store_relocation. Angezeigt wird der GewinnerStore bei Fusionen - nicht der untergegangene OriginalStore der Fakten'),
used_store_desc
OPTIONS(description='Benutzt wird loc_name2 vor loc_name aus #X_LEW_BIL#.v_store -> letztlich aus Core:t_location'),
used_closing_dt
OPTIONS(description='Ist Opening_DT (#X_LEW_BIL#.v_store.opening_dt vor 30.12.9999) real, dann BIL:v_store.dat_closing_ovis vor BIL:v_store.closing_dt vor 30.12.9999'),
city OPTIONS(description='AUS CORE.n_address'), country_id OPTIONS(description='= client_id'), country_desc
OPTIONS(description='AUS MART_MSI.v_ref_country_act_bo (letztlich aus CORE:t_wawi_ref_country_act - für mehrsprachige Ländernamen)'),
country_iso_cd
OPTIONS(description='AUS MART_MSI.v_ref_country_act_bo (letztlich aus CORE:t_wawi_ref_country_act - für mehrsprachige Ländernamen)'),
src_wh_id
OPTIONS(description='NaturalKey des dem Store (Gewinnerstore! - siehe loc_sid_store) über die Hauptlieferbeziehung zugeordneten Warehouse (aus BIL:v_store_to_warehouse_lastknown)'),
used_wh_desc
OPTIONS(description='Benutzt wird loc_name2 vor loc_name aus CORE:t_location über die dem Store (Gewinnerstore! - siehe loc_sid_store) in der Hauptlieferbeziehung zugeordneten Warehouse (aus BIL:v_store_to_warehouse_lastknown)'),
sales_manager_id OPTIONS(description='AUS BIL:v_location_organization'), sales_manager_name
OPTIONS(description='AUS BIL:v_location_organization'), account_manager_id
OPTIONS(description='AUS BIL:v_location_organization'), account_manager_name
OPTIONS(description='AUS BIL:v_location_organization'), curr_cd OPTIONS(description='AUS CORE:v_client'),
is_daily_level_row
OPTIONS(description='MART_MSI:v_bo_perf_cal_list_day: 1= Kalendertag ist Teil der Normal-Auswahl Tagesebene. 0= außerhalb'),
is_weekly_normal_level_row
OPTIONS(description='MART_MSI:v_bo_perf_cal_list_day: 1= Kalendertag ist Teil der Normal-Auswahl Wochenebene. 0= außerhalb'),
is_weekly_pyshift_level_row
OPTIONS(description='MART_MSI:v_bo_perf_cal_list_day: 1= Kalendertag ist Teil der PrevYear-Auswahl Wochenebene. 0= außerhalb'),
is_monthly_level_row
OPTIONS(description='MART_MSI:v_bo_perf_cal_list_day: 1= Kalendertag ist Teil der Normal-Auswahl Monatsebene. 0= außerhalb'),
plan_val_turnover OPTIONS(description='CORE:v_wawi_ptm_plantimeday_wh.val_turnover'), plan_val_turnover_net
OPTIONS(description='CORE:v_wawi_ptm_plantimeday_wh.val_turnover (kein Schreibfehler!)'), plan_val_hours
OPTIONS(description='CORE:v_wawi_ptm_plantimeday_wh.val_hours'), plan_val_inv_training
OPTIONS(description='CORE:v_wawi_ptm_plantimeday_wh.(val_inventory + val_training)'), val_retail
OPTIONS(description='CORE:v_agg_sales_store_day.val_retail'), val_retail_net
OPTIONS(description='CORE:v_agg_sales_store_day.val_retail_net'), cnt_customer
OPTIONS(description='CORE:v_agg_sales_store_day.cnt_customer'), time_working_netto_std
OPTIONS(description='CORE:v_wawi_agg_wt_store_day_asis.time_working_netto_hrs'), miss_times_perf
OPTIONS(description='CORE:v_wawi_agg_wt_store_day_asis.perf_rel_absence_hrs'), sales_qty_asis
OPTIONS(description='Abverkaufte Stück ist'), avg_item_price OPTIONS(description='Average item price'),
plan_sales_pieces OPTIONS(description='Plan Abverkauf Stk/Kg'), plan_avg_sales_price
OPTIONS(description='Plan durchschnittliche Artikelpreis'), plan_piece_performance
OPTIONS(description='Plan Stückleistung'), piece_receipt OPTIONS(description='Durchschnittliche Anzahl Artikeln/Bon'),
piece_performance OPTIONS(description='IST Stückleistung'))
OPTIONS(DESCRIPTION = `Basis View für alle BO_PERFORMANCELIST-Views`) AS SELECT AGG.client_id,
 ORG.loc_sid_store_move_to AS loc_sid_store,
 AGG.cal_dt,
 AGG.py_caldt_shifted,
 AGG.cy_week,
 AGG.py_week_shifted,
 AGG.cy_week_seq,
 AGG.py_week_seq_shifted,
 AGG.cy_month,
 AGG.orig_store_nr,
 AGG.used_store_desc,
 AGG.used_closing_dt,
 AGG.city,
 AGG.country_id,
 AGG.country_desc,
 AGG.country_iso_cd,
 OS.src_wh_id,
 COALESCE(OWH.loc_name2, OWH.loc_name) AS used_wh_desc,
 SAM.sales_manager_id,
 SAM.sales_manager_name,
 SAM.account_manager_id,
 SAM.account_manager_name,
 AGG.curr_cd,
 AGG.is_daily_level_row,
 AGG.is_weekly_normal_level_row,
 AGG.is_weekly_pyshift_level_row,
 AGG.is_monthly_level_row,
 SUM(AGG.plan_val_turnover) AS plan_val_turnover,
 SUM(AGG.plan_val_turnover_net) AS plan_val_turnover_net,
 SUM(AGG.plan_val_hours) AS plan_val_hours,
 SUM(AGG.plan_val_inv_training) AS plan_val_inv_training,
 SUM(AGG.val_retail) AS val_retail,
 SUM(AGG.val_retail_net) AS val_retail_net,
 SUM(AGG.cnt_customer) AS cnt_customer,
 SUM(AGG.time_working_netto_std) AS time_working_netto_std,
 SUM(AGG.miss_times_perf) AS miss_times_perf,
 SUM(AGG.sales_qty_asis) AS sales_qty_asis,
 SUM(AGG.avg_item_price) AS avg_item_price,
 SUM(AGG.plan_sales_pieces) AS plan_sales_pieces,
 MAX(AGG.plan_avg_sales_price) AS plan_avg_sales_price,
 MAX(AGG.plan_piece_performance) AS plan_piece_performance,
 MAX(AGG.piece_receipt) AS piece_receipt,
 MAX(AGG.piece_performance) AS piece_performance
FROM ldl_p_lew_mart_msi.t_bo_base_performance_list AS AGG
 INNER JOIN ldl_p_lew_bil_ac.v_store_relocation AS ORG ON AGG.client_id = ORG.client_id AND AGG.loc_sid_store = ORG.loc_sid_store
   
 INNER JOIN ldl_p_lew_bil_ac.v_store_to_warehouse_lastknown AS OS ON AGG.client_id = OS.client_id AND AGG.loc_sid_store
   = OS.loc_sid_store
 INNER JOIN ldl_p_lew_core_ac.v_location AS OWH ON OS.client_id = OWH.client_id AND OS.loc_sid_wh = OWH.loc_sid
 LEFT JOIN ldl_p_lew_bil_ac.v_location_organization AS SAM ON AGG.client_id = SAM.client_id AND AGG.loc_sid_store = SAM
    .loc_sid_store AND OS.loc_sid_wh = SAM.loc_sid_wh
GROUP BY AGG.client_id,
 loc_sid_store,
 AGG.cal_dt,
 AGG.py_caldt_shifted,
 AGG.cy_week,
 AGG.py_week_shifted,
 AGG.cy_week_seq,
 AGG.py_week_seq_shifted,
 AGG.cy_month,
 AGG.orig_store_nr,
 AGG.used_store_desc,
 AGG.used_closing_dt,
 AGG.city,
 AGG.country_id,
 AGG.country_desc,
 AGG.country_iso_cd,
 OS.src_wh_id,
 used_wh_desc,
 SAM.sales_manager_id,
 SAM.sales_manager_name,
 SAM.account_manager_id,
 SAM.account_manager_name,
 AGG.curr_cd,
 AGG.is_daily_level_row,
 AGG.is_weekly_normal_level_row,
 AGG.is_weekly_pyshift_level_row,
 AGG.is_monthly_level_row;