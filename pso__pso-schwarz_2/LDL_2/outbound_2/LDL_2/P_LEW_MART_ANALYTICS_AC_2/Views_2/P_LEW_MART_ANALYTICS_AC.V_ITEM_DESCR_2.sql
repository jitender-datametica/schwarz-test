/* #DescStart#
#$Revision: 11351 $, $LastChangedBy: spalmeri $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_analytics_ac.v_item_descr_2 (client_id, item_sid, lang_sid, lang_cd, item_descr,
dwh_load_id, dwh_created, dwh_updated) AS SELECT *
FROM ldl_p_lew_mart_analytics.v_item_descr_2;