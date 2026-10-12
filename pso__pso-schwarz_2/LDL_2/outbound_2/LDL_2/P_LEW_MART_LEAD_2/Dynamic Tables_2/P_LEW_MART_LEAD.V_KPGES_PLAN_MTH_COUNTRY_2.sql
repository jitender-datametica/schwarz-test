CREATE OR REPLACE TABLE ldl_p_lew_mart_lead.v_kpges_plan_mth_country_2
AS
SELECT IMTH.client_id,
 IMTH.indicator_id,
   IMTH.cy * 100 + IMTH.month_id AS cy_month,
  CASE
  WHEN IMTH.indicator_id IN (105, 108, 112, 117, 120, 125, 126, 133, 135, 136, 146, 155, 156, 157, 158, 161, 162, 163,
    168, 169, 170, 172, 174, 177, 179, 203, 204, 209, 210, 212, 216, 225, 228, 229, 230, 238, 240, 242, 243, 244, 250,
    251, 252, 256, 257, 258, 259, 260, 261, 270, 271, 272, 273, 276, 280, 281, 282, 283, 284, 286, 288, 289, 151, 293,
    302, 304, 306, 308, 310, 312, 314)
  THEN IMTH.val_indicator / CRY.rate_currency_exchange
  ELSE IMTH.val_indicator
  END AS val_indicator,
 CRY.currency_iso_cd,
 IMTH.dat_dayend
FROM ldl_p_lew_bil_ac.v_kpi_month_2 AS IMTH
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_2 AS CRY ON IMTH.client_id = CRY.client_id AND IMTH.org_type_id
      = 20 AND IMTH.indicator_type_id = 2 AND CURRENT_DATE BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end;
