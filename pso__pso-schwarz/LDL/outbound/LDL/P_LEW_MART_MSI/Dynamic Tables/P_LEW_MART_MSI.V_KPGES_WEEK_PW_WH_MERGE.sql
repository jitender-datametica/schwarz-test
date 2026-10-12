CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_kpges_week_pw_wh_merge AS
SELECT IWEEK.client_id,
 IWEEK.org_unit_nr AS wh_id,
  CASE
  WHEN IWEEK.org_type_id = 50
  THEN 1
  ELSE 2
  END AS aspect_id,
 IWEEK.indicator_id,
 PWEEK.cy_week_partial_week_id,
  CASE
  WHEN PWEEK.cy_week_partial_week_id2 = 9
  THEN CASE
   WHEN IWEEK.indicator_id IN (117, 120, 125, 126, 133, 135, 136, 155, 156, 157, 163, 168, 169, 170, 172, 174, 177, 179
     , 203, 204, 209, 210, 212, 216, 228, 229, 230, 238, 240, 242, 250, 251, 255, 256, 257, 258, 259, 260, 261, 270, 271
     , 272, 273, 280, 281, 282, 283, 284, 286)
   THEN IWEEK.val_indicator / CRY.rate_currency_exchange
   ELSE IWEEK.val_indicator
   END
  ELSE NULL
  END AS val_indicator,
 CRY.currency_iso_cd,
 IWEEK.dat_dayend
FROM ldl_p_lew_core_ac.v_wawi_indicator_week AS IWEEK
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate AS CRY ON IWEEK.client_id = CRY.client_id AND IWEEK.indicator_type_id
      = 1 AND IWEEK.org_type_id IN (50, 60) AND CURRENT_DATE BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
 INNER JOIN ldl_p_lew_core_ac.v_wawi_cal_week_partial_week AS PWEEK ON PWEEK.cy_week_partial_week_id1 = IWEEK.cy * 100 +
   IWEEK.cal_week;

