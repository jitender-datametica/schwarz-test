
CREATE TABLE IF NOT EXISTS  ldl_p_lew_mart_msi.v_kpges_plan_week_country
 AS
SELECT IWEEK.client_id,
 IWEEK.indicator_id,
   IWEEK.cy * 100 + IWEEK.cal_week AS cy_week,
  CASE
  WHEN IWEEK.indicator_id IN (105, 108, 112, 117, 120, 125, 126, 133, 135, 136, 146, 155, 156, 157, 158, 161, 162, 163,
    168, 169, 170, 172, 174, 177, 179, 203, 204, 209, 210, 212, 216, 225, 228, 229, 230, 238, 240, 242, 243, 244, 250,
    251, 252, 256, 257, 258, 259, 260, 261, 270, 271, 272, 273, 276, 280, 281, 282, 283, 284, 286, 288, 289, 151, 293,
    302, 304, 306, 308, 310, 312, 314)
  THEN IWEEK.val_indicator / CRY.rate_currency_exchange
  ELSE IWEEK.val_indicator
  END AS val_indicator,
 CRY.currency_iso_cd,
 IWEEK.dat_dayend
FROM ldl_p_lew_core_ac.v_wawi_indicator_week AS IWEEK
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate AS CRY ON IWEEK.client_id = CRY.client_id AND IWEEK.org_type_id
      = 20 AND IWEEK.indicator_type_id = 2 AND CURRENT_DATE BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end;


