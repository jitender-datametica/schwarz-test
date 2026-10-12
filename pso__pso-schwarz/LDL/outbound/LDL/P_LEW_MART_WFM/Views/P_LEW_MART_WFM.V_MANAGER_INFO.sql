-- Ermitteln der Store - WH Beziehung von allen Stores die geöffnet und active sind

CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_manager_info AS SELECT DISTINCT locctry.global_loc_ctry_cd AS country_iso_cd
 ,
 locctry.src_wh_id AS wh_id,
 - 1 AS store_id,
 locorg.sales_manager_id,
 COALESCE(locorg.sales_manager_name, 'Bezirksleiter') AS sales_manager_name,
 locorg.account_manager_id,
 COALESCE(locorg.account_manager_name, 'Vertriebsleiter') AS account_manager_name,
 locorg.general_manager_id,
 COALESCE(locorg.general_manager_name, 'Geschaeftsfuehrer') AS general_manager_name
FROM (SELECT *
  FROM (SELECT LOCSTORE.client_id,
     LOCSTORE.src_orig_store_nr,
     WHDEL.loc_sid_store,
     LOCSTORE.global_loc_ctry_cd,
     LOCWH.src_wh_id
    FROM ldl_p_lew_core_ac.v_location AS LOCSTORE
     INNER JOIN ldl_p_lew_core_ac.v_store_to_wh_delivery_hist AS WHDEL ON LOCSTORE.loc_sid = WHDEL.loc_sid_store AND
          WHDEL.deleted_fg = 0 AND LOCSTORE.client_id = WHDEL.client_id AND CURRENT_DATE BETWEEN WHDEL.dwh_valid_from
        AND WHDEL.dwh_valid_to AND CURRENT_DATE BETWEEN WHDEL.active_from_dt AND WHDEL.active_to_dt
     INNER JOIN ldl_p_lew_core_ac.v_location AS LOCWH ON WHDEL.loc_sid_wh = LOCWH.loc_sid AND WHDEL.client_id = LOCWH.client_id
          AND LOCWH.wh_store_mark = 'B' AND LOCWH.src_wh_id IS NOT NULL
     INNER JOIN ldl_p_lew_core_ac.v_client_migration_per AS MIG ON LOCSTORE.client_id = MIG.client_id
    WHERE LOCSTORE.src_store_id IS NOT NULL
     AND LOCSTORE.wh_store_mark = 'A'
     AND LOCSTORE.opening_dt <= CURRENT_DATE
     AND (LOCSTORE.closing_dt IS NULL OR LOCSTORE.closing_dt > CURRENT_DATE)
     AND CURRENT_DATE BETWEEN MIG.migration_dat_valid_from AND MIG.migration_dat_valid_to) AS loc
  WHERE global_loc_ctry_cd IS NOT NULL) AS locctry
 LEFT JOIN (SELECT client_id,
   loc_sid_wh,
   loc_sid_store,
   sales_manager_id,
   sales_manager_name,
   account_manager_id,
   account_manager_name,
   general_manager_id,
   general_manager_name
  FROM ldl_p_lew_bil_ac.v_location_organization AS LO
  WHERE active_fg = 1
   AND dwh_actual_fg = 1
   AND account_manager_id <> - 99) AS locorg ON locctry.client_id = locorg.client_id AND locctry.loc_sid_store = locorg
   .loc_sid_store
WHERE locorg.sales_manager_id IS NOT NULL
UNION ALL
SELECT DISTINCT C.country_iso_cd,
 B.src_wh_id AS wh_id,
 - 1 AS store_id,
 org.sales_manager_id,
 COALESCE(org.sales_manager_name, 'Bezirksleiter') AS sales_manager_name,
 org.account_manager_id,
 COALESCE(org.account_manager_name, 'Vertriebsleiter') AS account_manager_name,
 ROUND(CAST(org.general_manager_id AS BIGNUMERIC), 0) AS general_manager_id,
 COALESCE(org.general_manager_name, 'Geschaeftsfuehrer') AS general_manager_name
FROM (SELECT client_id,
   st_loc_sid,
   sales_manager_id,
   sales_manager_name,
   account_manager_id,
   account_manager_name,
   general_manager_id,
   general_manager_name
  FROM ldl_p_lew_core_ac.v_wawi_org_salesorg AS ORG
  WHERE (client_id, st_loc_sid) IN (SELECT (client_id, st_loc_sid)
     FROM ldl_p_lew_core_ac.v_wawi_org_salesorg AS STM
     WHERE CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end)
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY client_id, st_loc_sid ORDER BY CASE
         WHEN sales_manager_id <> - 100
         THEN 'Nicht-Dummies'
         ELSE 'Dummies'
         END IS NULL DESC, CASE
         WHEN sales_manager_id <> - 100
         THEN 'Nicht-Dummies'
         ELSE 'Dummies'
         END DESC, dat_rec_end IS NULL DESC, dat_rec_end DESC)) = 1) AS org
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_org_store_skey_act AS SKEY ON org.client_id = SKEY.client_id AND org.st_loc_sid =
   SKEY.st_loc_sid
 INNER JOIN ldl_p_lew_core_ac.v_location AS B ON SKEY.client_id = B.client_id AND SKEY.wh_loc_sid = B.loc_sid
 INNER JOIN ldl_p_lew_core_ac.v_wawi_org_store_act AS A ON SKEY.client_id = A.client_id AND SKEY.wh_loc_sid = A.wh_loc_sid
     AND SKEY.st_loc_sid = A.st_loc_sid
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_country AS CC ON SKEY.client_id = CC.client_id
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_country AS C ON CC.country_id = C.country_id
 INNER JOIN ldl_p_lew_core_ac.v_client_migration_per AS MIG ON CC.client_id = MIG.client_id
WHERE (A.dat_opening_ovis <= CURRENT_DATE AND A.dat_closing_ovis IS NULL OR A.dat_opening_ovis <= CURRENT_DATE AND A.dat_closing_ovis
      > CURRENT_DATE)
 AND (CURRENT_DATE < MIG.migration_dat_valid_from OR CURRENT_DATE > MIG.migration_dat_valid_to)
 AND (A.client_id, SKEY.orig_store_nr) NOT IN (SELECT (WH.client_id, LOC.src_wh_id)
   FROM ldl_p_lew_core_ac.v_wawi_org_wh AS WH
    INNER JOIN ldl_p_lew_core_ac.v_location AS LOC ON WH.client_id = LOC.client_id AND WH.wh_loc_sid = LOC.loc_sid
   WHERE CURRENT_DATE BETWEEN WH.dat_rec_start AND WH.dat_rec_end
    AND CURRENT_DATE > WH.dat_opening);