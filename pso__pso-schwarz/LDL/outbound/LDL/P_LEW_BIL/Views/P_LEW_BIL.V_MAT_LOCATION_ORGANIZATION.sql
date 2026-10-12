CREATE OR REPLACE VIEW ldl_p_lew_bil.v_mat_location_organization AS SELECT LOC_ORG.client_id,
 LOC_ORG.loc_sid_exp AS loc_sid_wh,
 LOC_ORG.loc_sid AS loc_sid_store,
 LOC_ORG.sales_manager_id,
 LOC_ORG.sales_manager_name,
 LOC_ORG.account_manager_id,
 LOC_ORG.account_manager_name,
 LOC_ORG.general_manager_id,
 LOC_ORG.general_manager_name,
 LOC_ORG.organisation_id,
 LOC_ORG.district_cd,
 LOC_ORG.active_from_dt,
 LOC_ORG.active_to_dt,
 LOC_ORG.deleted_fg,
 LOC_ORG.dwh_valid_from,
 LOC_ORG.dwh_valid_to,
  CASE
  WHEN CURRENT_DATE BETWEEN LOC_ORG.dwh_valid_from AND LOC_ORG.dwh_valid_to
  THEN 1
  ELSE 0
  END AS dwh_actual_fg,
  CASE
  WHEN LOC_ORG.deleted_fg = 0 AND CURRENT_DATE BETWEEN LOC_ORG.active_from_dt AND (COALESCE(LOC_ORG.active_to_dt,
      DATE '9999-12-31'))
  THEN 1
  ELSE 0
  END AS active_fg
FROM ldl_p_lew_core_ac.v_location_organization_hist AS LOC_ORG
 INNER JOIN ldl_p_lew_core_ac.v_location AS LOC ON LOC_ORG.client_id = LOC.client_id AND LOC_ORG.loc_sid_exp = LOC.loc_sid
     AND LOC.wh_store_mark = 'B'
WHERE LOC_ORG.deleted_fg = 0
 AND (LOC_ORG.client_id, LOC_ORG.loc_sid_exp, LOC_ORG.loc_sid) IN (SELECT (client_id, loc_sid_exp, loc_sid)
   FROM ldl_p_lew_core_ac.v_location_organization_hist AS STM
   WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
    AND deleted_fg = 0)
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(LOC_ORG.client_id AS STRING), CAST(LOC_ORG.loc_sid_exp AS STRING), CAST(LOC_ORG.loc_sid AS STRING)
      ORDER BY CASE
       WHEN LOC_ORG.sales_manager_id <> - 100
       THEN 'Nicht-Dummies'
       ELSE 'Dummies'
       END IS NULL, CASE
       WHEN LOC_ORG.sales_manager_id <> - 100
       THEN 'Nicht-Dummies'
       ELSE 'Dummies'
       END, LOC_ORG.dwh_valid_to IS NULL, LOC_ORG.dwh_valid_to)) = 1;