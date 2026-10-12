CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_mat_audimex_item_1 (client_id, country_iso_cd, orig_item_nr, item_descr, plu_nr
, subitemgroup_id, descr_short, ag_reserve, dwh_load_id, dwh_created, dwh_updated) AS SELECT ITEM.client_id,
 ITEM.country_iso_cd,
 ITEM.orig_item_nr,
 DES.item_descr,
 PLU.plu_nr,
 ITDE.subitemgroup_id,
 SIG.descr_short,
 'UWGR' AS ag_reserve,
 ITEM.dwh_load_id,
 ITEM.dwh_created,
 ITEM.dwh_updated
FROM ldl_p_lew_mart_cs.v_cs_item_1 AS ITEM_1
 LEFT JOIN ldl_p_lew_mart_cs.v_cs_item_1 AS PLU ON ITEM.client_id = PLU.client_id AND ITEM.orig_item_nr = PLU.orig_item_nr
     AND PLU.plu_nr > 0
 LEFT JOIN ldl_p_lew_mart_cs.v_cs_item_details_1 AS ITDE ON ITEM.client_id = ITDE.client_id AND ITEM.orig_item_nr = ITDE.orig_item_nr
      AND ITEM.case_size = ITDE.case_size AND CURRENT_DATE BETWEEN ITDE.valid_from AND ITDE.valid_until
 LEFT JOIN ldl_p_lew_mart_cs.v_cs_item_descr_1 AS DES ON ITEM.client_id = DES.client_id AND ITEM.orig_item_nr = DES.orig_item_nr
       AND ITEM.case_size = DES.case_size AND ITEM.country_iso_cd = DES.language_iso_cd AND CURRENT_DATE BETWEEN DES.valid_from
   AND DES.valid_until
 LEFT JOIN ldl_p_lew_mart_cs.v_cs_subitemgroup_1 AS SIG ON ITDE.client_id = SIG.client_id AND ITDE.subitemgroup_id = CAST(SIG.subitemgroup_cd AS FLOAT64)
      AND ITEM.country_iso_cd = SIG.language_iso_cd AND CURRENT_DATE BETWEEN SIG.dwh_valid_from AND SIG.dwh_valid_to
WHERE ITEM.case_size >= 0
 AND ITEM.orig_item_nr > 0
 AND DES.language_iso_cd IS NOT NULL
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(ITEM.client_id AS STRING), ITEM.orig_item_nr ORDER BY ITEM.dwh_created
      IS NULL DESC, ITEM.dwh_created DESC, DES.item_descr IS NULL DESC, DES.item_descr DESC, PLU.plu_nr IS NULL, PLU.plu_nr
      , ITDE.subitemgroup_id IS NULL DESC, ITDE.subitemgroup_id DESC)) = 1;