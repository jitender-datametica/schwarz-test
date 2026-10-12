/*
  Story     : https://jira.schwarz/browse/REP4-9791
  Target    : P_LEW_MART_MSI_AC.V_BO_PERFORMANCE_LIST_WEEK_1
  Source    : P_LEW_MART_MSI.V_BO_PERFORMANCE_LIST_WEEK_1
  Logic     : Keine. 1:1 Mapping from Source

  History:
    2021-11-11  zied.nanaa_ext@mail.schwarz     Script Teradata Migration from svn://l-as616.asp.lidl.net/ddl/lew/lew_mart_msi_ac/lew_mart_msi_ac_v_bo_performance_list_week.sql
    2022-08-23  Marcin Malec                    Stueckleistung part 2 / SPEC0165308 - Adding columns sales_pieces_ber, sales_pieces_py.
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_bo_performance_list_week_1 (client_id
OPTIONS(description='DWH-Client im DWH = LIDL-Land_1 (country_1)'), country_desc
OPTIONS(description='AUS MART_MSI.v_ref_country_act_bo_1 (letztlich aus CORE:t_wawi_ref_country_act_1 - für mehrsprachige Ländernamen)'),
country_id OPTIONS(description='= client_id'), country_iso_cd
OPTIONS(description='AUS MART_MSI.v_ref_country_act_bo_1 (letztlich aus CORE:t_wawi_ref_country_act_1 - für mehrsprachige Ländernamen)'),
store_id
OPTIONS(description='DWHKey des Stores aus CROSS JOIN mit #X_LEW_BIL#.v_store_1 über #X_LEW_BIL#.v_store_relocation. angezeigt wird der GewinnerStore bei Fusionen - nicht der untergegangene OriginalStore der Fakten'),
orig_store_nr
OPTIONS(description='NaturalKey des Stores aus CROSS JOIN mit #X_LEW_BIL#.v_store_1 über #X_LEW_BIL#.v_store_relocation. angezeigt wird der GewinnerStore bei Fusionen - nicht der untergegangene OriginalStore der Fakten'),
store_desc
OPTIONS(description='Benutzt wird loc_name2 vor loc_name (used_store_desc) aus #X_LEW_BIL#.v_store_1 -> letztlich aus Core:t_location_1'),
city OPTIONS(description='AUS CORE.t_address_1'), wh_id
OPTIONS(description='NaturalKey (src_wh_id) des dem Store (Gewinnerstore! - siehe loc_sid_store) über die Hauptlieferbeziehung zugeordneten Warehouse (aus BIL:v_store_to_warehouse_lastknown_1)'),
wh_desc
OPTIONS(description='Benutzt wird loc_name2 vor loc_name (used_wh_desc) aus CORE:t_location_1 über die dem Store (Gewinnerstore! - siehe loc_sid_store) in der Hauptlieferbeziehung zugeordneten Warehouse (aus BIL:v_store_to_warehouse_lastknown_1)'),
sales_manager_id OPTIONS(description='AUS BIL:v_location_organization_1'), sales_manager_name
OPTIONS(description='AUS BIL:v_location_organization_1'), account_manager_id
OPTIONS(description='AUS BIL:v_location_organization_1'), account_manager_name
OPTIONS(description='AUS BIL:v_location_organization_1'), cy_week
OPTIONS(description='MART_MSI:v_bo_perf_cal_list_day_1: Woche_1 zum Fakten-Kalendertag'), week_page_by
OPTIONS(description='Wochenseite (für Reporting): Jede Reportingwoche, klammert die 12 der RepWoche vorangehenden Datenwochen (sofern in der Grundauswahl verfügbar)'),
currency_iso_cd OPTIONS(description='AUS CORE:v_client_1'), plan_val_turnover
OPTIONS(description='CORE:v_wawi_ptm_plantimeday_wh.val_turnover'), plan_val_turnover_net
OPTIONS(description='CORE:v_wawi_ptm_plantimeday_wh.val_turnover (kein Schreibfehler!)'), plan_val_hours
OPTIONS(description='CORE:v_wawi_ptm_plantimeday_wh.val_hours'), plan_val_inv_training
OPTIONS(description='CORE:v_wawi_ptm_plantimeday_wh.(val_inventory + val_training)'), val_retail_asis
OPTIONS(description='CORE:v_agg_sales_store_day.val_retail'), val_retail_net_asis
OPTIONS(description='CORE:v_agg_sales_store_day.val_retail_net'), cnt_customer_asis
OPTIONS(description='CORE:v_agg_sales_store_day.cnt_customer'), val_retail_ber
OPTIONS(description='Identisch zu Feld val_retail_asis (Siehe View-Kopfkommentar im Quelltext)'), val_retail_net_ber
OPTIONS(description='Identisch zu Feld val_retail_net_asis (Siehe View-Kopfkommentar im Quelltext)'), cnt_customer_ber
OPTIONS(description='Identisch zu Feld cnt_customer_asis (Siehe View-Kopfkommentar im Quelltext)'), sales_pieces_ber
OPTIONS(description='Identisch zu Feld sales_qty_asis (Siehe View-Kopfkommentar im Quelltext)'), val_retail_py
OPTIONS(description='CORE:v_agg_sales_store_day.val_retail (Vorjahr). Über die Kalenderfunktion cal_dt_swday_prev_1y wird der jeweilige Tagesumsatz des Vorjahres ermittelt und auf den koorespondierenden AktJahr-Tag_1 verschoben'),
val_retail_net_py
OPTIONS(description='CORE:v_agg_sales_store_day.val_retail_net (Vorjahr). Über die Kalenderfunktion cal_dt_swday_prev_1y wird der jeweilige Tagesumsatz des Vorjahres ermittelt und auf den koorespondierenden AktJahr-Tag_1 verschoben'),
cnt_customer_py
OPTIONS(description='CORE:v_agg_sales_store_day.cnt_customer (Vorjahr). Über die Kalenderfunktion cal_dt_swday_prev_1y wird der jeweilige Tagesumsatz des Vorjahres ermittelt und auf den koorespondierenden AktJahr-Tag_1 verschoben'),
sales_pieces_py
OPTIONS(description='CORE:v_agg_sales_store_day.sales_qty_asis (Vorjahr). Über die Kalenderfunktion cal_dt_swday_prev_1y wird der jeweilige Tagesumsatz des Vorjahres ermittelt und auf den koorespondierenden AktJahr-Tag_1 verschoben'),
time_working_netto_std OPTIONS(description='CORE:v_wawi_agg_wt_store_day_asis.time_working_netto_hrs'), miss_times_perf
OPTIONS(description='CORE:v_wawi_agg_wt_store_day_asis.perf_rel_absence_hrs'), act_productivity
OPTIONS(description='MART_MSI:t_bo_base_performance_list_1: Formel: val_retail / (time_working_netto_std + miss_times_perf)'),
act_productivity_net
OPTIONS(description='MART_MSI:t_bo_base_performance_list_1: Formel: val_retail_net / (time_working_netto_std + miss_times_perf)'),
diff_val_retail_pct
OPTIONS(description='MART_MSI:t_bo_base_performance_list_1: Formel: 100*(val_retail-plan_val_turnover) / plan_val_turnover'),
diff_val_retail_net_pct
OPTIONS(description='MART_MSI:t_bo_base_performance_list_1: Formel: 100*(val_retail_net-plan_val_turnover_net) / plan_val_turnover_net (wobei aktuell plan_val_turnover=plan_val_turnover_net)'),
diff_sales_qty_asis_pct
OPTIONS(description='MART_MSI:t_bo_base_performance_list_1: Formel: (sales_qty_asis        - plan_sales_pieces)      / NULLIFZERO(plan_sales_pieces     ) * 100'),
diff_piece_perf_asis_pct
OPTIONS(description='MART_MSI:t_bo_base_performance_list_1: Formel: (piece_performance     - plan_piece_performance) / NULLIFZERO(plan_piece_performance) * 100'),
diff_hours
OPTIONS(description='MART_MSI:t_bo_base_performance_list_1: Formel: time_working_netto_std + miss_times_perf - plan_val_hours'),
sales_qty_asis OPTIONS(description='Abverkaufte Stück ist'), plan_sales_qty
OPTIONS(description='Plan Abverkaufte Stück'), piece_perf_asis OPTIONS(description='Plan Stückleistung ist'),
plan_perf_piece OPTIONS(description='Plan Stückleistung ist'), item_price_asis OPTIONS(description='Artikelpreis Ist'),
top_20_val_retail_productivity
OPTIONS(description='Warehouse-Wochensumme val_retail_asis der Ranking (Feld rnk_prod) top-20-platzierten  Stores'),
top20_val_rtl_net_productivity
OPTIONS(description='Warehouse-Wochensumme val_retail_net_asis der nach Ranking (Feld rnk_net_prod) top-20-platzierten Stores'),
top_20_time_wrk_productivity
OPTIONS(description='Warehouse-Wochensumme time_working_netto_std der nach Ranking (Feld rnk_prod) top-20-platzierten Stores'),
top20_time_wrk_prod_net
OPTIONS(description='Warehouse-Wochensumme time_working_netto_std der nach Ranking (Feld rnk_net_prod) top-20-platzierten Stores'),
top_20_miss_times_perf_prod
OPTIONS(description='Warehouse-Wochensumme miss_times_perf (Schulungsstunden) der nach Ranking (Feld rnk_prod) top-20-platzierten Stores'),
top20_miss_times_perf_prod_net
OPTIONS(description='Warehouse-Wochensumme miss_times_perf (Schulungsstunden) der nach Ranking (Feld rnk_net_prod) top-20-platzierten Stores'),
top_20_act_productivity
OPTIONS(description='Top20-Warehouse-Wochensumme=i.W. "T20WWS".  T20WWS(val_retail_asis) / (T20WWS(time_working_netto_std) + T20WWS(miss_times_perf))'),
top_20_act_productivity_net
OPTIONS(description='T20WWS(val_retail_net_asis) / (T20WWS(time_working_netto_std) + T20WWS(miss_times_perf))'),
top_20_sales_qty_piece_perf OPTIONS(description='T20WWS(sales_qty_asis)'), top_20_time_wrk_piece_perf
OPTIONS(description='T20WWS(time_working_netto_std)'), top_20_miss_times_piece_perf
OPTIONS(description='T20WWS(miss_times_perf)'), top_20_piece_perf
OPTIONS(description='T20WWS(sales_qty_asis) / (T20WWS(time_working_netto_std) + T20WWS(miss_times_perf))'), rnk_prod
OPTIONS(description='Ranking der Stores pro Warehouse-Woche_1 nach Produktivität (Feld act_productivity)'), rnk_net_prod
OPTIONS(description='Ranking der Stores pro Warehouse-Woche_1 nach Netto-Produktivität (Feld act_productivity_net)'),
rnk_piece_perf OPTIONS(description='Ranking der Stores pro Warehouse-Woche_1 nach Stückleistung (Feld piece_perf_asis)'))
OPTIONS(DESCRIPTION = `SCHNITTSTELLENVIEW CUBE-BELADUNG BO. PERFORMANCELIST WEEK`) AS SELECT client_id,
 country_desc,
 country_id,
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
 cy_week,
 week_page_by,
 currency_iso_cd,
 plan_val_turnover,
 plan_val_turnover_net,
 plan_val_hours,
 plan_val_inv_training,
 val_retail_asis,
 val_retail_net_asis,
 cnt_customer_asis,
 val_retail_ber,
 val_retail_net_ber,
 cnt_customer_ber,
 sales_pieces_ber,
 val_retail_py,
 val_retail_net_py,
 cnt_customer_py,
 sales_pieces_py,
 time_working_netto_std,
 miss_times_perf,
 act_productivity,
 act_productivity_net,
 diff_val_retail_pct,
 diff_val_retail_net_pct,
 diff_sales_qty_asis_pct,
 diff_piece_perf_asis_pct,
 diff_hours,
 sales_qty_asis,
 plan_sales_qty,
 piece_perf_asis,
 plan_perf_piece,
 item_price_asis,
 top_20_val_retail_productivity,
 top20_val_rtl_net_productivity,
 top_20_time_wrk_productivity,
 top20_time_wrk_prod_net,
 top_20_miss_times_perf_prod,
 top20_miss_times_perf_prod_net,
 top_20_act_productivity,
 top_20_act_productivity_net,
 top_20_sales_qty_piece_perf,
 top_20_time_wrk_piece_perf,
 top_20_miss_times_piece_perf,
 top_20_piece_perf,
 rnk_prod,
 rnk_net_prod,
 rnk_piece_perf
FROM ldl_p_lew_mart_msi.v_bo_performance_list_week_1;