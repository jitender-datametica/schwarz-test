/* #DescStart#
#$Revision: 12251 $, $LastChangedBy: gkunz $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_cm_ac.v_lil_gfk_category_map_2 (gfk_cat_name, src_subitemgrp_cd, src_familygrp_cd,
gfk_cat_id) AS SELECT gfk_cat_name,
 src_subitemgrp_cd,
 src_familygrp_cd,
 gfk_cat_id
FROM ldl_p_lew_mart_cm.v_lil_gfk_category_map_2;