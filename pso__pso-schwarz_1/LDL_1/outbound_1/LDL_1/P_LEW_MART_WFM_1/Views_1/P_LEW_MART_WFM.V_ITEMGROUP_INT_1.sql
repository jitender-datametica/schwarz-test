CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_itemgroup_int_1 AS SELECT CLIENT.country_cd AS country_iso_cd,
 ROUND(CAST(IGI.src_itemgrp_int_cd AS BIGNUMERIC), 0) AS itemgroup_int_id,
  CASE
  WHEN SUBSTR(IGI_DESCR.item_grp_int_descr, 1, 1) IN ('1', '2', '3', '4', '5', '6', '7', '8', '9', '0')
  THEN SUBSTR(IGI_DESCR.item_grp_int_descr, INSTR(IGI_DESCR.item_grp_int_descr, ' ') + 1)
  ELSE IGI_DESCR.item_grp_int_descr
  END AS itemgroup_int_desc,
 MAPP.language_id
FROM ldl_p_lew_core_ac.v_itemgroup_international_1 AS IGI
 INNER JOIN ldl_p_lew_core_ac.v_itemgroup_international_descr_1 AS IGI_DESCR ON IGI.client_id = IGI_DESCR.client_id AND
   IGI.item_grp_int_sid = IGI_DESCR.item_grp_int_sid
 INNER JOIN ldl_p_lew_core_ac.v_client_1 AS CLIENT ON IGI.client_id = CLIENT.client_id
 INNER JOIN ldl_p_lew_core_ac.v_report_language_1 AS RLANG ON IGI_DESCR.lang_sid = RLANG.lang_sid
 INNER JOIN ldl_p_lew_core_ac.v_map_lang_spras_1 AS MAPP ON RLANG.src_spras = MAPP.sap_spras
WHERE (MAPP.language_id = IGI.client_id OR MAPP.language_id = 7)
 AND ROUND(CAST(IGI.src_itemgrp_int_cd AS BIGNUMERIC), 0) > 0;