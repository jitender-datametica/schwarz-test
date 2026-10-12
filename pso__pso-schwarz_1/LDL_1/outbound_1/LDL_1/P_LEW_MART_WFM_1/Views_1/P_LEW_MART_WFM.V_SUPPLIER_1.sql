CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_supplier_1 (country_lidl_cd, supplier_nr, supplier_name) AS SELECT CLNT.src_country_lidl_cd
  AS country_lidl_cd,
 COALESCE(ROUND(SAFE_CAST(SUPL.src_lifnr AS BIGNUMERIC), 0), ROUND(SAFE_CAST(SUPL.src_orig_supplier_nr AS BIGNUMERIC), 0
   )) AS supplier_nr,
 TRIM(COALESCE(SUPL.sup_name, WAWI_SUPL.supplier_name)) AS supplier_name
FROM ldl_p_lew_core_ac.v_supplier_1 AS SUPL
 INNER JOIN ldl_p_lew_core_ac.v_client_1 AS CLNT ON SUPL.client_id = CLNT.client_id
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_sup_supplier_1 AS WAWI_SUPL ON SUPL.client_id = WAWI_SUPL.client_id AND SUPL.sup_sid =
    WAWI_SUPL.sup_sid AND CURRENT_DATE BETWEEN WAWI_SUPL.dat_rec_start AND WAWI_SUPL.dat_rec_end
 INNER JOIN ldl_p_lew_core_ac.v_client_migration_per_1 AS MIGRATION_CLIENT ON SUPL.client_id = MIGRATION_CLIENT.client_id;