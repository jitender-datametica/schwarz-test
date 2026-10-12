CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_BO_BASE_PERFORMANCE_LIST
 /**************************************************************************
 * Created by Jens Thole
 * on 14.06.2018
 * Inhalt: finale Grundgesamtheit der Faktenauswahl für bo_perflist; tagesgranular;
 * Quellen: CORE:t_wawi_agg_wt_store_day_asis,Core:t_wawi_ptm_plantimeday_wh,BIL:t_agg_sales_store_day
 * ausgehend von der in MART_MSI:v_mat_bo_base_performance_list vorbereiteten Grundgesamtheit
 * werden deren Sätze mit weiteren beschreibenden Attributen angereichert, so daß schließlich alle
 * notwendigen Felder der drei Zielebenen DAY,WEEK und MONTH konsolidiert vorliegen.
 *
 * Granularität (Gewinnerstore, Tag) - keine weitere Verdichtung
 * Hilfsattribute der Faktenauswahlzeit (MART_MSI:v_bo_perf_cal_list_day) werden übernommen.
 *--------------------------------------------------------------------------
 * Die View ist die erste Stufe zur Materialisierung der Tabelle p_lew_mart_msi.t_bo_base_performance_list
 **************************************************************************/
AS
SELECT
dt.client_id,
rct.country_id,
rct.country_desc,
rct.country_iso_cd,
dt.loc_sid_store,
dt.orig_store_nr,
dt.used_store_desc,
osc.city,
dt.src_wh_id,
dt.used_wh_desc,
sam.sales_manager_id,
sam.sales_manager_name,
sam.account_manager_id,
sam.account_manager_name,
dt.cal_dt,
dt.py_caldt_shifted,
dt.cy_week,
dt.py_week_shifted,
dt.cy_week_seq,
dt.py_week_seq_shifted,
dt.cy_month,
dt.used_closing_dt,
dt.is_daily_level_row,
dt.is_weekly_normal_level_row,
dt.is_weekly_pyshift_level_row,
dt.is_monthly_level_row,
cl.curr_cd,
Coalesce(dt.plan_val_turnover,0)         AS plan_val_turnover,
Coalesce(dt.plan_val_turnover_net,0)     AS plan_val_turnover_net,
Coalesce(dt.plan_val_hours,0)            AS plan_val_hours,
Coalesce(dt.plan_val_inv_training,0)     AS plan_val_inv_training,
Coalesce(dt.val_retail,0)                AS val_retail,
Coalesce(dt.val_retail_net,0)            AS val_retail_net,
Coalesce(dt.cnt_customer,0)              AS cnt_customer,
Coalesce(dt.time_working_netto_std,0)    AS time_working_netto_std,
Coalesce(dt.miss_times_perf ,0)          AS miss_times_perf
FROM p_lew_mart_msi.v_mat0_bo_base_performance_list dt

-- die ref-Tabelle ist eine WAWI-Kopie. Im WAWI-DWH wurde als language_id der gleiche ID-Raum verwendet wie client oder country.
-- Im DWH2.0 is die Sprache als echte Entität nicht identisch zum Land (es gibt also kein österreichisch oder US-Amerikanisch)Allerdings wurde die Länder-descr in DWH2.0
--nicht multilanguage-spezifisch gepflegt, daher hier die Problematik die Landesbezeichnung in Landessprache zu bekommen und daher der
-- Rückgriff auf die WAWI-Legacy-Kopie p_lew_core_ac.v_wawi_ref_country_act
INNER JOIN p_lew_mart_msi.v_ref_country_act_bo as rct
ON dt.client_id = rct.country_id
   AND dt.client_id = rct.language_id

-- Landeswährung aus CLIENT statt aus Currency-rates
INNER JOIN p_lew_core_ac.v_client AS cl
ON  dt.client_id = cl.client_id

--p_lew_mart_msi.v_mat_org_store_contact --> p_lew_bil.v_store_contact  ===> ersetzt durch adress
-- Im Original wurden separat die WAWI-Attribute nochmals aus der WAWI-Kopie p_lew_core_ac.v_wawi_org_store_contact entnommen und für nicht gesetzte Elemente aus
-- der DWH2.0-Tabelle t_address gesetzt. Dies ist jedoch in Wahrheit nie der Fall
--(Wäre auch komisch, nachdem die WAWI-Übernahme erfolgt und alle Werte in das gemeinsame Ziel t_address schreibt...)
LEFT OUTER JOIN p_lew_core_ac.v_address as osc
ON dt.client_id = osc.client_id
AND dt.addr_sid = osc.addr_sid

--Ersatz für p_lew_mart_msi.v_org_sales_manager und p_lew_mart_msi.v_org_account_manager
-- Subselect entnommen und verallgemeinert aus p_lew_mart_msi.v_mat_org_sales_manager
LEFT OUTER JOIN p_lew_bil_ac.v_location_organization AS sam
ON dt.client_id      = sam.client_id
AND dt.loc_sid_store = sam.loc_sid_store
AND dt.loc_sid_wh    = sam.loc_sid_wh
;







