/*
  Story     : https://jira.schwarz/browse/REP4-9791
  Target    : P_LEW_MART_MSI_AC.V_BO_PERFORMANCE_LIST_MTH
  Source    : P_LEW_MART_MSI.V_BO_PERFORMANCE_LIST_MTH
  Logic     : Keine. 1:1 Mapping from Source

  History:
    2021-11-11  zied.nanaa_ext@mail.schwarz     Script Teradata Migration from svn://l-as616.asp.lidl.net/ddl/lew/lew_mart_msi_ac/lew_mart_msi_ac_v_bo_performance_list_mth.sql 
    2022-08-23  Marcin Malec                    Stueckleistung part 2 / SPEC0165308 - Adding columns sales_pieces_ber, sales_pieces_py.
*/

CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_BO_PERFORMANCE_LIST_MTH COMMENT = 'Schnittstellenview Cube-Beladung BO. Performancelist Month'
(
    client_id                       COMMENT 'DWH-Client im DWH = LIDL-Land (country)'
  , country_desc                    COMMENT 'AUS MART_MSI.v_ref_country_act_bo (letztlich aus CORE:t_wawi_ref_country_act - für mehrsprachige Ländernamen)'
  , country_id                      COMMENT '= client_id'
  , country_iso_cd                  COMMENT 'AUS MART_MSI.v_ref_country_act_bo (letztlich aus CORE:t_wawi_ref_country_act - für mehrsprachige Ländernamen)'
  , store_id                        COMMENT 'DWHKey des Stores aus Join mit #X_LEW_BIL#.v_store über #X_LEW_BIL#.v_store_relocation. Angezeigt wird der GewinnerStore bei Fusionen - nicht der untergegangene OriginalStore der Fakten'
  , orig_store_nr                   COMMENT 'NaturalKey des Stores aus Join mit #X_LEW_BIL#.v_store über #X_LEW_BIL#.v_store_relocation. Angezeigt wird der GewinnerStore bei Fusionen - nicht der untergegangene OriginalStore der Fakten'
  , store_desc                      COMMENT 'Benutzt wird loc_name2 vor loc_name (used_store_desc) aus #X_LEW_BIL#.v_store -> letztlich aus Core:t_location'
  , city                            COMMENT 'AUS CORE.t_address'
  , wh_id                           COMMENT 'NaturalKey (src_wh_id) des dem Store (Gewinnerstore! - siehe loc_sid_store) über die Hauptlieferbeziehung zugeordneten Warehouse (aus BIL:v_store_to_warehouse_lastknown)'
  , wh_desc                         COMMENT 'Benutzt wird loc_name2 vor loc_name (used_wh_desc) aus CORE:t_location über die dem Store (Gewinnerstore! - siehe loc_sid_store) in der Hauptlieferbeziehung zugeordneten Warehouse (aus BIL:v_store_to_warehouse_lastknown)'
  , sales_manager_id                COMMENT 'AUS BIL:v_location_organization'
  , sales_manager_name              COMMENT 'AUS BIL:v_location_organization'
  , account_manager_id              COMMENT 'AUS BIL:v_location_organization'
  , account_manager_name            COMMENT 'AUS BIL:v_location_organization'
  , week_page_by                    COMMENT 'Wochenseite (für Reporting): Jede Reportingwoche, klammert die 12 der RepWoche vorangehenden Datenwochen (sofern in der Grundauswahl verfügbar)'
  , cy_month                        COMMENT 'Monat zum Fakten-Kalendertag'
  , currency_iso_cd                 COMMENT 'AUS CORE:v_client'
  , plan_val_turnover               COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover'
  , plan_val_turnover_net           COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover (kein Schreibfehler!)'
  , plan_val_turnover_py            COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover. Vorjahresauswahl über die der ReportWoche (week_page) zugeordneten Intervallgrenzen aus MART_MSI:v_bo_perf_cal_list_mth'
  , plan_val_turnover_net_py        COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover. Vorjahresauswahl über die der ReportWoche (week_page) zugeordneten Intervallgrenzen aus MART_MSI:v_bo_perf_cal_list_mth'
  , plan_turnover_calc_ums_diff     COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover. Monatssumme nur bis zum Maximalen Umsatztag der RepWoche!'
  , plan_turnover_calc_ums_dif_net  COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover (kein Schreibfehler!). Monatssumme nur bis zum Maximalen Umsatztag der RepWoche!'
  , plan_turnover_calc_prod_diff    COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover. Monatssumme nur bis zum früheren Tag aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der RepWoche!'
  , plan_turnover_calc_pro_dif_net  COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover (kein Schreibfehler!). Monatssumme nur bis zum früheren Tag aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der RepWoche!'
  , plan_sales_qty_calc_abv_diff    COMMENT 'MART_MSI:t_bo_base_performance_list.plan_sales_pieces. Wertausweis nur bis zum Maximalen Umsatztag der Tagesauswahl pro Store!'
  , plan_sales_qty_calc_prod_diff   COMMENT 'MART_MSI:t_bo_base_performance_list.plan_sales_pieces. Wertausweis nur bis zum Maximalen Umsatztag der Tagesauswahl pro Store!'
  , plan_hours_calc_hrs_diff        COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_hours. Monatssumme nur bis zum Maximalen Umsatztag der RepWoche!'
  , plan_hours_calc_prod_diff       COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_hours. Monatssumme nur bis zum früheren Tag aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der RepWoche!'
  , plan_val_hours                  COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_hours'
  , plan_val_hours_py               COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_hours; Vorjahresauswahl über die der ReportWoche (week_page) zugeordneten Intervallgrenzen aus MART_MSI:v_bo_perf_cal_list_mth'
  , plan_val_inv_training           COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.(val_inventory + val_training)'
  , plan_val_inv_training_py        COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.(val_inventory + val_training). Vorjahresauswahl über die der ReportWoche (week_page) zugeordneten Intervallgrenzen aus MART_MSI:v_bo_perf_cal_list_mth'
  , val_retail_asis                 COMMENT 'CORE:v_agg_sales_store_day.val_retail'
  , val_retail_net_asis             COMMENT 'CORE:v_agg_sales_store_day.val_retail_net'
  , val_retail_ber                  COMMENT 'identisch zu Feld val_retail_asis (Siehe View-Kopfkommentar im Quelltext)'
  , val_retail_net_ber              COMMENT 'identisch zu Feld val_retail_net_asis (Siehe View-Kopfkommentar im Quelltext)'
  , val_retail_asis_py              COMMENT 'CORE:v_agg_sales_store_day.val_retail. Vorjahresauswahl über die der ReportWoche (week_page) zugeordneten Intervallgrenzen aus MART_MSI:v_bo_perf_cal_list_mth'
  , val_retail_net_asis_py          COMMENT 'CORE:v_agg_sales_store_day.val_retail_net. Vorjahresauswahl über die der ReportWoche (week_page) zugeordneten Intervallgrenzen aus MART_MSI:v_bo_perf_cal_list_mth'
  , val_retail_calc_prod_diff       COMMENT 'CORE:v_agg_sales_store_day.val_retail. Monatssumme nur bis zum früheren Tag aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der RepWoche!'
  , val_retail_calc_prod_diff_net   COMMENT 'CORE:v_agg_sales_store_day.val_retail_net. Monatssumme nur bis zum früheren Tag aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der RepWoche!'
  , val_retail_calc_prod_diff_py    COMMENT 'CORE:v_agg_sales_store_day.val_retail (PY). Monatssumme nur bis zum früheren Tag (nach Time-Shift) aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der RepWoche!'
  , val_rtl_calc_prod_dif_net_py    COMMENT 'CORE:v_agg_sales_store_day.val_retail_net (PY). Monatssumme nur bis zum früheren Tag (nach Time-Shift) aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der RepWoche!'
  , cnt_customer_asis               COMMENT 'CORE:v_agg_sales_store_day.cnt_customer'
  , cnt_customer_ber                COMMENT ''
  , cnt_customer_asis_py            COMMENT 'CORE:v_agg_sales_store_day.cnt_customer. Vorjahresauswahl über die der ReportWoche (week_page) zugeordneten Intervallgrenzen aus MART_MSI:v_bo_perf_cal_list_mth'
  , sales_pieces_ber                COMMENT 'Identisch zu Feld sales_qty_asis (Siehe View-Kopfkommentar im Quelltext)'
  , sales_pieces_py                 COMMENT 'CORE:v_agg_sales_store_day.sales_qty_asis. Vorjahresauswahl über die der ReportWoche (week_page) zugeordneten Intervallgrenzen aus MART_MSI:v_bo_perf_cal_list_mth'
  , time_working_netto_std          COMMENT 'CORE:v_wawi_agg_wt_store_day_asis.time_working_netto_hrs'
  , time_working_netto_std_py       COMMENT 'CORE:v_wawi_agg_wt_store_day_asis.time_working_netto_hrs. Vorjahresauswahl über die der ReportWoche (week_page) zugeordneten Intervallgrenzen aus MART_MSI:v_bo_perf_cal_list_mth'
  , miss_times_perf                 COMMENT 'CORE:v_wawi_agg_wt_store_day_asis.perf_rel_absence_hrs'
  , miss_times_perf_py              COMMENT 'CORE:v_wawi_agg_wt_store_day_asis.perf_rel_absence_hrs. Vorjahresauswahl über die der ReportWoche (week_page) zugeordneten Intervallgrenzen aus MART_MSI:v_bo_perf_cal_list_mth'
  , hrs_calc_prod_diff              COMMENT 'CORE:v_wawi_agg_wt_store_day_asis.time_working_netto_hrs. Monatssumme nur bis zum früheren Tag aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der RepWoche!'
  , hrs_calc_prod_diff_py           COMMENT 'CORE:v_wawi_agg_wt_store_day_asis.time_working_netto_hrs (PY). Monatssumme nur bis zum früheren Tag (nach Time-Shift) aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der RepWoche!'
  , miss_times_perf_calc_prod_diff  COMMENT 'CORE:v_wawi_agg_wt_store_day_asis.perf_rel_absence_hrs. Monatssumme nur bis zum früheren Tag aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der RepWoche!'
  , miss_times_p_calc_prod_diff_py  COMMENT 'CORE:v_wawi_agg_wt_store_day_asis.perf_rel_absence_hrs (PY). Monatssumme nur bis zum früheren Tag (nach Time-Shift) aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der RepWoche!'
  , diff_hours                      COMMENT 'MART_MSI:t_bo_base_performance_list: Formel: time_working_netto_std + miss_times_perf - plan_val_hours. Realstunden(Arbeit+Schulung)-Planstunden'
  , sales_qty_asis                  COMMENT 'Abverkaufte Stück/Kg IST'
  , sales_qty_py                    COMMENT 'Abverkaufte Stück ist Vorjahr'
  , plan_sales_qty                  COMMENT 'Plan Abverkaufte Stück/Kg'
  , piece_perf_asis                 COMMENT 'Stückleistung IST'
  , piece_perf_py                   COMMENT 'Stückleistung IST Vergangenes Jahr'
  , plan_perf_piece                 COMMENT 'Plan Stückleistung'
  , item_price_asis                 COMMENT 'Durschnittliche Artikelpreis Ist'
  , diff_sales_qty_asis_pct         COMMENT 'Unterschied zwischen Plan-Abverkaufe und IST-Abverkaufe in %'
  , diff_piece_perf_asis_pct        COMMENT 'Unterschied zwischen Stückleistung (Plan) und Stückleistung (IST) in %'
  , diff_py_val_piece_perf          COMMENT 'Unterschied zum Vorjahr Stückleistung'
  , top_20_val_retail_productivity  COMMENT 'Warehouse-Monatssumme val_retail_asis der Ranking (Feld rnk_prod) top-20-platzierten  Stores. (Verborgene Rankingfelder im Code-Kopfkommentar erläutert)'
  , top20_val_rtl_net_productivity  COMMENT 'Warehouse-Monatssumme val_retail_net_asis der nach Ranking (Feld rnk_net_prod) top-20-platzierten Stores. (Verborgene Rankingfelder im Code-Kopfkommentar erläutert)'
  , top_20_time_wrk_productivity    COMMENT 'Warehouse-Monatssumme time_working_netto_std der nach Ranking (Feld rnk_prod) top-20-platzierten Stores. (Verborgene Rankingfelder im Code-Kopfkommentar erläutert)'
  , top20_time_wrk_prod_net         COMMENT 'Warehouse-Monatssumme time_working_netto_std der nach Ranking (Feld rnk_net_prod) top-20-platzierten Stores. (Verborgene Rankingfelder im Code-Kopfkommentar erläutert)'
  , top_20_miss_times_perf_prod     COMMENT 'Warehouse-Monatssumme miss_times_perf (Schulungsstunden) der nach Ranking (Feld rnk_prod) top-20-platzierten Stores. (Verborgene Rankingfelder im Code-Kopfkommentar erläutert)'
  , top20_miss_times_perf_prod_net  COMMENT 'Warehouse-Monatssumme miss_times_perf (Schulungsstunden) der nach Ranking (Feld rnk_net_prod) top-20-platzierten Stores. (Verborgene Rankingfelder im Code-Kopfkommentar erläutert)'
  , top_20_val_retail_for_diff      COMMENT 'Warehouse-Monatssumme val_retail_asis (Umsatz) der nach Ranking (Feld rnk_diff_py_val_retail_pct) top-20-platzierten Stores. (Verborgene Rankingfelder im Code-Kopfkommentar erläutert)'
  , top_20_val_retail_net_for_diff  COMMENT 'Warehouse-Monatssumme val_retail_net_asis (Netto-Umsatz) der nach Ranking (Feld rnk_diff_py_val_retail_net_pct) top-20-platzierten Stores. (Verborgene Rankingfelder im Code-Kopfkommentar erläutert)'
  , top_20_val_retail_for_diff_py   COMMENT 'Warehouse-Monatssumme val_retail_asis_py (PY:Netto-Umsatz) der nach Ranking (Feld rnk_diff_py_val_retail_pct) top-20-platzierten Stores. (Verborgene Rankingfelder im Code-Kopfkommentar erläutert)'
  , top20_val_rtl_net_for_diff_py   COMMENT 'Warehouse-Monatssumme val_retail_net_asis_py (PY:Netto-Umsatz) der nach Ranking (Feld rnk_diff_py_val_retail_net_pct) top-20-platzierten Stores. (Verborgene Rankingfelder im Code-Kopfkommentar erläutert)'
  , top_20_val_ret_for_incr_adj     COMMENT 'Warehouse-Monatssumme val_retail_asis (Umsatz) der nach Ranking (Feld rnk_val_retail_incr_adj) top-20-platzierten Stores. (Verborgene Rankingfelder im Code-Kopfkommentar erläutert)'
  , top20_val_rtl_net_for_incr_adj  COMMENT 'Warehouse-Monatssumme val_retail_net_asis_py (PY:Netto-Umsatz) der nach Ranking (Feld rnk_val_retail_net_incr_adj) top-20-platzierten Stores. (Verborgene Rankingfelder im Code-Kopfkommentar erläutert)'
  , top_20_val_ret_py_for_incr_adj  COMMENT 'Warehouse-Monatssumme val_retail_net_asis (Netto-Umsatz) der nach Ranking (Feld rnk_val_retail_net_incr_adj) top-20-platzierten Stores. (Verborgene Rankingfelder im Code-Kopfkommentar erläutert)'
  , top20_val_rtl_net_py_incr_adj   COMMENT 'Warehouse-Monatssumme val_retail_asis_py (PY:Netto-Umsatz) der nach Ranking (Feld rnk_val_retail_incr_adj) top-20-platzierten Stores. (Verborgene Rankingfelder im Code-Kopfkommentar erläutert)'
  , top_20_sales_qty_piece_perf     COMMENT 'Warehouse-Monatssumme sales_qty_asis der Ranking (Feld rnk_piece_perf) top-20-platzierten Stores'
  , top_20_time_wrk_piece_perf      COMMENT 'Warehouse-Monatssumme time_working_netto_std der Ranking (Feld rnk_piece_perf) top-20-platzierten Stores'
  , top_20_miss_times_piece_perf    COMMENT 'Warehouse-Monatssumme miss_times_perf der Ranking (Feld rnk_piece_perf) top-20-platzierten Stores'
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
  , week_page_by
  , cy_month
  , currency_iso_cd
  , plan_val_turnover
  , plan_val_turnover_net
  , plan_val_turnover_py
  , plan_val_turnover_net_py
  , plan_turnover_calc_ums_diff
  , plan_turnover_calc_ums_dif_net
  , plan_turnover_calc_prod_diff
  , plan_turnover_calc_pro_dif_net
  , plan_sales_qty_calc_abv_diff
  , plan_sales_qty_calc_prod_diff
  , plan_hours_calc_hrs_diff
  , plan_hours_calc_prod_diff
  , plan_val_hours
  , plan_val_hours_py
  , plan_val_inv_training
  , plan_val_inv_training_py
  , val_retail_asis
  , val_retail_net_asis
  , val_retail_ber
  , val_retail_net_ber
  , val_retail_asis_py
  , val_retail_net_asis_py
  , val_retail_calc_prod_diff
  , val_retail_calc_prod_diff_net
  , val_retail_calc_prod_diff_py
  , val_rtl_calc_prod_dif_net_py
  , cnt_customer_asis
  , cnt_customer_ber
  , cnt_customer_asis_py
  , sales_pieces_ber
  , sales_pieces_py
  , time_working_netto_std
  , time_working_netto_std_py
  , miss_times_perf
  , miss_times_perf_py
  , hrs_calc_prod_diff
  , hrs_calc_prod_diff_py
  , miss_times_perf_calc_prod_diff
  , miss_times_p_calc_prod_diff_py
  , diff_hours
  , sales_qty_asis
  , sales_qty_py
  , plan_sales_qty
  , piece_perf_asis
  , piece_perf_py
  , plan_perf_piece
  , item_price_asis
  , diff_sales_qty_asis_pct
  , diff_piece_perf_asis_pct
  , diff_py_val_piece_perf
  , top_20_val_retail_productivity
  , top20_val_rtl_net_productivity
  , top_20_time_wrk_productivity
  , top20_time_wrk_prod_net
  , top_20_miss_times_perf_prod
  , top20_miss_times_perf_prod_net
  , top_20_val_retail_for_diff
  , top_20_val_retail_net_for_diff
  , top_20_val_retail_for_diff_py
  , top20_val_rtl_net_for_diff_py
  , top_20_val_ret_for_incr_adj
  , top20_val_rtl_net_for_incr_adj
  , top_20_val_ret_py_for_incr_adj
  , top20_val_rtl_net_py_incr_adj
  , top_20_sales_qty_piece_perf
  , top_20_time_wrk_piece_perf
  , top_20_miss_times_piece_perf
FROM 
  P_LEW_MART_MSI.V_BO_PERFORMANCE_LIST_MTH
;