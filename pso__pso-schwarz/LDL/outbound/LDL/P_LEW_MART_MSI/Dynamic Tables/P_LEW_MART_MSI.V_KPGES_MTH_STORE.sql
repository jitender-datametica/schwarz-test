/*    
   #DESCSTART#       
   #SUBJECTAREAS#: KPGES VIEWS 
   # 1.0  2024.03.11 STEPHANE TONGA ROLLBACK TO INITIAL VERSION   
   # 1.1  2024.06.28 Marcin Malec   add logic for indicator 338; average headcount for last only open 12 months; User Story 643630
   # 1.2  2025.10.10 Marcin Malec   add logic for indicator 340; sum for last 12 months, calculated by month; User Story 767991
   #DESCEND#   
   */


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_kpges_mth_store AS
SELECT IMTH.client_id,
 OSK.orig_store_nr,
 OSK.st_loc_sid AS store_id,
 IMTH.indicator_id,
   IMTH.cy * 100 + IMTH.month_id AS cy_month,
  CASE
  WHEN IMTH.indicator_id IN (117, 120, 125, 126, 133, 135, 136, 155, 156, 157, 163, 168, 169, 170, 172, 174, 177, 179,
    203, 204, 209, 210, 212, 216, 228, 229, 230, 238, 240, 242, 250, 251, 255, 256, 257, 258, 259, 260, 261, 270, 271,
    272, 273, 280, 281, 282, 283, 284, 286)
  THEN IMTH.val_indicator / CRY.rate_currency_exchange
  WHEN IMTH.indicator_id = 338
  THEN (SELECT ROUND(SUM(SUBQRY.val_indicator) / COALESCE(CASE
        WHEN SUM(CASE
           WHEN SUBQRY.val_indicator <> 0
           THEN 1
           ELSE 0
           END) <> 0
        THEN SUM(CASE
          WHEN SUBQRY.val_indicator <> 0
          THEN 1
          ELSE 0
          END)
        ELSE 1
        END, 1), 2) AS val_indicator_val_indicator_val_indicator
   FROM ldl_p_lew_bil_ac.v_kpi_month AS SUBQRY
    INNER JOIN ldl_p_lew_core_ac.v_cal_month AS SUBMON ON SUBQRY.cy * 100 + SUBQRY.month_id = SUBMON.cy_month AND SUBMON
      .cy_month_seq BETWEEN MON.cy_month_seq - 11 AND MON.cy_month_seq
   WHERE IMTH.client_id = SUBQRY.client_id
    AND IMTH.org_unit_nr = SUBQRY.org_unit_nr
    AND SUBQRY.indicator_id = 236
    AND SUBQRY.indicator_type_id = 1
    AND SUBQRY.org_type_id = 90)
  WHEN IMTH.indicator_id = 340
  THEN (SELECT ROUND(SUM(SUBQRY0.val_indicator), 2) AS val_indicator
   FROM ldl_p_lew_bil_ac.v_kpi_month AS SUBQRY0
    INNER JOIN ldl_p_lew_core_ac.v_cal_month AS SUBMON0 ON SUBQRY0.cy * 100 + SUBQRY0.month_id = SUBMON0.cy_month AND
      SUBMON0.cy_month_seq BETWEEN MON.cy_month_seq - 11 AND MON.cy_month_seq
   WHERE IMTH.client_id = SUBQRY0.client_id
    AND IMTH.org_unit_nr = SUBQRY0.org_unit_nr
    AND SUBQRY0.indicator_id = 191
    AND SUBQRY0.indicator_type_id = 1
    AND SUBQRY0.org_type_id = 90)
  ELSE IMTH.val_indicator
  END AS val_indicator,
 CRY.currency_iso_cd,
 IMTH.dat_dayend
FROM ldl_p_lew_bil_ac.v_kpi_month AS IMTH
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate AS CRY ON IMTH.client_id = CRY.client_id AND IMTH.indicator_type_id
      = 1 AND IMTH.org_type_id = 90 AND CURRENT_DATE BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
 INNER JOIN ldl_p_lew_core_ac.v_wawi_org_store_skey_act AS OSK ON IMTH.client_id = OSK.client_id AND IMTH.org_unit_nr =
   OSK.orig_store_nr
 INNER JOIN ldl_p_lew_core_ac.v_cal_month AS MON ON IMTH.cy * 100 + IMTH.month_id = MON.cy_month;
