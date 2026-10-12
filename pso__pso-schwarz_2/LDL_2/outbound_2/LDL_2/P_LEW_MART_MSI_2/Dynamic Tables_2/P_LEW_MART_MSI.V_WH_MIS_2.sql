CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_wh_mis_2 AS
-- WH ist nicht nach SAP (eLWIS) migriert und Client ist nicht nach SAP migriert
 SELECT A.client_id,
 B.src_wh_id AS wh_id
FROM ldl_p_lew_core_ac.v_wawi_org_wh_act_2 AS A
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS B ON A.client_id = B.client_id AND A.wh_loc_sid = B.loc_sid_wh AND B.dwh_actual_fg
    = 1
 LEFT JOIN ldl_p_lew_process_ac.v_sap_migration_wh_2 AS MIGR_WH ON A.client_id = MIGR_WH.client_id AND A.wh_loc_sid =
    MIGR_WH.loc_sid_wh AND CURRENT_DATE BETWEEN MIGR_WH.migrated_start_dt AND MIGR_WH.migrated_end_dt
 LEFT JOIN ldl_p_lew_process_ac.v_sap_migration_client_2 AS MIGR_CLIENT ON A.client_id = MIGR_CLIENT.client_id AND
   CURRENT_DATE BETWEEN MIGR_CLIENT.migrated_start_dt AND MIGR_CLIENT.migrated_end_dt
WHERE A.language_id = 7
 AND (MIGR_WH.client_id IS NULL AND MIGR_CLIENT.client_id IS NULL OR COALESCE(A.ovis_data_fg, 0) = 1 AND COALESCE(A.wawi_data_fg
      , 0) = 0);