/*
  Story     : https://jira.schwarz/browse/REP4-9791
  Target    : P_LEW_MART_MSI_AC.V_BO_PERFORMANCE_LIST_DAY_1
  Source    : P_LEW_MART_MSI.V_BO_PERFORMANCE_LIST_DAY_1
  Logic     : Keine. 1:1 Mapping from Source

  History:
    2021-11-11  zied.nanaa_ext@mail.schwarz
    Script Teradata Migration from svn://l-as616.asp.lidl.net/ddl/lew/lew_mart_msi_ac/lew_mart_msi_ac_v_bo_performance_list_day.sql 
*/

CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_BO_PERFORMANCE_LIST_DAY_1 COMMENT = 'Schnittstellenview Cube-Beladung BO; Performancelist DAY'
(
    client_id                       COMMENT 'DWH-Client im DWH = LIDL-Land_1 (country_1)'
  , country_id                      COMMENT '= client_id'
  , country_desc                    COMMENT 'AUS MART_MSI.v_ref_country_act_bo_1 (letztlich aus CORE:t_wawi_ref_country_act_1 - für mehrsprachige Ländernamen)'
  , country_iso_cd                  COMMENT 'AUS MART_MSI.v_ref_country_act_bo_1 (letztlich aus CORE:t_wawi_ref_country_act_1 - für mehrsprachige Ländernamen)'
  , store_id                        COMMENT 'DWHKey des Stores aus Join mit #X_LEW_BIL#.v_store_1 über #X_LEW_BIL#.v_store_relocation. Angezeigt wird der GewinnerStore bei Fusionen - nicht der untergegangene OriginalStore der Fakten'
  , orig_store_nr                   COMMENT 'NaturalKey des Stores aus Join mit #X_LEW_BIL#.v_store_1 über #X_LEW_BIL#.v_store_relocation. Angezeigt wird der GewinnerStore bei Fusionen - nicht der untergegangene OriginalStore der Fakten'
  , store_desc                      COMMENT 'Benutzt wird loc_name2 vor loc_name (used_store_desc) aus #X_LEW_BIL#.v_store_1 -> letztlich aus Core:t_location_1'
  , city                            COMMENT 'AUS CORE.t_address_1'
  , wh_id                           COMMENT 'NaturalKey (src_wh_id) des dem Store (Gewinnerstore! - siehe loc_sid_store) über die Hauptlieferbeziehung zugeordneten Warehouse (aus BIL:v_store_to_warehouse_lastknown_1)'
  , wh_desc                         COMMENT 'Benutzt wird loc_name2 vor loc_name (used_wh_desc) aus CORE:t_location_1 über die dem Store (Gewinnerstore! - siehe loc_sid_store) in der Hauptlieferbeziehung zugeordneten Warehouse (aus BIL:v_store_to_warehouse_lastknown_1)'
  , sales_manager_id                COMMENT 'AUS BIL:v_location_organization_1'
  , sales_manager_name              COMMENT 'AUS BIL:v_location_organization_1'
  , account_manager_id              COMMENT 'AUS BIL:v_location_organization_1'
  , account_manager_name            COMMENT 'AUS BIL:v_location_organization_1'
  , dat_calendar                    COMMENT 'MART_MSI:v_bo_perf_cal_list_day_1: Fakten-Kalendertag'
  , cy_week                         COMMENT 'MART_MSI:v_bo_perf_cal_list_day_1: Woche_1 zum Fakten-Kalendertag'
  , currency_iso_cd                 COMMENT 'AUS CORE:v_client_1'
  , plan_val_turnover               COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover'
  , plan_val_turnover_net           COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover (kein Schreibfehler!)'
  , plan_val_hours                  COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_hours'
  , plan_val_inv_training           COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.(val_inventory + val_training)'
  , val_retail_asis                 COMMENT 'CORE:v_agg_sales_store_day.val_retail'
  , val_retail_net_asis             COMMENT 'CORE:v_agg_sales_store_day.val_retail_net'
  , cnt_customer_asis               COMMENT 'CORE:v_agg_sales_store_day.cnt_customer'
  , time_working_netto_std          COMMENT 'CORE:v_wawi_agg_wt_store_day_asis.time_working_netto_hrs'
  , miss_times_perf                 COMMENT 'CORE:v_wawi_agg_wt_store_day_asis.perf_rel_absence_hrs'
  , diff_val_retail_pct             COMMENT 'MART_MSI:t_bo_base_performance_list_1: Formel: 100*(val_retail-plan_val_turnover) / plan_val_turnover'
  , diff_val_retail_net_pct         COMMENT 'MART_MSI:t_bo_base_performance_list_1: Formel: 100*(val_retail_net-plan_val_turnover_net) / plan_val_turnover_net (wobei aktuell plan_val_turnover=plan_val_turnover_net)'
  , diff_sales_qty_asis_pct         COMMENT 'Unterschied zwischen Plan-Abverkaufe und IST-Abverkaufe in %'
  , diff_piece_perf_asis_pct        COMMENT 'Unterschied zwischen Stückleistung (Plan) und Stückleistung (IST) in %'
  , diff_hours                      COMMENT 'MART_MSI:t_bo_base_performance_list_1: Formel: time_working_netto_std + miss_times_perf - plan_val_hours. Realstunden(Arbeit+Schulung)-Planstunden'
  , plan_productivity               COMMENT 'MART_MSI:t_bo_base_performance_list_1: Formel: plan_val_turnover / plan_val_hours'
  , plan_productivity_net           COMMENT 'MART_MSI:t_bo_base_performance_list_1: Formel: plan_val_turnover_net / plan_val_hours (wobei aktuell plan_val_turnover=plan_val_turnover_net)'
  , act_productivity                COMMENT 'MART_MSI:t_bo_base_performance_list_1: Formel: val_retail / (time_working_netto_std + miss_times_perf)'
  , act_productivity_net            COMMENT 'MART_MSI:t_bo_base_performance_list_1: Formel: val_retail_net / (time_working_netto_std + miss_times_perf)'
  , max_umsdate                     COMMENT ''
  , max_hrsdate                     COMMENT ''
  , plan_turnover_calc_ums_diff     COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover; Wertausweis nur bis zum Maximalen Umsatztag der Tagesauswahl pro Store!'
  , plan_turnover_calc_ums_dif_net  COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover (kein Schreibfehler!); Wertausweis nur bis zum Maximalen Umsatztag der Tagesauswahl pro Store!'
  , plan_turnover_calc_prod_diff    COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover; Wertausweis nur bis zum früheren Tag_1 aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der Tagesauswahl pro Store!'
  , plan_turnover_calc_pro_dif_net  COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover (kein Schreibfehler!); Wertausweis nur bis zum früheren Tag_1 aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der Tagesauswahl pro Store!'
  , plan_sales_qty_calc_abv_diff    COMMENT 'MART_MSI:t_bo_base_performance_list.plan_sales_pieces; Wertausweis nur bis zum Maximalen Umsatztag der Tagesauswahl pro Store!'
  , plan_sales_qty_calc_prod_diff   COMMENT 'MART_MSI:t_bo_base_performance_list.plan_sales_pieces; Wertausweis nur bis zum Maximalen Umsatztag der Tagesauswahl pro Store!'
  , plan_hours_calc_hrs_diff        COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_hours; Wertausweis nur bis zum Maximalen Umsatztag der Tagesauswahl pro Store!'
  , plan_hours_calc_prod_diff       COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_hours; Wertausweis nur bis zum früheren Tag_1 aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der Tagesauswahl pro Store!'
  , val_retail_calc_prod_diff       COMMENT 'CORE:v_agg_sales_store_day.val_retail; Wertausweis nur bis zum früheren Tag_1 aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der Tagesauswahl pro Store!'
  , val_retail_calc_prod_diff_net   COMMENT 'CORE:v_agg_sales_store_day.val_retail_net; Wertausweis nur bis zum früheren Tag_1 aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der Tagesauswahl pro Store!'
  , hrs_calc_prod_diff              COMMENT 'CORE:v_wawi_agg_wt_store_day_asis.time_working_netto_hrs; Wertausweis nur bis zum früheren Tag_1 aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der Tagesauswahl pro Store!'
  , miss_times_perf_calc_prod_diff  COMMENT 'CORE:v_wawi_agg_wt_store_day_asis.perf_rel_absence_hrs; Wertausweis nur bis zum früheren Tag_1 aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der Tagesauswahl pro Store!'
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
  , val_retail_asis
  , val_retail_net_asis
  , cnt_customer_asis
  , time_working_netto_std
  , miss_times_perf
  , diff_val_retail_pct
  , diff_val_retail_net_pct
  , diff_sales_qty_asis_pct
  , diff_piece_perf_asis_pct
  , diff_hours
  , plan_productivity
  , plan_productivity_net
  , act_productivity
  , act_productivity_net
  , max_umsdate
  , max_hrsdate
  , plan_turnover_calc_ums_diff
  , plan_turnover_calc_ums_dif_net
  , plan_turnover_calc_prod_diff
  , plan_turnover_calc_pro_dif_net
  , plan_sales_qty_calc_abv_diff
  , plan_sales_qty_calc_prod_diff
  , plan_hours_calc_hrs_diff
  , plan_hours_calc_prod_diff
  , val_retail_calc_prod_diff
  , val_retail_calc_prod_diff_net
  , hrs_calc_prod_diff
  , miss_times_perf_calc_prod_diff
  , sales_qty_asis
  , plan_sales_qty
  , piece_perf_asis
  , plan_perf_piece
  , item_price_asis
FROM
  P_LEW_MART_MSI.V_BO_PERFORMANCE_LIST_DAY_1;