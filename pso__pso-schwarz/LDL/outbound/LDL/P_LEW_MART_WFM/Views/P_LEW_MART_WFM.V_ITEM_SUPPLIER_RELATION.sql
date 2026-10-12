CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_item_supplier_relation (country_lidl_cd, supplier_nr, item_nr, wh_id) AS
SELECT CLNT.src_country_lidl_cd AS country_lidl_cd,
 base_union.supplier_nr,
 ROUND(SAFE_CAST(COALESCE(ITM.config_item_cd, ITM.src_orig_item_nr, ITM.src_matnr) AS BIGNUMERIC), 0) AS item_nr,
 COALESCE(LOC.src_wh_id, - 1) AS wh_id
FROM (SELECT ITM_SUP_WH_DATA.client_id,
   ITM_SUP_WH_DATA.item_sid,
   ROUND(SAFE_CAST(SUPL.src_orig_supplier_nr AS BIGNUMERIC), 0) AS supplier_nr,
   ITM_SUP_WH_DATA.wh_loc_sid
  FROM ldl_p_lew_core_ac.v_wawi_itm_sup_wh_data AS ITM_SUP_WH_DATA
   INNER JOIN ldl_p_lew_core_ac.v_supplier AS SUPL ON ITM_SUP_WH_DATA.client_id = SUPL.client_id AND ITM_SUP_WH_DATA.sup_sid
      = SUPL.sup_sid
   INNER JOIN ldl_p_lew_core_ac.v_client_migration_per AS SAP_MIGRATION_CONFIG ON ITM_SUP_WH_DATA.client_id =
     SAP_MIGRATION_CONFIG.client_id AND (CURRENT_DATE < SAP_MIGRATION_CONFIG.migration_dat_valid_from OR CURRENT_DATE >
       SAP_MIGRATION_CONFIG.migration_dat_valid_to)
  WHERE CURRENT_DATE BETWEEN ITM_SUP_WH_DATA.dat_rec_start AND ITM_SUP_WH_DATA.dat_rec_end
   AND CURRENT_DATE BETWEEN ITM_SUP_WH_DATA.dat_valid_from AND ITM_SUP_WH_DATA.dat_valid_until) AS base_union
 INNER JOIN ldl_p_lew_core_ac.v_item AS ITM ON base_union.client_id = ITM.client_id AND base_union.item_sid = ITM.item_sid
   
 INNER JOIN ldl_p_lew_core_ac.v_location AS LOC ON base_union.client_id = LOC.client_id AND base_union.wh_loc_sid = LOC
   .loc_sid
 INNER JOIN ldl_p_lew_core_ac.v_client AS CLNT ON base_union.client_id = CLNT.client_id
WHERE ITM.item_sid > 0
 AND COALESCE(ROUND(SAFE_CAST(ITM.config_item_cd AS BIGNUMERIC), 0), ROUND(SAFE_CAST(ITM.src_orig_item_nr AS BIGNUMERIC
     ), 0), ROUND(SAFE_CAST(ITM.src_matnr AS BIGNUMERIC), 0)) > 0
GROUP BY country_lidl_cd,
 base_union.supplier_nr,
 item_nr,
 wh_id;