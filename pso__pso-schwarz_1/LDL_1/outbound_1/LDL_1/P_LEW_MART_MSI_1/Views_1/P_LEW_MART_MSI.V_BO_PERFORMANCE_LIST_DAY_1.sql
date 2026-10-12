/*
  Story      : https://jira.schwarz/browse/REP4-9791
  
  Description: Schnittstellenview Cube-Beladung BO

  Source
    P_LEW_MART_MSI
      V_BO_BASE_PERFORMANCE_LIST_1

  History:
    2021-11-09  zied.nanaa_ext@mail.schwarz
    Script Teradata Migration from svn://l-as616.asp.lidl.net/ddl/lew/lew_mart_msi/lew_mart_msi_v_bo_performance_list_day.sql


  Comments from the original Teradata DDL:
  Created by Jens Thole
  on 14.06.2018
  Inhalt: finale Zielstruktur der Tagesebenen-Schnittstelle der BO_PERORMANCE_LIST
  Quellen: MART_MSI:t_bo_base_performance_list_1 (alleinige Basisstruktur)
  Es erfolgt eine_1 Standardeinschränkung auf Datensätze unterhalb des jeweiligen Store-closing-Datums.
  relevante Measure-Values werden ermittelt. Es findet kein Ranking statt.
  Granularität (Gewinnerstore, Tag_1) - keine weitere Verdichtung

*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_bo_performance_list_day_1 (client_id
OPTIONS(description='DWH-Client im DWH = LIDL-Land_1 (country_1)'), country_id OPTIONS(description='= client_id'),
country_desc
OPTIONS(description='AUS MART_MSI.v_ref_country_act_bo_1 (letztlich aus CORE:t_wawi_ref_country_act_1 - für mehrsprachige Ländernamen)'),
country_iso_cd
OPTIONS(description='AUS MART_MSI.v_ref_country_act_bo_1 (letztlich aus CORE:t_wawi_ref_country_act_1 - für mehrsprachige Ländernamen)'),
store_id
OPTIONS(description='DWHKey des Stores aus Join mit #X_LEW_BIL#.v_store_1 über #X_LEW_BIL#.v_store_relocation. Angezeigt wird der GewinnerStore bei Fusionen - nicht der untergegangene OriginalStore der Fakten'),
orig_store_nr
OPTIONS(description='NaturalKey des Stores aus Join mit #X_LEW_BIL#.v_store_1 über #X_LEW_BIL#.v_store_relocation. Angezeigt wird der GewinnerStore bei Fusionen - nicht der untergegangene OriginalStore der Fakten'),
store_desc
OPTIONS(description='Benutzt wird loc_name2 vor loc_name (used_store_desc) aus #X_LEW_BIL#.v_store_1 -> letztlich aus Core:t_location_1'),
city OPTIONS(description='AUS CORE.t_address_1'), wh_id
OPTIONS(description='NaturalKey (src_wh_id) des dem Store (Gewinnerstore! - siehe loc_sid_store) über die Hauptlieferbeziehung zugeordneten Warehouse (aus BIL:v_store_to_warehouse_lastknown_1)'),
wh_desc
OPTIONS(description='Benutzt wird loc_name2 vor loc_name (used_wh_desc) aus CORE:t_location_1 über die dem Store (Gewinnerstore! - siehe loc_sid_store) in der Hauptlieferbeziehung zugeordneten Warehouse (aus BIL:v_store_to_warehouse_lastknown_1)'),
sales_manager_id OPTIONS(description='AUS BIL:v_location_organization_1'), sales_manager_name
OPTIONS(description='AUS BIL:v_location_organization_1'), account_manager_id
OPTIONS(description='AUS BIL:v_location_organization_1'), account_manager_name
OPTIONS(description='AUS BIL:v_location_organization_1'), dat_calendar
OPTIONS(description='MART_MSI:v_bo_perf_cal_list_day_1: Fakten-Kalendertag'), cy_week
OPTIONS(description='MART_MSI:v_bo_perf_cal_list_day_1: Woche_1 zum Fakten-Kalendertag'), currency_iso_cd
OPTIONS(description='AUS CORE:v_client_1'), plan_val_turnover
OPTIONS(description='CORE:v_wawi_ptm_plantimeday_wh.val_turnover'), plan_val_turnover_net
OPTIONS(description='CORE:v_wawi_ptm_plantimeday_wh.val_turnover (kein Schreibfehler!)'), plan_val_hours
OPTIONS(description='CORE:v_wawi_ptm_plantimeday_wh.val_hours'), plan_val_inv_training
OPTIONS(description='CORE:v_wawi_ptm_plantimeday_wh.(val_inventory + val_training)'), val_retail_asis
OPTIONS(description='CORE:v_agg_sales_store_day.val_retail'), val_retail_net_asis
OPTIONS(description='CORE:v_agg_sales_store_day.val_retail_net'), cnt_customer_asis
OPTIONS(description='CORE:v_agg_sales_store_day.cnt_customer'), time_working_netto_std
OPTIONS(description='CORE:v_wawi_agg_wt_store_day_asis.time_working_netto_hrs'), miss_times_perf
OPTIONS(description='CORE:v_wawi_agg_wt_store_day_asis.perf_rel_absence_hrs'), diff_val_retail_pct
OPTIONS(description='MART_MSI:t_bo_base_performance_list_1: Formel: 100*(val_retail-plan_val_turnover) / plan_val_turnover'),
diff_val_retail_net_pct
OPTIONS(description='MART_MSI:t_bo_base_performance_list_1: Formel: 100*(val_retail_net-plan_val_turnover_net) / plan_val_turnover_net (wobei aktuell plan_val_turnover=plan_val_turnover_net)'),
diff_sales_qty_asis_pct OPTIONS(description='Unterschied zwischen Plan-Abverkaufe und IST-Abverkaufe in %'),
diff_piece_perf_asis_pct OPTIONS(description='Unterschied zwischen Stückleistung (Plan) und Stückleistung (IST) in %'),
diff_hours
OPTIONS(description='MART_MSI:t_bo_base_performance_list_1: Formel: time_working_netto_std + miss_times_perf - plan_val_hours. Realstunden(Arbeit+Schulung)-Planstunden'),
plan_productivity OPTIONS(description='MART_MSI:t_bo_base_performance_list_1: Formel: plan_val_turnover / plan_val_hours'),
plan_productivity_net
OPTIONS(description='MART_MSI:t_bo_base_performance_list_1: Formel: plan_val_turnover_net / plan_val_hours (wobei aktuell plan_val_turnover=plan_val_turnover_net)'),
act_productivity
OPTIONS(description='MART_MSI:t_bo_base_performance_list_1: Formel: val_retail / (time_working_netto_std + miss_times_perf)'),
act_productivity_net
OPTIONS(description='MART_MSI:t_bo_base_performance_list_1: Formel: val_retail_net / (time_working_netto_std + miss_times_perf)'),
max_umsdate OPTIONS(description=''), max_hrsdate OPTIONS(description=''), plan_turnover_calc_ums_diff
OPTIONS(description='CORE:v_wawi_ptm_plantimeday_wh.val_turnover; Wertausweis nur bis zum Maximalen Umsatztag der Tagesauswahl pro Store!'),
plan_turnover_calc_ums_dif_net
OPTIONS(description='CORE:v_wawi_ptm_plantimeday_wh.val_turnover (kein Schreibfehler!); Wertausweis nur bis zum Maximalen Umsatztag der Tagesauswahl pro Store!'),
plan_turnover_calc_prod_diff
OPTIONS(description='CORE:v_wawi_ptm_plantimeday_wh.val_turnover; Wertausweis nur bis zum früheren Tag_1 aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der Tagesauswahl pro Store!'),
plan_turnover_calc_pro_dif_net
OPTIONS(description='CORE:v_wawi_ptm_plantimeday_wh.val_turnover (kein Schreibfehler!); Wertausweis nur bis zum früheren Tag_1 aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der Tagesauswahl pro Store!'),
plan_sales_qty_calc_abv_diff
OPTIONS(description='MART_MSI:t_bo_base_performance_list.plan_sales_pieces; Wertausweis nur bis zum Maximalen Umsatztag der Tagesauswahl pro Store!'),
plan_sales_qty_calc_prod_diff
OPTIONS(description='MART_MSI:t_bo_base_performance_list.plan_sales_pieces; Wertausweis nur bis zum Maximalen Umsatztag der Tagesauswahl pro Store!'),
plan_hours_calc_hrs_diff
OPTIONS(description='CORE:v_wawi_ptm_plantimeday_wh.val_hours; Wertausweis nur bis zum Maximalen Umsatztag der Tagesauswahl pro Store!'),
plan_hours_calc_prod_diff
OPTIONS(description='CORE:v_wawi_ptm_plantimeday_wh.val_hours; Wertausweis nur bis zum früheren Tag_1 aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der Tagesauswahl pro Store!'),
val_retail_calc_prod_diff
OPTIONS(description='CORE:v_agg_sales_store_day.val_retail; Wertausweis nur bis zum früheren Tag_1 aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der Tagesauswahl pro Store!'),
val_retail_calc_prod_diff_net
OPTIONS(description='CORE:v_agg_sales_store_day.val_retail_net; Wertausweis nur bis zum früheren Tag_1 aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der Tagesauswahl pro Store!'),
hrs_calc_prod_diff
OPTIONS(description='CORE:v_wawi_agg_wt_store_day_asis.time_working_netto_hrs; Wertausweis nur bis zum früheren Tag_1 aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der Tagesauswahl pro Store!'),
miss_times_perf_calc_prod_diff
OPTIONS(description='CORE:v_wawi_agg_wt_store_day_asis.perf_rel_absence_hrs; Wertausweis nur bis zum früheren Tag_1 aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der Tagesauswahl pro Store!'),
sales_qty_asis OPTIONS(description='Abverkaufte Stück/Kg IST'), plan_sales_qty
OPTIONS(description='Plan Abverkaufte Stück/Kg'), piece_perf_asis OPTIONS(description='Stückleistung IST'),
plan_perf_piece OPTIONS(description='Plan Stückleistung'), item_price_asis
OPTIONS(description='Durchschnittliche Artikelpreis IST'))
OPTIONS(DESCRIPTION = `Schnittstellenview Cube-Beladung BO; Performancelist DAY`) AS
-- , CASE WHEN cal_dt <= max_umsdate                          THEN plan_sales_qty            END             AS plan_sales_qty_calc_abv_diff

-- , CASE WHEN cal_dt <= max_umsdate AND cal_dt<= max_hrsdate THEN plan_sales_qty            END             AS plan_sales_qty_calc_prod_diff

SELECT client_id,
 country_id,
 country_desc,
 country_iso_cd,
 loc_sid_store AS store_id,
 orig_store_nr,
 used_store_desc AS store_desc,
 city,
 src_wh_id AS wh_id,
 used_wh_desc AS wh_desc,
 sales_manager_id,
 sales_manager_name,
 account_manager_id,
 account_manager_name,
 cal_dt AS dat_calendar,
 cy_week,
 curr_cd AS currency_iso_cd,
 plan_val_turnover,
 plan_val_turnover_net,
 plan_val_hours,
 plan_val_inv_training,
 val_retail AS val_retail_asis,
 val_retail_net AS val_retail_net_asis,
 cnt_customer AS cnt_customer_asis,
 time_working_netto_std,
 miss_times_perf,
    (val_retail - plan_val_turnover) / IF(plan_val_turnover = 0, NULL, plan_val_turnover) * 100 AS diff_val_retail_pct,
    (val_retail_net - plan_val_turnover_net) / IF(plan_val_turnover_net = 0, NULL, plan_val_turnover_net) * 100 AS
 diff_val_retail_net_pct,
    (sales_qty_asis - plan_sales_pieces) / IF(plan_sales_pieces = 0, NULL, plan_sales_pieces) * 100 AS
 diff_sales_qty_asis_pct,
    (piece_performance - plan_piece_performance) / IF(plan_piece_performance = 0, NULL, plan_piece_performance) * 100 AS
 diff_piece_perf_asis_pct,
  time_working_netto_std - plan_val_hours AS diff_hours,
  plan_val_turnover / IF(plan_val_hours = 0, NULL, plan_val_hours) AS plan_productivity,
  plan_val_turnover_net / IF(plan_val_hours = 0, NULL, plan_val_hours) AS plan_productivity_net,
  val_retail / IF(time_working_netto_std = 0, NULL, time_working_netto_std) AS act_productivity,
  val_retail_net / IF(time_working_netto_std = 0, NULL, time_working_netto_std) AS act_productivity_net,
 MAX(CASE
   WHEN val_retail > 0
   THEN cal_dt
   ELSE NULL
   END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
  UNBOUNDED FOLLOWING) AS max_umsdate,
 MAX(CASE
   WHEN time_working_netto_std > 0
   THEN cal_dt
   ELSE NULL
   END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
  UNBOUNDED FOLLOWING) AS max_hrsdate,
  CASE
  WHEN cal_dt <= (MAX(CASE
      WHEN val_retail > 0
      THEN cal_dt
      ELSE NULL
      END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
     UNBOUNDED FOLLOWING))
  THEN plan_val_turnover
  ELSE NULL
  END AS plan_turnover_calc_ums_diff,
  CASE
  WHEN cal_dt <= (MAX(CASE
      WHEN val_retail > 0
      THEN cal_dt
      ELSE NULL
      END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
     UNBOUNDED FOLLOWING))
  THEN plan_val_turnover_net
  ELSE NULL
  END AS plan_turnover_calc_ums_dif_net,
  CASE
  WHEN cal_dt <= (MAX(CASE
       WHEN val_retail > 0
       THEN cal_dt
       ELSE NULL
       END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING)) AND cal_dt <= (MAX(CASE
       WHEN time_working_netto_std > 0
       THEN cal_dt
       ELSE NULL
       END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING))
  THEN plan_val_turnover
  ELSE NULL
  END AS plan_turnover_calc_prod_diff,
  CASE
  WHEN cal_dt <= (MAX(CASE
       WHEN val_retail > 0
       THEN cal_dt
       ELSE NULL
       END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING)) AND cal_dt <= (MAX(CASE
       WHEN time_working_netto_std > 0
       THEN cal_dt
       ELSE NULL
       END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING))
  THEN plan_val_turnover_net
  ELSE NULL
  END AS plan_turnover_calc_pro_dif_net,
  CASE
  WHEN cal_dt <= (MAX(CASE
      WHEN val_retail > 0
      THEN cal_dt
      ELSE NULL
      END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
     UNBOUNDED FOLLOWING))
  THEN plan_sales_pieces
  ELSE NULL
  END AS plan_sales_qty_calc_abv_diff,
  CASE
  WHEN cal_dt <= (MAX(CASE
       WHEN val_retail > 0
       THEN cal_dt
       ELSE NULL
       END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING)) AND cal_dt <= (MAX(CASE
       WHEN time_working_netto_std > 0
       THEN cal_dt
       ELSE NULL
       END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING))
  THEN plan_sales_pieces
  ELSE NULL
  END AS plan_sales_qty_calc_prod_diff,
  CASE
  WHEN cal_dt <= (MAX(CASE
      WHEN time_working_netto_std > 0
      THEN cal_dt
      ELSE NULL
      END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
     UNBOUNDED FOLLOWING))
  THEN plan_val_hours
  ELSE NULL
  END AS plan_hours_calc_hrs_diff,
  CASE
  WHEN cal_dt <= (MAX(CASE
       WHEN val_retail > 0
       THEN cal_dt
       ELSE NULL
       END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING)) AND cal_dt <= (MAX(CASE
       WHEN time_working_netto_std > 0
       THEN cal_dt
       ELSE NULL
       END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING))
  THEN plan_val_hours
  ELSE NULL
  END AS plan_hours_calc_prod_diff,
  CASE
  WHEN cal_dt <= (MAX(CASE
       WHEN val_retail > 0
       THEN cal_dt
       ELSE NULL
       END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING)) AND cal_dt <= (MAX(CASE
       WHEN time_working_netto_std > 0
       THEN cal_dt
       ELSE NULL
       END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING))
  THEN val_retail
  ELSE NULL
  END AS val_retail_calc_prod_diff,
  CASE
  WHEN cal_dt <= (MAX(CASE
       WHEN val_retail > 0
       THEN cal_dt
       ELSE NULL
       END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING)) AND cal_dt <= (MAX(CASE
       WHEN time_working_netto_std > 0
       THEN cal_dt
       ELSE NULL
       END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING))
  THEN val_retail_net
  ELSE NULL
  END AS val_retail_calc_prod_diff_net,
  CASE
  WHEN cal_dt <= (MAX(CASE
       WHEN val_retail > 0
       THEN cal_dt
       ELSE NULL
       END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING)) AND cal_dt <= (MAX(CASE
       WHEN time_working_netto_std > 0
       THEN cal_dt
       ELSE NULL
       END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING))
  THEN time_working_netto_std
  ELSE NULL
  END AS hrs_calc_prod_diff,
  CASE
  WHEN cal_dt <= (MAX(CASE
       WHEN val_retail > 0
       THEN cal_dt
       ELSE NULL
       END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING)) AND cal_dt <= (MAX(CASE
       WHEN time_working_netto_std > 0
       THEN cal_dt
       ELSE NULL
       END) OVER (PARTITION BY client_id, CAST(loc_sid_store AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING))
  THEN miss_times_perf
  ELSE NULL
  END AS miss_times_perf_calc_prod_diff,
 sales_qty_asis,
 plan_sales_pieces AS plan_sales_qty,
 piece_performance AS piece_perf_asis,
 plan_piece_performance AS plan_perf_piece,
 avg_item_price AS item_price_asis
FROM ldl_p_lew_mart_msi.v_bo_base_performance_list_1
WHERE is_daily_level_row = 1
 AND cal_dt <= used_closing_dt;