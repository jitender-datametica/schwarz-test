/* #DescStart#
#$Revision: 6295 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_kpges_availability_day_wh_1 (client_id, wh_id, aspect_id, dat_calendar,
indicator_id, availability_fg) AS SELECT *
FROM ldl_p_lew_mart_msi.v_kpges_availability_day_wh_1;