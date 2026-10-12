CREATE OR REPLACE VIEW ldl_p_lew_mart_cm.v_lil_tr_categories_match_2 (client_id, subitemgroup_id, family_cd) AS SELECT
 client_id,
 src_subitemgrp_cd AS subitemgroup_id,
  CASE
  WHEN src_familygrp_cd IS NULL
  THEN 3333
  ELSE src_familygrp_cd
  END AS src_familygrp_cd
FROM ldl_p_lew_mart_cm.v_lil_tr_category_2;