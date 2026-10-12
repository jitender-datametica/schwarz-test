/*
  Story      : https://jira.schwarz/browse/REP4-9791
  
  Description: Schnittstellenview Cube-Beladung BO

  Source
    P_LEW_MART_MSI
      V_BO_BASE_PERFORMANCE_LIST_2

  History:
    2021-11-09  zied.nanaa_ext@mail.schwarz
    Script Teradata Migration from svn://l-as616.asp.lidl.net/ddl/lew/lew_mart_msi/lew_mart_msi_v_bo_performance_list_day.sql


  Comments from the original Teradata DDL:
  Created by Jens Thole
  on 14.06.2018
  Inhalt: finale Zielstruktur der Tagesebenen-Schnittstelle der BO_PERORMANCE_LIST
  Quellen: MART_MSI:t_bo_base_performance_list_2 (alleinige Basisstruktur)
  Es erfolgt eine_2 Standardeinschränkung auf Datensätze unterhalb des jeweiligen Store-closing-Datums.
  relevante Measure-Values werden ermittelt. Es findet kein Ranking statt.
  Granularität (Gewinnerstore, Tag_2) - keine weitere Verdichtung

*/


CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_BO_PERFORMANCE_LIST_DAY_2 COMMENT = 'Schnittstellenview Cube-Beladung BO; Performancelist DAY'
(
    client_id                       COMMENT 'DWH-Client im DWH = LIDL-Land_2 (country_2)'
  , country_id                      COMMENT '= client_id'
  , country_desc                    COMMENT 'AUS MART_MSI.v_ref_country_act_bo_2 (letztlich aus CORE:t_wawi_ref_country_act_2 - für mehrsprachige Ländernamen)'
  , country_iso_cd                  COMMENT 'AUS MART_MSI.v_ref_country_act_bo_2 (letztlich aus CORE:t_wawi_ref_country_act_2 - für mehrsprachige Ländernamen)'
  , store_id                        COMMENT 'DWHKey des Stores aus Join mit #X_LEW_BIL#.v_store_2 über #X_LEW_BIL#.v_store_relocation. Angezeigt wird der GewinnerStore bei Fusionen - nicht der untergegangene OriginalStore der Fakten'
  , orig_store_nr                   COMMENT 'NaturalKey des Stores aus Join mit #X_LEW_BIL#.v_store_2 über #X_LEW_BIL#.v_store_relocation. Angezeigt wird der GewinnerStore bei Fusionen - nicht der untergegangene OriginalStore der Fakten'
  , store_desc                      COMMENT 'Benutzt wird loc_name2 vor loc_name (used_store_desc) aus #X_LEW_BIL#.v_store_2 -> letztlich aus Core:t_location_2'
  , city                            COMMENT 'AUS CORE.t_address_2'
  , wh_id                           COMMENT 'NaturalKey (src_wh_id) des dem Store (Gewinnerstore! - siehe loc_sid_store) über die Hauptlieferbeziehung zugeordneten Warehouse (aus BIL:v_store_to_warehouse_lastknown_2)'
  , wh_desc                         COMMENT 'Benutzt wird loc_name2 vor loc_name (used_wh_desc) aus CORE:t_location_2 über die dem Store (Gewinnerstore! - siehe loc_sid_store) in der Hauptlieferbeziehung zugeordneten Warehouse (aus BIL:v_store_to_warehouse_lastknown_2)'
  , sales_manager_id                COMMENT 'AUS BIL:v_location_organization_2'
  , sales_manager_name              COMMENT 'AUS BIL:v_location_organization_2'
  , account_manager_id              COMMENT 'AUS BIL:v_location_organization_2'
  , account_manager_name            COMMENT 'AUS BIL:v_location_organization_2'
  , dat_calendar                    COMMENT 'MART_MSI:v_bo_perf_cal_list_day_2: Fakten-Kalendertag'
  , cy_week                         COMMENT 'MART_MSI:v_bo_perf_cal_list_day_2: Woche_2 zum Fakten-Kalendertag'
  , currency_iso_cd                 COMMENT 'AUS CORE:v_client_2'
  , plan_val_turnover               COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover'
  , plan_val_turnover_net           COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover (kein Schreibfehler!)'
  , plan_val_hours                  COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_hours'
  , plan_val_inv_training           COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.(val_inventory + val_training)'
  , val_retail_asis                 COMMENT 'CORE:v_agg_sales_store_day.val_retail'
  , val_retail_net_asis             COMMENT 'CORE:v_agg_sales_store_day.val_retail_net'
  , cnt_customer_asis               COMMENT 'CORE:v_agg_sales_store_day.cnt_customer'
  , time_working_netto_std          COMMENT 'CORE:v_wawi_agg_wt_store_day_asis.time_working_netto_hrs'
  , miss_times_perf                 COMMENT 'CORE:v_wawi_agg_wt_store_day_asis.perf_rel_absence_hrs'
  , diff_val_retail_pct             COMMENT 'MART_MSI:t_bo_base_performance_list_2: Formel: 100*(val_retail-plan_val_turnover) / plan_val_turnover'
  , diff_val_retail_net_pct         COMMENT 'MART_MSI:t_bo_base_performance_list_2: Formel: 100*(val_retail_net-plan_val_turnover_net) / plan_val_turnover_net (wobei aktuell plan_val_turnover=plan_val_turnover_net)'
  , diff_sales_qty_asis_pct         COMMENT 'Unterschied zwischen Plan-Abverkaufe und IST-Abverkaufe in %'
  , diff_piece_perf_asis_pct        COMMENT 'Unterschied zwischen Stückleistung (Plan) und Stückleistung (IST) in %'
  , diff_hours                      COMMENT 'MART_MSI:t_bo_base_performance_list_2: Formel: time_working_netto_std + miss_times_perf - plan_val_hours. Realstunden(Arbeit+Schulung)-Planstunden'
  , plan_productivity               COMMENT 'MART_MSI:t_bo_base_performance_list_2: Formel: plan_val_turnover / plan_val_hours'
  , plan_productivity_net           COMMENT 'MART_MSI:t_bo_base_performance_list_2: Formel: plan_val_turnover_net / plan_val_hours (wobei aktuell plan_val_turnover=plan_val_turnover_net)'
  , act_productivity                COMMENT 'MART_MSI:t_bo_base_performance_list_2: Formel: val_retail / (time_working_netto_std + miss_times_perf)'
  , act_productivity_net            COMMENT 'MART_MSI:t_bo_base_performance_list_2: Formel: val_retail_net / (time_working_netto_std + miss_times_perf)'
  , max_umsdate                     COMMENT ''
  , max_hrsdate                     COMMENT ''
  , plan_turnover_calc_ums_diff     COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover; Wertausweis nur bis zum Maximalen Umsatztag der Tagesauswahl pro Store!'
  , plan_turnover_calc_ums_dif_net  COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover (kein Schreibfehler!); Wertausweis nur bis zum Maximalen Umsatztag der Tagesauswahl pro Store!'
  , plan_turnover_calc_prod_diff    COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover; Wertausweis nur bis zum früheren Tag_2 aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der Tagesauswahl pro Store!'
  , plan_turnover_calc_pro_dif_net  COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover (kein Schreibfehler!); Wertausweis nur bis zum früheren Tag_2 aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der Tagesauswahl pro Store!'
  , plan_sales_qty_calc_abv_diff    COMMENT 'MART_MSI:t_bo_base_performance_list.plan_sales_pieces; Wertausweis nur bis zum Maximalen Umsatztag der Tagesauswahl pro Store!'
  , plan_sales_qty_calc_prod_diff   COMMENT 'MART_MSI:t_bo_base_performance_list.plan_sales_pieces; Wertausweis nur bis zum Maximalen Umsatztag der Tagesauswahl pro Store!'
  , plan_hours_calc_hrs_diff        COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_hours; Wertausweis nur bis zum Maximalen Umsatztag der Tagesauswahl pro Store!'
  , plan_hours_calc_prod_diff       COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_hours; Wertausweis nur bis zum früheren Tag_2 aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der Tagesauswahl pro Store!'
  , val_retail_calc_prod_diff       COMMENT 'CORE:v_agg_sales_store_day.val_retail; Wertausweis nur bis zum früheren Tag_2 aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der Tagesauswahl pro Store!'
  , val_retail_calc_prod_diff_net   COMMENT 'CORE:v_agg_sales_store_day.val_retail_net; Wertausweis nur bis zum früheren Tag_2 aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der Tagesauswahl pro Store!'
  , hrs_calc_prod_diff              COMMENT 'CORE:v_wawi_agg_wt_store_day_asis.time_working_netto_hrs; Wertausweis nur bis zum früheren Tag_2 aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der Tagesauswahl pro Store!'
  , miss_times_perf_calc_prod_diff  COMMENT 'CORE:v_wawi_agg_wt_store_day_asis.perf_rel_absence_hrs; Wertausweis nur bis zum früheren Tag_2 aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der Tagesauswahl pro Store!'
  , sales_qty_asis                  COMMENT 'Abverkaufte Stück/Kg IST'
  , plan_sales_qty                  COMMENT 'Plan Abverkaufte Stück/Kg'
  , piece_perf_asis                 COMMENT 'Stückleistung IST'
  , plan_perf_piece                 COMMENT 'Plan Stückleistung'
  , item_price_asis                 COMMENT 'Durchschnittliche Artikelpreis IST'
)

AS

SELECT
    client_id
  , country_id
  , country_desc
  , country_iso_cd
  , loc_sid_store                                                                                           AS store_id
  , orig_store_nr
  , used_store_desc                                                                                         AS store_desc
  , city
  , src_wh_id                                                                                               AS wh_id
  , used_wh_desc                                                                                            AS wh_desc
  , sales_manager_id
  , sales_manager_name
  , account_manager_id
  , account_manager_name
  , cal_dt                                                                                                  AS dat_calendar
  , cy_week
  , curr_cd                                                                                                 AS currency_iso_cd
  , plan_val_turnover                                                                                       AS plan_val_turnover
  , plan_val_turnover_net                                                                                   AS plan_val_turnover_net
  , plan_val_hours                                                                                          AS plan_val_hours
  , plan_val_inv_training                                                                                   AS plan_val_inv_training
  , val_retail                                                                                              AS val_retail_asis
  , val_retail_net                                                                                          AS val_retail_net_asis
  , cnt_customer                                                                                            AS cnt_customer_asis
  , time_working_netto_std                                                                                  AS time_working_netto_std
  , miss_times_perf                                                                                         AS miss_times_perf
  , (val_retail            - plan_val_turnover)     / NULLIFZERO(plan_val_turnover    ) * 100               AS diff_val_retail_pct
  , (val_retail_net        - plan_val_turnover_net) / NULLIFZERO(plan_val_turnover_net) * 100               AS diff_val_retail_net_pct
  , (sales_qty_asis        - plan_sales_pieces)      / NULLIFZERO(plan_sales_pieces     ) * 100             AS diff_sales_qty_asis_pct
  , (piece_performance     - plan_piece_performance) / NULLIFZERO(plan_piece_performance) * 100             AS diff_piece_perf_asis_pct
  , time_working_netto_std - plan_val_hours                                                                 AS diff_hours
  , plan_val_turnover      / NULLIFZERO(plan_val_hours)                                                     AS plan_productivity
  , plan_val_turnover_net  / NULLIFZERO(plan_val_hours)                                                     AS plan_productivity_net
  , val_retail             / NULLIFZERO(time_working_netto_std)                                             AS act_productivity
  , val_retail_net         / NULLIFZERO(time_working_netto_std)                                             AS act_productivity_net
  , MAX(CASE WHEN val_retail             > 0 THEN cal_dt END) OVER (PARTITION BY client_id, loc_sid_store)  AS max_umsdate
  , MAX(CASE WHEN time_working_netto_std > 0 THEN cal_dt END) OVER (PARTITION BY client_id, loc_sid_store)  AS max_hrsdate
  , CASE WHEN cal_dt <= max_umsdate                          THEN plan_val_turnover         END             AS plan_turnover_calc_ums_diff
  , CASE WHEN cal_dt <= max_umsdate                          THEN plan_val_turnover_net     END             AS plan_turnover_calc_ums_dif_net
  , CASE WHEN cal_dt <= max_umsdate AND cal_dt<= max_hrsdate THEN plan_val_turnover         END             AS plan_turnover_calc_prod_diff
  , CASE WHEN cal_dt <= max_umsdate AND cal_dt<= max_hrsdate THEN plan_val_turnover_net     END             AS plan_turnover_calc_pro_dif_net
--, CASE WHEN cal_dt <= max_umsdate                          THEN plan_sales_qty            END             AS plan_sales_qty_calc_abv_diff
  , CASE WHEN cal_dt <= max_umsdate                          THEN plan_sales_pieces         END             AS plan_sales_qty_calc_abv_diff
--, CASE WHEN cal_dt <= max_umsdate AND cal_dt<= max_hrsdate THEN plan_sales_qty            END             AS plan_sales_qty_calc_prod_diff
  , CASE WHEN cal_dt <= max_umsdate AND cal_dt<= max_hrsdate THEN plan_sales_pieces         END             AS plan_sales_qty_calc_prod_diff
  , CASE WHEN cal_dt <= max_hrsdate                          THEN plan_val_hours            END             AS plan_hours_calc_hrs_diff
  , CASE WHEN cal_dt <= max_umsdate AND cal_dt<= max_hrsdate THEN plan_val_hours            END             AS plan_hours_calc_prod_diff
  , CASE WHEN cal_dt <= max_umsdate AND cal_dt<= max_hrsdate THEN val_retail                END             AS val_retail_calc_prod_diff
  , CASE WHEN cal_dt <= max_umsdate AND cal_dt<= max_hrsdate THEN val_retail_net            END             AS val_retail_calc_prod_diff_net
  , CASE WHEN cal_dt <= max_umsdate AND cal_dt<= max_hrsdate THEN time_working_netto_std    END             AS hrs_calc_prod_diff
  , CASE WHEN cal_dt <= max_umsdate AND cal_dt<= max_hrsdate THEN miss_times_perf           END             AS miss_times_perf_calc_prod_diff
  , sales_qty_asis                                                                                          AS sales_qty_asis
  , plan_sales_pieces                                                                                       AS plan_sales_qty
  , piece_performance                                                                                       AS piece_perf_asis
  , plan_piece_performance                                                                                  AS plan_perf_piece
  , avg_item_price                                                                                          AS item_price_asis
FROM 
  P_LEW_MART_MSI.V_BO_BASE_PERFORMANCE_LIST_2
WHERE 
  is_daily_level_row = 1 
  AND 
  cal_dt  <= used_closing_dt
;