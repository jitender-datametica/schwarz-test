CREATE OR REPLACE VIEW P_LEW_MART_CM_AC.V_LIL_GFK_CATEGORY_MAP_2
/*
#DescStart#
#$Revision: 12251 $, $LastChangedBy: gkunz $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    gfk_cat_name
    , src_subitemgrp_cd
    , src_familygrp_cd
    , gfk_cat_id
)
AS
SELECT
gfk_cat_name,
src_subitemgrp_cd,
src_familygrp_cd,
gfk_cat_id
FROM p_lew_mart_cm.v_lil_gfk_category_map_2 ;




