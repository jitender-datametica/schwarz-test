/* #DescStart#
#$Revision: 11351 $, $LastChangedBy: spalmeri $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_analytics_ac.v_subitemgroup_hist_2 (client_id, sub_item_grp_sid, item_grp_int_sid,
main_item_grp_sid, item_grp_int_cd, main_item_grp_cd, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created
, dwh_updated) AS SELECT *
FROM ldl_p_lew_mart_analytics.v_subitemgroup_hist_2;