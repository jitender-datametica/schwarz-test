/* * Created by Jens Thole
 * on 14.06.2018
 * Inhalt: finale Grundgesamtheit der Faktenauswahl für bo_perflist; tagesgranular;
 * Quellen: CORE:t_wawi_agg_wt_store_day_asis,Core:t_wawi_ptm_plantimeday_wh,BIL:t_agg_sales_store_day_2
 * ausgehend von der in MART_MSI:v_mat_bo_base_performance_list_2 vorbereiteten Grundgesamtheit
 * werden deren Sätze mit weiteren beschreibenden Attributen angereichert, so daß schließlich alle
 * notwendigen Felder der drei Zielebenen DAY,WEEK und MONTH konsolidiert vorliegen.
 *
 * Granularität (Gewinnerstore, Tag_2) - keine weitere Verdichtung
 * Hilfsattribute der Faktenauswahlzeit (MART_MSI:v_bo_perf_cal_list_day_2) werden übernommen.
 *--------------------------------------------------------------------------
 * Die View ist die erste Stufe zur Materialisierung der Tabelle p_lew_mart_msi.t_bo_base_performance_list_2
 ************************************************************************* */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat_bo_base_performance_list_2 AS
-- die ref-Tabelle ist eine_2 WAWI-Kopie. Im WAWI-DWH wurde als language_id der gleiche ID-Raum verwendet wie client oder country.

-- Im DWH2.0 is die Sprache als echte Entität nicht identisch zum Land_2 (es gibt also kein österreichisch oder US-Amerikanisch)Allerdings wurde die Länder-descr in DWH2.0

-- nicht multilanguage-spezifisch gepflegt, daher hier die Problematik die Landesbezeichnung in Landessprache zu bekommen und daher der

-- Rückgriff auf die WAWI-Legacy-Kopie p_lew_core_ac.v_wawi_ref_country_act_2
 SELECT DT.client_id,
 RCT.country_id,
 RCT.country_desc,
 RCT.country_iso_cd,
 DT.loc_sid_store,
 DT.orig_store_nr,
 DT.used_store_desc,
 OSC.city,
 DT.src_wh_id,
 DT.used_wh_desc,
 SAM.sales_manager_id,
 SAM.sales_manager_name,
 SAM.account_manager_id,
 SAM.account_manager_name,
 DT.cal_dt,
 DT.py_caldt_shifted,
 DT.cy_week,
 DT.py_week_shifted,
 DT.cy_week_seq,
 DT.py_week_seq_shifted,
 DT.cy_month,
 DT.used_closing_dt,
 DT.is_daily_level_row,
 DT.is_weekly_normal_level_row,
 DT.is_weekly_pyshift_level_row,
 DT.is_monthly_level_row,
 CL.curr_cd,
 COALESCE(DT.plan_val_turnover, 0) AS plan_val_turnover,
 COALESCE(DT.plan_val_turnover_net, 0) AS plan_val_turnover_net,
 COALESCE(DT.plan_val_hours, 0) AS plan_val_hours,
 COALESCE(DT.plan_val_inv_training, 0) AS plan_val_inv_training,
 COALESCE(DT.val_retail, 0) AS val_retail,
 COALESCE(DT.val_retail_net, 0) AS val_retail_net,
 COALESCE(DT.cnt_customer, 0) AS cnt_customer,
 COALESCE(DT.time_working_netto_std, 0) AS time_working_netto_std,
 COALESCE(DT.miss_times_perf, 0) AS miss_times_perf
FROM ldl_p_lew_mart_msi.v_mat0_bo_base_performance_list_2 AS DT
 INNER JOIN ldl_p_lew_mart_msi.v_ref_country_act_bo_2 AS RCT ON DT.client_id = RCT.country_id AND DT.client_id = RCT.language_id
   -- Landeswährung aus CLIENT statt aus Currency-rates

 INNER JOIN ldl_p_lew_core_ac.v_client_2 AS CL ON DT.client_id = CL.client_id
  -- p_lew_mart_msi.v_mat_org_store_contact_2 --> p_lew_bil.v_store_contact_2  ===> ersetzt durch adress

  -- Im Original wurden separat die WAWI-Attribute nochmals aus der WAWI-Kopie p_lew_core_ac.v_wawi_org_store_contact_2 entnommen und für nicht gesetzte Elemente aus

  -- der DWH2.0-Tabelle t_address_2 gesetzt. Dies ist jedoch in Wahrheit nie der Fall

  -- (Wäre_2 auch komisch, nachdem die WAWI-Übernahme erfolgt und alle Werte in das gemeinsame Ziel t_address_2 schreibt...)

  
 LEFT JOIN ldl_p_lew_core_ac.v_address_2 AS OSC ON DT.client_id = OSC.client_id AND DT.addr_sid = OSC.addr_sid
   -- Ersatz für p_lew_mart_msi.v_org_sales_manager_2 und p_lew_mart_msi.v_org_account_manager_2

   -- Subselect entnommen und verallgemeinert aus p_lew_mart_msi.v_mat_org_sales_manager_2

 LEFT JOIN ldl_p_lew_bil_ac.v_location_organization_2 AS SAM ON DT.client_id = SAM.client_id AND DT.loc_sid_store = SAM.loc_sid_store
     AND DT.loc_sid_wh = SAM.loc_sid_wh;