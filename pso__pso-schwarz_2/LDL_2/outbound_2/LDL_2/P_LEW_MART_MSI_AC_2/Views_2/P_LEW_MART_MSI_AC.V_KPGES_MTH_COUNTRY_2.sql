/* #DescStart#
#$Revision: 6295 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_kpges_mth_country_2 (client_id, indicator_id, cy_month, val_indicator,
currency_iso_cd, dat_dayend) AS SELECT *
FROM ldl_p_lew_mart_msi.v_kpges_mth_country_2;