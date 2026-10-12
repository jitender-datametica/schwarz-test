/* #DescStart#
#$Revision: 10691 $, $LastChangedBy: dcamerzan $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm_ac.v_season_stores (iso_cd, aspect_id, wh_id, wh_desc, store_id, store_desc)
AS SELECT *
FROM ldl_p_lew_mart_wfm.v_season_stores;