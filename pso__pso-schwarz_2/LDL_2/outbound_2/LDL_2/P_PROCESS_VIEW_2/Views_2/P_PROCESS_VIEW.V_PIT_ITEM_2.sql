CREATE OR REPLACE VIEW ldl_p_process_view.v_pit_item_2 AS SELECT ITM.client_id,
 ITM.item_sid,
 ITM.src_orig_item_nr AS orig_item_nr,
 ITM.item_name AS item_descr_int,
 COALESCE(DSC.item_descr, ITM.item_name) AS item_descr_loc,
 IFG.src_familygrp_cd AS uwg_af_desc,
 CAST(NULL AS BIGNUMERIC) AS subitemgroup_id,
 CAST(NULL AS BIGNUMERIC) AS listing_fg,
 CAST(NULL AS BIGNUMERIC) AS item_familygroup_id,
 CAST(NULL AS STRING) AS subitemgroup_desc_intl,
 CAST(NULL AS STRING) AS item_family_desc_intl
FROM ldl_p_lew_core_ac.v_item_2 AS ITM
 INNER JOIN ldl_p_lew_core_ac.v_item_hist_2 AS ITH ON ITM.client_id = ITH.client_id AND ITM.item_sid = ITH.item_sid AND
   CURRENT_DATE BETWEEN ITH.dwh_valid_from AND ITH.dwh_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_country_2 AS CTR ON ITM.client_id = CTR.country_sid
 LEFT JOIN ldl_p_lew_core_ac.v_item_descr_2 AS DSC ON ITM.client_id = DSC.client_id AND ITM.item_sid = DSC.item_sid AND
   CTR.lang_sid = DSC.lang_sid
 INNER JOIN ldl_p_lew_core_ac.v_item_familygroup_2 AS IFG ON ITH.client_id = IFG.client_id AND ITH.item_fam_grp_sid = IFG
   .item_fam_grp_sid
UNION ALL
SELECT country_sid,
 - 2 AS dm__operand1,
 'TOT' AS dm__operand2,
 'TOT' AS dm__operand3,
 'TOT' AS dm__operand4,
 'TOT' AS dm__operand5,
 CAST(NULL AS BIGNUMERIC) AS subitemgroup_id,
 CAST(NULL AS BIGNUMERIC) AS listing_fg,
 CAST(NULL AS BIGNUMERIC) AS item_familygroup_id,
 CAST(NULL AS STRING) AS subitemgroup_desc_intl,
 CAST(NULL AS STRING) AS item_family_desc_intl
FROM ldl_p_lew_core_ac.v_country_2;