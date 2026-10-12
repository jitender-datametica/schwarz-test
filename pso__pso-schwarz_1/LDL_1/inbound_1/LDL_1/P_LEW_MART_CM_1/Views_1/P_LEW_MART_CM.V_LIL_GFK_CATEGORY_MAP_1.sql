CREATE OR REPLACE VIEW P_LEW_MART_CM.V_LIL_GFK_CATEGORY_MAP_1
(
  gfk_cat_name
, src_subitemgrp_cd
, src_familygrp_cd
, gfk_cat_id
, gfk_cat_type_cd
)
AS
SELECT DISTINCT
gfk.gfk_cat_name_en,
sg.src_subitemgrp_cd,
CASE /*extraktion des familycodes aus Kompositfeld, Datentypangleichung */
      WHEN CHARINDEX('.', fam.src_familygrp_cd) > 0 AND CHARINDEX('.', fam.src_familygrp_cd) < LENGTH(fam.src_familygrp_cd)
THEN Cast(To_Number(SUBSTRING(fam.src_familygrp_cd, CHARINDEX('.', fam.src_familygrp_cd) +1)) AS INTEGER)
ELSE NULL
END AS src_familygrp_cd,
gfk.gfk_cat_id,
gfkc.gfk_cat_type_cd
FROM p_lew_core_ac.v_lil_gfk_category_map_ifg_1 AS ifg

INNER JOIN p_lew_process_mstr_ac.v_lil_gfk_category_1 AS gfk
ON ifg.gfk_cat_sid = gfk.gfk_cat_sid
INNER JOIN p_lew_core_ac.v_lil_gfk_category_1 AS gfkc
ON ifg.gfk_cat_sid = gfkc.gfk_cat_sid
INNER JOIN p_lew_bil_ac.v_item_familygroup_1 AS fam
ON fam.item_fam_grp_sid = ifg.item_fam_grp_sid
AND fam.sub_item_grp_sid = ifg.sub_item_grp_sid
INNER JOIN p_lew_core_ac.v_subitemgroup_1 AS sg
ON sg.sub_item_grp_sid = fam.sub_item_grp_sid

UNION ALL
SELECT DISTINCT
gfk.gfk_cat_name_en,
sg.src_subitemgrp_cd,
NULL AS src_familygrp_cd,
gfk.gfk_cat_id,
gfkc.gfk_cat_type_cd
FROM p_lew_core_ac.v_lil_gfk_category_map_sig_1 AS sig

INNER JOIN p_lew_process_mstr_ac.v_lil_gfk_category_1 AS gfk
ON sig.gfk_cat_sid = gfk.gfk_cat_sid
INNER JOIN p_lew_core_ac.v_lil_gfk_category_1 AS gfkc
ON sig.gfk_cat_sid = gfkc.gfk_cat_sid
INNER JOIN p_lew_core_ac.v_subitemgroup_1 AS sg
ON sg.sub_item_grp_sid = sig.sub_item_grp_sid;


