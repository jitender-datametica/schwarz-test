CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_kpges_mth_int AS
SELECT IM.indicator_id,
   IM.cy * 100 + IM.month_id AS cy_month,
 IM.val_indicator,
 CRY.currency_iso_cd,
 IM.dat_dayend
FROM ldl_p_lew_bil_ac.v_kpi_month AS IM
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate AS CRY ON IM.client_id = CRY.client_id AND IM.org_type_id
     = 10 AND IM.indicator_type_id = 1 AND CURRENT_DATE BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end;