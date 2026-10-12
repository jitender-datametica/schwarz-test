/*
  Story     : https://jira.schwarz/browse/REP4-10237
  Database  : LDL_PRODUCTION_CLONE_LEAD_LEW_MART
  Target    : P_LEW_MART_MSI_AC.V_BO_STORE_OVERVIEW_MTH_1
  Source    : P_LEW_MART_MSI.V_BO_STORE_OVERVIEW_MTH_1
  Logic     : Keine. 1:1 Mapping from Source

  History:
    2021-11-04  zied.nanaa_ext@mail.schwarz     Script Teradata Migration from svn://l-as616.asp.lidl.net/ddl/lew/lew_mart_msi_ac/lew_mart_msi_ac_v_bo_store_overview_mth.sql
    2022-08-23  Marcin Malec                    Stueckleistung part 2 / SPEC0165308 - Adding columns sales_pieces_ber, sales_pieces_py.

*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_bo_store_overview_mth_1 (client_id
OPTIONS(description='DWH-Client im DWH = LIDL-Land_1 (country_1)'), country_desc
OPTIONS(description='AUS MART_MSI.v_ref_country_act_bo_1 (letztlich aus CORE:t_wawi_ref_country_act_1 - für mehrsprachige Ländernamen)'),
country_id OPTIONS(description='Wie client_id'), country_iso_cd
OPTIONS(description='AUS MART_MSI.v_ref_country_act_bo_1 (letztlich aus CORE:t_wawi_ref_country_act_1 - für mehrsprachige Ländernamen)'),
store_id
OPTIONS(description='DWHKey des Stores aus CROSS JOIN mit v_lew_bil.v_store_1 über v_lew_bil.v_store_relocation_1; angezeigt wird der GewinnerStore bei Fusionen - nicht der untergegangene OriginalStore der Fakten'),
orig_store_nr
OPTIONS(description='NaturalKey des Stores aus CROSS JOIN mit v_lew_bil.v_store_1 über v_lew_bil.v_store_relocation_1; angezeigt wird der GewinnerStore bei Fusionen - nicht der untergegangene OriginalStore der Fakten'),
store_desc
OPTIONS(description='Benutzt wird loc_name2 vor loc_name (used_store_desc) aus v_lew_bil.v_store_1 -> letztlich aus Core:t_location_1'),
city OPTIONS(description='AUS CORE.t_address_1'), wh_id
OPTIONS(description='NaturalKey (src_wh_id) des dem Store (Gewinnerstore! - siehe loc_sid_store) über die Hauptlieferbeziehung zugeordneten Warehouse (aus BIL:v_store_to_warehouse_lastknown_1)'),
wh_desc
OPTIONS(description='Benutzt wird loc_name2 vor loc_name (used_wh_desc) aus CORE:t_location_1 über die dem Store (Gewinnerstore! - siehe loc_sid_store) in der Hauptlieferbeziehung zugeordneten Warehouse (aus BIL:v_store_to_warehouse_lastknown_1)'),
sales_manager_id OPTIONS(description='AUS BIL:v_location_organization_1'), sales_manager_name
OPTIONS(description='AUS BIL:v_location_organization_1'), account_manager_id
OPTIONS(description='AUS BIL:v_location_organization_1'), account_manager_name
OPTIONS(description='AUS BIL:v_location_organization_1'), dat_calendar OPTIONS(description='Datum zum Fakten-Kalendertag'),
cy_month OPTIONS(description='Monat_1 zum Fakten-Kalendertag'), currency_iso_cd OPTIONS(description='AUS CORE:v_client_1'),
plan_val_turnover OPTIONS(description='CORE:v_wawi_ptm_plantimeday_wh.val_turnover'), plan_val_turnover_net
OPTIONS(description='CORE:v_wawi_ptm_plantimeday_wh.val_turnover (kein Schreibfehler!)'), plan_val_hours
OPTIONS(description='CORE:v_wawi_ptm_plantimeday_wh.val_hours'), plan_val_inv_training
OPTIONS(description='CORE:v_wawi_ptm_plantimeday_wh.(val_inventory + val_training)'), plan_sales_pieces
OPTIONS(description='Plan Abverkäufe Stück/Kg'), plan_avg_sales_price
OPTIONS(description='Plan durchschnittliche Artikelpreis'), plan_piece_performance
OPTIONS(description='Plan Stückleistung'), sales_pieces OPTIONS(description='Anzahl der abverkäuften Stk./Kg.'),
sales_pieces_ber OPTIONS(description='Anzahl der abverkäuften Stk./Kg.'), sales_pieces_py
OPTIONS(description='Anzahl der abverkäuften Stk./Kg aus dem Vorjahr'), avg_sales_price
OPTIONS(description='Durchschnittliche Abverkaufspreis'), piece_receipt
OPTIONS(description='Durchschnittliche Artikelanzahl pro Bon'), piece_performance OPTIONS(description='Stückleistung '),
val_retail_asis OPTIONS(description='CORE:v_agg_sales_store_day.val_retail'), val_retail_net_asis
OPTIONS(description='CORE:v_agg_sales_store_day.val_retail_net'), cnt_customer_asis
OPTIONS(description='CORE:v_agg_sales_store_day.cnt_customer'), val_retail_asis_ber
OPTIONS(description='Umsatz in lokaler Währung'), val_retail_net_asis_ber
OPTIONS(description='Umsatz in lokaler Währung'), cnt_customer_asis_ber
OPTIONS(description='Anzahl von Kunden (Anzahl von Bons)'), val_retail_asis_py
OPTIONS(description='CORE:v_agg_sales_store_day.val_retail; Vorjahresauswahl über die der ReportWoche (week_page) zugeordneten Intervallgrenzen aus MART_MSI:v_bo_perf_cal_list_mth_1'),
val_retail_net_asis_py
OPTIONS(description='CORE:v_agg_sales_store_day.val_retail_net; Vorjahresauswahl über die der ReportWoche (week_page) zugeordneten Intervallgrenzen aus MART_MSI:v_bo_perf_cal_list_mth_1'),
cnt_customer_asis_py
OPTIONS(description='CORE:v_agg_sales_store_day.cnt_customer; Vorjahresauswahl über die der ReportWoche (week_page) zugeordneten Intervallgrenzen aus MART_MSI:v_bo_perf_cal_list_mth_1'),
sales_pieces_asis_py OPTIONS(description='Anzahl der abverkäuften Stk./Kg aus dem Vorjahr'), piece_performance_py
OPTIONS(description='Stückleistung aus dem Vorjahr'), time_working_netto_std
OPTIONS(description='CORE:v_wawi_agg_wt_store_day_asis.time_working_netto_hrs'), miss_times_perf
OPTIONS(description='CORE:v_wawi_agg_wt_store_day_asis.perf_rel_absence_hrs'), plan_turnover_calc_ums_diff
OPTIONS(description='CORE:v_wawi_ptm_plantimeday_wh.val_turnover; Monatssumme nur bis zum Maximalen Umsatztag der RepWoche!'),
plan_turnover_calc_ums_dif_net
OPTIONS(description='CORE:v_wawi_ptm_plantimeday_wh.val_turnover (kein Schreibfehler!); Monatssumme nur bis zum Maximalen Umsatztag der RepWoche!'),
plan_sales_qty_calc_abv_diff
OPTIONS(description='MART_MSI:t_bo_base_performance_list.plan_sales_pieces; Wertausweis nur bis zum Maximalen Umsatztag der Tagesauswahl pro Store!'),
plan_sales_qty_calc_prod_diff
OPTIONS(description='MART_MSI:t_bo_base_performance_list.plan_sales_pieces; Wertausweis nur bis zum Maximalen Umsatztag der Tagesauswahl pro Store!'),
plan_hours_calc_hrs_diff
OPTIONS(description='CORE:v_wawi_ptm_plantimeday_wh.val_hours; Monatssumme nur bis zum Maximalen Umsatztag der RepWoche!'),
diff_hours
OPTIONS(description='MART_MSI:t_bo_base_performance_list_1: Formel: time_working_netto_std + miss_times_perf - plan_val_hours; Realstunden(Arbeit+Schulung)-Planstunden'),
plan_productivity OPTIONS(description='Plan_Prk Bez. Einheit productivity'), plan_productivity_net
OPTIONS(description='Plan_Prk Bez. Einheit productivity net'), val_retail_calc_prod_diff
OPTIONS(description='Val_Retk Bez. Einheit diff'), val_retail_calc_prod_diff_net
OPTIONS(description='Val_Retk Bez. Einheit net'), hrs_calc_prod_diff
OPTIONS(description='??? Iststunden Hok Bez. Einheit diff'), miss_times_perf_calc_prod_diff
OPTIONS(description='Miss_Tik Bez. Einheit diff'), val_rtl_rl_sfo_store
OPTIONS(description='Val_Rtlk Bez. Einheit store'), val_rtl_rl_net_sfo_store
OPTIONS(description='Val_Rtlk Bez. Einheit store'), sfo_to_val_retail_pct
OPTIONS(description='Sfo_To_k Bez. Einheit pct'), sfo_to_val_retail_net_pct
OPTIONS(description='Sfo_To_k Bez. Einheit pct'), val_rtl_net_sfo_mhd_break
OPTIONS(description='Abschritften MHD & Bruch'), val_rtl_net_sfo_other_stc_loss
OPTIONS(description='Abschritften Sonstige Warenverluste'), val_rtl_net_sfo_str_deliv_qlty
OPTIONS(description='Abschritften Anlieferung Qualität'), plan_turnover_calc_prod_diff
OPTIONS(description='Plan_Tuk Bez. Einheit diff'), plan_turnover_calc_pro_dif_net
OPTIONS(description='Geplante Umsatz - Verwendet im Berich für Metrik Kalkulation'), plan_hours_calc_prod_diff
OPTIONS(description='Plan_Hok Bez. Einheit diff'), diff_val_retail_pct
OPTIONS(description='??? Inventurdifferenz Umsatz RTL in Prozent'), diff_val_retail_net_pct
OPTIONS(description='??? Netto Inventurdifferenz Umsatz RTL in Prozent'), act_productivity
OPTIONS(description='Aktive Produktivität'), act_productivity_net OPTIONS(description='Aktive Produktivität net'),
diff_plan_act_productivity OPTIONS(description='??? Differenz Planung aktive Produktivität'),
diff_plan_act_productivity_net OPTIONS(description='??? Differenz Planung aktive Produktivität net'), diff_inv
OPTIONS(description='Differenzwert'), diff_net_inv OPTIONS(description='Differenzwert Netto'), val_retail_store_inv_stc
OPTIONS(description='Filialumsatz-Inventurzeitraum'), val_retail_store_net_inv_stc
OPTIONS(description='Währungswert auf Berichtswährung umgerechnet - aktuell kein Input zur Interpretation'))
OPTIONS(DESCRIPTION = `STÜCKLEISTUNG OVERVIEW MONTH (FILIALÜBERSICHT)`) AS SELECT *
FROM ldl_p_lew_mart_msi.v_bo_store_overview_mth_1;