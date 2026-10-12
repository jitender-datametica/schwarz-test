/* #DescStart#
#$Revision: 10227 $, $LastChangedBy: dcamerzan $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_bil_ac.v_kpi_month (client_id, org_type_id, org_unit_nr, indicator_id,
indicator_type_id, cy, month_id, val_indicator, timestamp_fn, dat_dayend, load_id) AS SELECT *
FROM ldl_p_lew_bil.v_kpi_month;