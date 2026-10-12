/* #DescStart#
#$Revision: 11351 $, $LastChangedBy: spalmeri $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_analytics_ac.v_item_familygroup_descr_2 (client_id, item_fam_grp_sid, lang_sid,
lang_cd, item_fam_grp_descr, item_fam_grp_descr_long, item_fam_grp_descr_caps, dwh_load_id, dwh_created, dwh_updated) AS
SELECT *
FROM ldl_p_lew_mart_analytics.v_item_familygroup_descr_2;