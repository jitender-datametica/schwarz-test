/* ----- BEGIN of inner SQL part (equal for all EMA interfaces) ----- */
/* ------------------------------------------------------------------ */
/* ------------------------------------------------------------------ */
CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_ema_base_data (client_id, src_country_lidl_cd, country_desc, sales_manager_id
, sales_manager_name, account_manager_id, account_manager_name, wh_id, wh_name, orig_store_nr, store_name, test_store_fg
) AS /* loc_sid from corresponding store */ /* loc_sid from corresponding warehouse */ -- CROSS JOIN for warehouse data

/* ------------------------------------------------------------------ */
/* ------ END of inner SQL part (equal for all EMA interfaces) ------ */
/* ------------------------------------------------------------------ */ SELECT CLIENT.client_id,
 CLIENT.src_country_lidl_cd,
 CDE.country_desc,
 org.sales_manager_id,
 org.sales_manager_name,
 org.account_manager_id,
 org.account_manager_name,
 LOC_WH.src_wh_id AS wh_id,
 LOC_WH.loc_name AS wh_name,
 LOC_ST.src_orig_store_nr AS orig_store_nr,
 LOC_ST.loc_name AS store_name,
 LOC_ST_HIST.test_store_fg
FROM (SELECT STWH.client_id,
   STWH.loc_sid_store,
   STWH.loc_sid_wh,
   COALESCE(LOC_ORG.sales_manager_id, - 100) AS sales_manager_id,
   COALESCE(LOC_ORG.sales_manager_name, 'Bezirksleiter') AS sales_manager_name,
   COALESCE(LOC_ORG.account_manager_id, - 1) AS account_manager_id,
   COALESCE(LOC_ORG.account_manager_name, 'Vertriebsleiter') AS account_manager_name,
   COALESCE(LOC_ORG.general_manager_id, - 10000) AS general_manager_id,
   COALESCE(LOC_ORG.general_manager_name, 'Geschaeftsfuehrer') AS general_manager_name
  FROM ldl_p_lew_bil_ac.v_store_to_warehouse AS STWH
   LEFT JOIN ldl_p_lew_bil_ac.v_location_organization AS LOC_ORG ON STWH.client_id = LOC_ORG.client_id AND STWH.loc_sid_store
      = LOC_ORG.loc_sid_store
  WHERE STWH.orig_store_nr <> STWH.orig_wh_nr
   AND STWH.dwh_actual_fg = 1
   AND STWH.active_fg = 1) AS org
 INNER JOIN ldl_p_lew_core_ac.v_location AS LOC_WH ON org.client_id = LOC_WH.client_id AND org.loc_sid_wh = LOC_WH.loc_sid
     AND LOC_WH.wh_store_mark = 'B' -- CROSS JOIN for store data

 INNER JOIN ldl_p_lew_core_ac.v_location AS LOC_ST ON org.client_id = LOC_ST.client_id AND org.loc_sid_store = LOC_ST.loc_sid
     AND LOC_ST.wh_store_mark = 'A' -- CROSS JOIN for store hist data (used for test_store_fg)

 INNER JOIN ldl_p_lew_core_ac.v_location_hist AS LOC_ST_HIST ON org.client_id = LOC_ST_HIST.client_id AND org.loc_sid_store
     = LOC_ST_HIST.loc_sid AND CURRENT_DATE BETWEEN LOC_ST_HIST.dwh_valid_from AND LOC_ST_HIST.dwh_valid_to
   -- CROSS JOIN for selecting country description

 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_country_desc AS CDE ON org.client_id = CDE.country_id AND CDE.language_id = 7
   -- CROSS JOIN for client data

 INNER JOIN ldl_p_lew_core_ac.v_client AS CLIENT ON org.client_id = CLIENT.client_id
WHERE DATE_ADD(CURRENT_DATE, INTERVAL 40 DAY) >= LOC_ST.opening_dt
 AND LOC_ST.closing_dt IS NULL;