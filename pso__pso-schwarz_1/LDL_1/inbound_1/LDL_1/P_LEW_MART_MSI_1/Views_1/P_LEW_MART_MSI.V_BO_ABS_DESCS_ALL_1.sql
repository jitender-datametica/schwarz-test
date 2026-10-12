CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_BO_ABS_DESCS_ALL_1 as
      SELECT a.client_id,
      a.country_desc,
      a.country_id,
      a.country_iso_cd,
      a.store_id,
      a.orig_store_nr,
      a.store_desc,
      a.city,
      a.wh_id,
      a.wh_desc,
      a.sales_manager_id,
      a.sales_manager_name,
      a.account_manager_id,
      a.account_manager_name
     FROM p_lew_mart_msi.v_bo_descs_1 AS a
;