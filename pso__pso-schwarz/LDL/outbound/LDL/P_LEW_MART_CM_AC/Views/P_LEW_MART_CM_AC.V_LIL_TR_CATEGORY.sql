/* #DescStart#
#$Revision: 12251 $, $LastChangedBy: gkunz $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_cm_ac.v_lil_tr_category (client_id, src_subitemgrp_cd, src_familygrp_cd) AS SELECT
 *
FROM ldl_p_lew_mart_cm.v_lil_tr_category;