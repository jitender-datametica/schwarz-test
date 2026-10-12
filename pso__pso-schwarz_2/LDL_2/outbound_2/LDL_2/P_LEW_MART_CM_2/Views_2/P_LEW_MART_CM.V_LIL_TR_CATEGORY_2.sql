/* extraktion des familycodes aus Kompositfeld, Datentypangleichung */
CREATE OR REPLACE VIEW ldl_p_lew_mart_cm.v_lil_tr_category_2 (client_id, src_subitemgrp_cd, src_familygrp_cd) AS SELECT
 IFG.client_id,
 ROUND(CAST(SG.src_subitemgrp_cd AS BIGNUMERIC), 0) AS src_subitemgrp_cd,
  CASE
  WHEN STRPOS(FAM.src_familygrp_cd, '.') > 0 AND STRPOS(FAM.src_familygrp_cd, '.') < LENGTH(FAM.src_familygrp_cd)
  THEN ROUND(CAST(SUBSTR(FAM.src_familygrp_cd, STRPOS(FAM.src_familygrp_cd, '.') + 1) AS BIGNUMERIC), 0)
  ELSE NULL
  END AS src_familygrp_cd
FROM ldl_p_lew_process_mstr_ac.v_lil_tr_category_ifg_2 AS IFG
 INNER JOIN ldl_p_lew_bil_ac.v_item_familygroup_2 AS FAM ON IFG.item_fam_grp_sid = FAM.item_fam_grp_sid AND IFG.sub_item_grp_sid
    = FAM.sub_item_grp_sid
 INNER JOIN ldl_p_lew_core_ac.v_subitemgroup_2 AS SG ON IFG.sub_item_grp_sid = SG.sub_item_grp_sid
WHERE IFG.active_fg = 1
UNION ALL
SELECT SIG.client_id,
 ROUND(CAST(SG.src_subitemgrp_cd AS BIGNUMERIC), 0) AS src_subitemgrp_cd,
 CAST(NULL AS BIGNUMERIC) AS src_familygrp_cd
FROM ldl_p_lew_process_mstr_ac.v_lil_tr_category_sig_2 AS SIG
 INNER JOIN ldl_p_lew_core_ac.v_subitemgroup_2 AS SG ON SIG.sub_item_grp_sid = SG.sub_item_grp_sid
WHERE SIG.active_fg = 1;