/* #DescStart#
#$Revision: 10233 $, $LastChangedBy: dcamerzan $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_bil_ac.v_kpi_day_1 (client_id, org_type_id, org_unit_nr, indicator_id, indicator_type_id
, cy, dat_formdate, val_indicator, timestamp_fn, dat_dayend, load_id) AS SELECT *
FROM ldl_p_lew_bil.v_kpi_day_1;