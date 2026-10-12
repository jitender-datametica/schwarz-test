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

CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_BO_BASE_PERFORMANCE_LIST COMMENT='Basis View für alle BO_PERFORMANCELIST-Views'
(
    client_id                   COMMENT 'DWH-Client im DWH = LIDL-Land (country)'
  , loc_sid_store               COMMENT 'DWHKey des Stores aus Join mit #X_LEW_BIL#.v_store über #X_LEW_BIL#.v_store_relocation. Angezeigt wird der GewinnerStore bei Fusionen - nicht der untergegangene OriginalStore der Fakten'
  , cal_dt                      COMMENT 'MART_MSI:v_bo_perf_cal_list_day: Fakten-Kalendertag'
  , py_caldt_shifted            COMMENT 'MART_MSI:v_bo_perf_cal_list_day: Nur für Wochenauswahl: der über die Kalenderfunktion cal_dt_swday_prev_1y ins Currentyear verschobene Tag der PrevYear-Woche'
  , cy_week                     COMMENT 'MART_MSI:v_bo_perf_cal_list_day: Woche zum Fakten-Kalendertag'
  , py_week_shifted             COMMENT 'MART_MSI:v_bo_perf_cal_list_day: Nur für Wochenauswahl: über Kalenderfunktion cal_dt_swday_prev_1y ins Currentyear verschobene PrevYear-Woche'
  , cy_week_seq                 COMMENT 'MART_MSI:v_bo_perf_cal_list_day: Relativ-Sequenz der Woche zum Fakten-Kalendertag'
  , py_week_seq_shifted         COMMENT 'MART_MSI:v_bo_perf_cal_list_day: Nur für Wochenauswahl: Relativ-Sequenz der über die Kalenderfunktion cal_dt_swday_prev_1y ins Currentyear verschobenen PrevYear-Woche'
  , cy_month                    COMMENT 'MART_MSI:v_bo_perf_cal_list_day: Monat zum Fakten-Kalendertag'
  , orig_store_nr               COMMENT 'NaturalKey des Stores aus Join mit #X_LEW_BIL#.v_store über #X_LEW_BIL#.v_store_relocation. Angezeigt wird der GewinnerStore bei Fusionen - nicht der untergegangene OriginalStore der Fakten'
  , used_store_desc             COMMENT 'Benutzt wird loc_name2 vor loc_name aus #X_LEW_BIL#.v_store -> letztlich aus Core:t_location'
  , used_closing_dt             COMMENT 'Ist Opening_DT (#X_LEW_BIL#.v_store.opening_dt vor 30.12.9999) real, dann BIL:v_store.dat_closing_ovis vor BIL:v_store.closing_dt vor 30.12.9999'
  , city                        COMMENT 'AUS CORE.n_address'
  , country_id                  COMMENT '= client_id'
  , country_desc                COMMENT 'AUS MART_MSI.v_ref_country_act_bo (letztlich aus CORE:t_wawi_ref_country_act - für mehrsprachige Ländernamen)'
  , country_iso_cd              COMMENT 'AUS MART_MSI.v_ref_country_act_bo (letztlich aus CORE:t_wawi_ref_country_act - für mehrsprachige Ländernamen)'
  , src_wh_id                   COMMENT 'NaturalKey des dem Store (Gewinnerstore! - siehe loc_sid_store) über die Hauptlieferbeziehung zugeordneten Warehouse (aus BIL:v_store_to_warehouse_lastknown)'
  , used_wh_desc                COMMENT 'Benutzt wird loc_name2 vor loc_name aus CORE:t_location über die dem Store (Gewinnerstore! - siehe loc_sid_store) in der Hauptlieferbeziehung zugeordneten Warehouse (aus BIL:v_store_to_warehouse_lastknown)'
  , sales_manager_id            COMMENT 'AUS BIL:v_location_organization'
  , sales_manager_name          COMMENT 'AUS BIL:v_location_organization'
  , account_manager_id          COMMENT 'AUS BIL:v_location_organization'
  , account_manager_name        COMMENT 'AUS BIL:v_location_organization'
  , curr_cd                     COMMENT 'AUS CORE:v_client'
  , is_daily_level_row          COMMENT 'MART_MSI:v_bo_perf_cal_list_day: 1= Kalendertag ist Teil der Normal-Auswahl Tagesebene. 0= außerhalb'
  , is_weekly_normal_level_row  COMMENT 'MART_MSI:v_bo_perf_cal_list_day: 1= Kalendertag ist Teil der Normal-Auswahl Wochenebene. 0= außerhalb'
  , is_weekly_pyshift_level_row COMMENT 'MART_MSI:v_bo_perf_cal_list_day: 1= Kalendertag ist Teil der PrevYear-Auswahl Wochenebene. 0= außerhalb'
  , is_monthly_level_row        COMMENT 'MART_MSI:v_bo_perf_cal_list_day: 1= Kalendertag ist Teil der Normal-Auswahl Monatsebene. 0= außerhalb'
  , plan_val_turnover           COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover'
  , plan_val_turnover_net       COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover (kein Schreibfehler!)'
  , plan_val_hours              COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_hours'
  , plan_val_inv_training       COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.(val_inventory + val_training)'
  , val_retail                  COMMENT 'CORE:v_agg_sales_store_day.val_retail'
  , val_retail_net              COMMENT 'CORE:v_agg_sales_store_day.val_retail_net'
  , cnt_customer                COMMENT 'CORE:v_agg_sales_store_day.cnt_customer'
  , time_working_netto_std      COMMENT 'CORE:v_wawi_agg_wt_store_day_asis.time_working_netto_hrs'
  , miss_times_perf             COMMENT 'CORE:v_wawi_agg_wt_store_day_asis.perf_rel_absence_hrs'
  , sales_qty_asis              COMMENT 'Abverkaufte Stück ist'
  , avg_item_price              COMMENT 'Average item price'
  , plan_sales_pieces           COMMENT 'Plan Abverkauf Stk/Kg'
  , plan_avg_sales_price        COMMENT 'Plan durchschnittliche Artikelpreis'
  , plan_piece_performance      COMMENT 'Plan Stückleistung'
  , piece_receipt               COMMENT 'Durchschnittliche Anzahl Artikeln/Bon'
  , piece_performance           COMMENT 'IST Stückleistung'
)

AS

SELECT
    agg.client_id
  , org.loc_sid_store_move_to             AS loc_sid_store
  , agg.cal_dt
  , agg.py_caldt_shifted
  , agg.cy_week
  , agg.py_week_shifted
  , agg.cy_week_seq
  , agg.py_week_seq_shifted
  , agg.cy_month
  , agg.orig_store_nr
  , agg.used_store_desc
  , agg.used_closing_dt
  , agg.city
  , agg.country_id
  , agg.country_desc
  , agg.country_iso_cd
  , os.src_wh_id
  , COALESCE(owh.loc_name2,owh.loc_name)  AS used_wh_desc
  , sam.sales_manager_id
  , sam.sales_manager_name
  , sam.account_manager_id
  , sam.account_manager_name
  , agg.curr_cd
  , agg.is_daily_level_row
  , agg.is_weekly_normal_level_row
  , agg.is_weekly_pyshift_level_row
  , agg.is_monthly_level_row
  , SUM(plan_val_turnover)                AS plan_val_turnover
  , SUM(plan_val_turnover_net)            AS plan_val_turnover_net
  , SUM(plan_val_hours)                   AS plan_val_hours
  , SUM(plan_val_inv_training)            AS plan_val_inv_training
  , SUM(val_retail)                       AS val_retail
  , SUM(val_retail_net)                   AS val_retail_net
  , SUM(cnt_customer)                     AS cnt_customer
  , SUM(time_working_netto_std)           AS time_working_netto_std
  , SUM(miss_times_perf)                  AS miss_times_perf
  , SUM(sales_qty_asis)                   AS sales_qty_asis
  , SUM(avg_item_price)                   AS avg_item_price
  , SUM(plan_sales_pieces)                AS plan_sales_pieces
  , MAX(plan_avg_sales_price)             AS plan_avg_sales_price
  , MAX(plan_piece_performance)           AS plan_piece_performance
  , MAX(piece_receipt)                    AS piece_receipt
  , MAX(piece_performance)                AS piece_performance
FROM 
  P_LEW_MART_MSI.T_BO_BASE_PERFORMANCE_LIST    AS agg

INNER JOIN 
  P_LEW_BIL_AC.V_STORE_RELOCATION              AS org
  ON
    agg.client_id        = org.client_id
    AND
    agg.loc_sid_store    = org.loc_sid_store

INNER JOIN 
  P_LEW_BIL_AC.v_store_to_warehouse_lastknown  AS os
  ON
    os.client_id     = agg.client_id
    AND 
    os.loc_sid_store = agg.loc_sid_store

INNER JOIN 
  P_LEW_CORE_AC.v_location                     AS owh
  ON
    os.client_id  = owh.client_id
    AND 
    os.loc_sid_wh = owh.loc_sid
  
LEFT OUTER JOIN 
  P_LEW_BIL_AC.v_location_organization         AS sam
  ON
  agg.client_id     = sam.client_id
  AND
  agg.loc_sid_store = sam.loc_sid_store
  AND
  os.loc_sid_wh     = sam.loc_sid_wh

GROUP BY
1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27
;