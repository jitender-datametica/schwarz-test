CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_kpges_day_country AS
SELECT IDAY.client_id,
 IDAY.indicator_id,
 IDAY.dat_formdate,
  CASE
  WHEN IDAY.indicator_id IN (117, 120, 125, 126, 133, 135, 136, 155, 156, 157, 163, 168, 169, 170, 172, 174, 177, 179,
    203, 204, 209, 210, 212, 216, 228, 229, 230, 238, 240, 242, 250, 251, 255, 256, 257, 258, 259, 260, 261, 270, 271,
    272, 273, 280, 281, 282, 283, 284, 286)
  THEN IDAY.val_indicator / CRY.rate_currency_exchange
  ELSE IDAY.val_indicator
  END AS val_indicator,
 CRY.currency_iso_cd,
 IDAY.dat_dayend
FROM ldl_p_lew_bil_ac.v_kpi_day AS IDAY
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate AS CRY ON IDAY.client_id = CRY.client_id AND IDAY.indicator_type_id
      = 1 AND IDAY.org_type_id = 20 AND CURRENT_DATE BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end;