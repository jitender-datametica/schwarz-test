/* #DescStart#
#$Revision: 7705 $, $LastChangedBy: umeister $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_kpges_mth_wh_merge_1 (client_id, wh_id, aspect_id, indicator_id, cy_month,
val_indicator, currency_iso_cd, dat_dayend) AS SELECT client_id,
 wh_id,
 aspect_id,
 indicator_id,
 cy_month,
 val_indicator,
 currency_iso_cd,
 dat_dayend
FROM ldl_p_lew_mart_msi.v_kpges_mth_wh_merge_1;