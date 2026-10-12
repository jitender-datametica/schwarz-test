/* #DescStart#
#$Revision: 11351 $, $LastChangedBy: spalmeri $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_analytics_ac.v_item_familygroup_1 (client_id, item_fam_grp_sid, src_node,
src_familygrp_cd, src_familygrp_id, item_fam_grp_name, dwh_load_id, dwh_created, dwh_updated) AS SELECT *
FROM ldl_p_lew_mart_analytics.v_item_familygroup_1;