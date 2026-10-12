/* extraktion des familycodes aus Kompositfeld, Datentypangleichung */
CREATE OR REPLACE VIEW ldl_p_lew_mart_cm.v_lil_gfk_category_map (gfk_cat_name, src_subitemgrp_cd, src_familygrp_cd,
gfk_cat_id, gfk_cat_type_cd) AS SELECT DISTINCT GFK.gfk_cat_name_en AS gfk_cat_name,
 SG.src_subitemgrp_cd,
  CASE
  WHEN STRPOS(FAM.src_familygrp_cd, '.') > 0 AND STRPOS(FAM.src_familygrp_cd, '.') < LENGTH(FAM.src_familygrp_cd)
  THEN ROUND(CAST(SUBSTR(FAM.src_familygrp_cd, STRPOS(FAM.src_familygrp_cd, '.') + 1) AS BIGNUMERIC), 0)
  ELSE NULL
  END AS src_familygrp_cd,
 GFK.gfk_cat_id,
 GFKC.gfk_cat_type_cd
FROM ldl_p_lew_core_ac.v_lil_gfk_category_map_ifg AS IFG
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_gfk_category AS GFK ON IFG.gfk_cat_sid = GFK.gfk_cat_sid
 INNER JOIN ldl_p_lew_core_ac.v_lil_gfk_category AS GFKC ON IFG.gfk_cat_sid = GFKC.gfk_cat_sid
 INNER JOIN ldl_p_lew_bil_ac.v_item_familygroup AS FAM ON IFG.item_fam_grp_sid = FAM.item_fam_grp_sid AND IFG.sub_item_grp_sid
    = FAM.sub_item_grp_sid
 INNER JOIN ldl_p_lew_core_ac.v_subitemgroup AS SG ON FAM.sub_item_grp_sid = SG.sub_item_grp_sid
UNION ALL
SELECT DISTINCT GFK.gfk_cat_name_en AS gfk_cat_name,
 SG.src_subitemgrp_cd,
 CAST(NULL AS BIGNUMERIC) AS src_familygrp_cd,
 GFK.gfk_cat_id,
 GFKC.gfk_cat_type_cd
FROM ldl_p_lew_core_ac.v_lil_gfk_category_map_sig AS SIG
 INNER JOIN ldl_p_lew_process_mstr_ac.v_lil_gfk_category AS GFK ON SIG.gfk_cat_sid = GFK.gfk_cat_sid
 INNER JOIN ldl_p_lew_core_ac.v_lil_gfk_category AS GFKC ON SIG.gfk_cat_sid = GFKC.gfk_cat_sid
 INNER JOIN ldl_p_lew_core_ac.v_subitemgroup AS SG ON SIG.sub_item_grp_sid = SG.sub_item_grp_sid;