CREATE OR REPLACE VIEW P_LEW_MART_CM.V_LIL_GFK_LIDL_CATEGORY_MATCH_2
(
  gfk_cat_name
, subitemgroup_id
, family_cd
, gfk_cat_id
, gfk_cat_type_cd
)
AS
SELECT
gfk_cat_name,
src_subitemgrp_cd,
CASE WHEN src_familygrp_cd IS NULL THEN 3333 ELSE src_familygrp_cd END AS src_familygrp_cd,
gfk_cat_id,
gfk_cat_type_cd
FROM p_lew_mart_cm.v_lil_gfk_category_map_2 AS gfk

WHERE src_subitemgrp_cd IS NOT NULL
    OR src_familygrp_cd IS NOT NULL

UNION ALL
SELECT
gfk_cat_name,
src_subitemgrp_cd,
CASE WHEN src_familygrp_cd IS NULL THEN 3333 ELSE src_familygrp_cd END AS src_familygrp_cd,
1 AS gfk_cat_id,
gfk_cat_type_cd
FROM p_lew_mart_cm.v_lil_gfk_category_map_2
WHERE src_subitemgrp_cd IS NOT NULL
    OR src_familygrp_cd IS NOT NULL;


