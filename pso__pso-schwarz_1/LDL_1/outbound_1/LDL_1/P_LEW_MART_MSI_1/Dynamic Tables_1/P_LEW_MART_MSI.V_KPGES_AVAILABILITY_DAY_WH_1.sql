CREATE OR REPLACE TABLE ldl_p_lew_mart_msi.v_kpges_availability_day_wh_1 AS
SELECT KPGES.client_id,
 WH.wh_id,
 WH.aspect_id,
 KPGES.dat_calendar,
 KPGES.indicator_id,
 KPGES.availability_fg
FROM ldl_p_lew_mart_msi.v_kpges_availability_day_1 AS KPGES
 INNER JOIN ldl_p_lew_mart_msi.v_org_wh_merge_1 AS WH ON KPGES.client_id = WH.client_id;