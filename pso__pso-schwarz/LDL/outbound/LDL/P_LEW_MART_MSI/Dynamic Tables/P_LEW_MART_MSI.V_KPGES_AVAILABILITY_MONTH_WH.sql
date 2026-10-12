CREATE OR REPLACE TABLE ldl_p_lew_mart_msi.v_kpges_availability_month_wh AS
SELECT KPGES.client_id,
 WH.wh_id,
 WH.aspect_id,
 KPGES.cy_month,
 KPGES.indicator_id,
 KPGES.availability_fg
FROM ldl_p_lew_mart_msi.v_kpges_availability_month AS KPGES
 INNER JOIN ldl_p_lew_mart_msi.v_org_wh_merge AS WH ON KPGES.client_id = WH.client_id;