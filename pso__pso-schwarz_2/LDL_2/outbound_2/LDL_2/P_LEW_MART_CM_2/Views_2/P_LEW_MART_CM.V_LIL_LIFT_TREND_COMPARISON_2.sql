-- no nulls for external data (lift)
 -- no nulls for internal data (ejr)
 -- no nulls

CREATE OR REPLACE VIEW ldl_p_lew_mart_cm.v_lil_lift_trend_comparison_2 AS WITH REPORT_LAYER AS (WITH INTERNAL_DATA AS (SELECT
      V_LIL_PERIOD.per_id,
      INTDAT.client_id,
      V_LIL_LIFT_CAT.lift_cat_id,
      INTDAT.rtl_id,
      INTDAT.rtl_lvl,
      INTDAT.prom_id,
      INTDAT.meas_id,
      INTDAT.currency_iso_cd,
      V_LIL_RTL_LVL_TP.rtl_tp_id,
      v_lil_data_delivery_classification.dsc_nr,
       COALESCE(INTDAT.val, 0) / 1000.0 AS val__divk,
       INTDAT.py_val / 1000.0 AS py_val__divk,
      COALESCE(INTDAT.val, 0) AS val,
      INTDAT.py_val
     FROM ldl_p_lew_mart_cm_ac.v_lil_ejr_lift_data_act_2 AS INTDAT
      INNER JOIN ldl_p_lew_mart_cm_ac.v_lil_rtl_lvl_tp_2 AS V_LIL_RTL_LVL_TP_2 ON INTDAT.rtl_lvl = V_LIL_RTL_LVL_TP.rtl_lvl
      INNER JOIN ldl_p_lew_mart_cm_ac.v_lil_lift_cat_2 AS V_LIL_LIFT_CAT_2 ON INTDAT.lift_cat_id = V_LIL_LIFT_CAT.lift_cat_id
       
      INNER JOIN ldl_p_lew_mart_cm_ac.v_lil_period_2 AS V_LIL_PERIOD_2 ON INTDAT.per_id = V_LIL_PERIOD.per_id
      INNER JOIN ldl_p_lew_mart_cm_ac.v_lil_data_delivery_classification_2 ON INTDAT.client_id =
        v_lil_data_delivery_classification.client_id AND INTDAT.per_id = v_lil_data_delivery_classification.period_id
     WHERE INTDAT.rtl_id = 1000), EXTERNAL_DATA AS (SELECT V_LIL_PERIOD0.per_id,
      EXTDAT.client_id,
      V_LIL_LIFT_CAT0.lift_cat_id,
      EXTDAT.rtl_lvl,
      EXTDAT.rtl_id,
      EXTDAT.prom_id,
      EXTDAT.meas_id,
      EXTDAT.currency_iso_cd,
      V_LIL_RTL_LVL_TP0.rtl_tp_id,
      v_lil_data_delivery_classification0.dsc_nr,
        CASE
        WHEN EXTDAT.meas_id = 27
        THEN COALESCE(EXTDAT.val, 0) * 100
        ELSE COALESCE(EXTDAT.val, 0)
        END / 1000.0 AS val__divk,
        CASE
        WHEN EXTDAT.meas_id = 27
        THEN EXTDAT.py_val * 100
        ELSE EXTDAT.py_val
        END / 1000.0 AS py_val__divk,
       CASE
       WHEN EXTDAT.meas_id = 27
       THEN COALESCE(EXTDAT.val, 0) * 100
       ELSE COALESCE(EXTDAT.val, 0)
       END AS val,
       CASE
       WHEN EXTDAT.meas_id = 27
       THEN EXTDAT.py_val * 100
       ELSE EXTDAT.py_val
       END AS py_val
     FROM ldl_p_lew_mart_cm_ac.v_lil_lift_data_act_2 AS EXTDAT
      INNER JOIN ldl_p_lew_mart_cm_ac.v_lil_rtl_lvl_tp_2 AS V_LIL_RTL_LVL_TP0 ON EXTDAT.rtl_lvl = V_LIL_RTL_LVL_TP0.rtl_lvl
       
      INNER JOIN ldl_p_lew_mart_cm_ac.v_lil_lift_cat_2 AS V_LIL_LIFT_CAT0 ON EXTDAT.lift_cat_id = V_LIL_LIFT_CAT0.lift_cat_id
       
      INNER JOIN ldl_p_lew_mart_cm_ac.v_lil_period_2 AS V_LIL_PERIOD0 ON EXTDAT.per_id = V_LIL_PERIOD0.per_id
      INNER JOIN ldl_p_lew_mart_cm_ac.v_lil_data_delivery_classification_2 AS v_lil_data_delivery_classification0 ON
        EXTDAT.client_id = v_lil_data_delivery_classification0.client_id AND EXTDAT.per_id =
        v_lil_data_delivery_classification0.period_id
     WHERE EXTDAT.rtl_id = 1000) (SELECT INT_EXT.client_id,
      INT_EXT.rtl_id,
      INT_EXT.rtl_lvl,
      v_lil_period0.per_id,
      INT_EXT.prom_id,
      INT_EXT.meas_id,
      INT_EXT.currency_iso_cd,
      INT_EXT.rtl_tp_id,
      v_lil_lift_cat0.lift_cat_id,
      INT_EXT.external_data__dsc_nr AS dsc_nr,
      INT_EXT.internal_data__val__divk,
      INT_EXT.internal_data__val,
      INT_EXT.internal_data__py_val__divk,
      INT_EXT.internal_data__py_val,
      INT_EXT.external_data__val__divk,
      INT_EXT.external_data__val,
      INT_EXT.external_data__py_val__divk,
      INT_EXT.external_data__py_val,
       CASE
       WHEN INT_EXT.ext_calc_fg = 1
       THEN INT_EXT.external_data_revenuechange__perc
       ELSE NULL
       END AS revenuechange_external_percentage,
       CASE
       WHEN INT_EXT.int_calc_fg = 1
       THEN INT_EXT.internal_data_revenuechange__perc
       ELSE NULL
       END AS revenuechange_internal_percentage,
       COALESCE(INT_EXT.internal_data_revenuechange__perc, 0) - COALESCE(INT_EXT.external_data_revenuechange__perc, 0)
      AS revenuechange_to_ejr,
       CASE
       WHEN INT_EXT.calc_fg = 1
       THEN (INT_EXT.external_data_revenuechange__perc - INT_EXT.internal_data_revenuechange__perc) / IF(INT_EXT.internal_data_revenuechange__perc
            = 0, NULL, INT_EXT.internal_data_revenuechange__perc) * 100
       ELSE NULL
       END AS trend_ratio,
       CASE
       WHEN INT_EXT.calc_fg = 1
       THEN 100 * (INT_EXT.external_data__val__divk / IF(INT_EXT.internal_data__val__divk = 0, NULL, INT_EXT.internal_data__val__divk
           ))
       ELSE NULL
       END AS cover,
       CASE
       WHEN INT_EXT.calc_fg = 1
       THEN 100 * (INT_EXT.external_data__py_val__divk / IF(INT_EXT.internal_data__py_val__divk = 0, NULL, INT_EXT.internal_data__py_val__divk
           ))
       ELSE NULL
       END AS cover_ljp,
       COALESCE(CASE
         WHEN INT_EXT.calc_fg = 1
         THEN 100 * (INT_EXT.external_data__val__divk / IF(INT_EXT.internal_data__val__divk = 0, NULL, INT_EXT.internal_data__val__divk
             ))
         ELSE NULL
         END, 0) - COALESCE(CASE
         WHEN INT_EXT.calc_fg = 1
         THEN 100 * (INT_EXT.external_data__py_val__divk / IF(INT_EXT.internal_data__py_val__divk = 0, NULL, INT_EXT.internal_data__py_val__divk
             ))
         ELSE NULL
         END, 0) AS cover_delta
     FROM (SELECT COALESCE(t4.per_id, t1.per_id) AS per_id,
        COALESCE(t4.client_id, t1.client_id) AS client_id,
        COALESCE(t4.lift_cat_id, t1.lift_cat_id) AS lift_cat_id,
        COALESCE(t4.rtl_id, t1.rtl_id) AS rtl_id,
        COALESCE(t4.rtl_lvl, t1.rtl_lvl) AS rtl_lvl,
        COALESCE(t4.prom_id, t1.prom_id) AS prom_id,
        COALESCE(t4.meas_id, t1.meas_id) AS meas_id,
        COALESCE(t4.currency_iso_cd, t1.currency_iso_cd) AS currency_iso_cd,
        COALESCE(t4.rtl_tp_id, t1.rtl_tp_id) AS rtl_tp_id,
        t4.dsc_nr AS external_data__dsc_nr,
        t1.dsc_nr AS internal_data__dsc_nr,
        t1.val__divk AS internal_data__val__divk,
        t1.val AS internal_data__val,
        t1.py_val__divk AS internal_data__py_val__divk,
        t1.py_val AS internal_data__py_val,
        t4.val__divk AS external_data__val__divk,
        t4.val AS external_data__val,
        t4.py_val__divk AS external_data__py_val__divk,
        t4.py_val AS external_data__py_val,
         CASE
         WHEN COALESCE((COALESCE(t1.val, 0) - COALESCE(t1.py_val, 0)) / CASE
              WHEN t1.py_val = 0
              THEN NULL
              ELSE t1.py_val
              END * 100, 0) = 0
         THEN NULL
         ELSE COALESCE((COALESCE(t1.val, 0) - COALESCE(t1.py_val, 0)) / CASE
             WHEN t1.py_val = 0
             THEN NULL
             ELSE t1.py_val
             END * 100, 0)
         END AS internal_data_revenuechange__perc,
         CASE
         WHEN COALESCE((COALESCE(t4.val, 0) - COALESCE(t4.py_val, 0)) / CASE
              WHEN t4.py_val = 0
              THEN NULL
              ELSE t4.py_val
              END * 100, 0) = 0
         THEN NULL
         ELSE COALESCE((COALESCE(t4.val, 0) - COALESCE(t4.py_val, 0)) / CASE
             WHEN t4.py_val = 0
             THEN NULL
             ELSE t4.py_val
             END * 100, 0)
         END AS external_data_revenuechange__perc,
         CASE
         WHEN t1.val__divk IS NULL OR t1.val IS NULL OR t1.py_val__divk IS NULL OR t1.py_val IS NULL OR t4.val__divk
             IS NULL OR t4.val IS NULL OR t4.py_val__divk IS NULL OR t4.py_val IS NULL
         THEN 0
         ELSE 1
         END AS calc_fg,
         CASE
         WHEN t1.val__divk IS NULL OR t1.val IS NULL OR t1.py_val__divk IS NULL OR t1.py_val IS NULL
         THEN 0
         ELSE 1
         END AS int_calc_fg,
         CASE
         WHEN t4.val__divk IS NULL OR t4.val IS NULL OR t4.py_val__divk IS NULL OR t4.py_val IS NULL
         THEN 0
         ELSE 1
         END AS ext_calc_fg
       FROM INTERNAL_DATA AS t1_2
        FULL JOIN EXTERNAL_DATA AS t4 ON t1.client_id = t4.client_id AND t1.lift_cat_id = t4.lift_cat_id AND t1.per_id =
                t4.per_id AND t1.rtl_id = t4.rtl_id AND t1.rtl_lvl = t4.rtl_lvl AND t1.prom_id = t4.prom_id AND t1.meas_id
             = t4.meas_id AND t1.currency_iso_cd = t4.currency_iso_cd AND t1.rtl_tp_id = t4.rtl_tp_id) AS INT_EXT
      INNER JOIN ldl_p_lew_mart_cm_ac.v_lil_lift_cat_2 AS v_lil_lift_cat0 ON INT_EXT.lift_cat_id = v_lil_lift_cat0.lift_cat_id
       
      INNER JOIN ldl_p_lew_mart_cm_ac.v_lil_period_2 AS v_lil_period0 ON INT_EXT.per_id = v_lil_period0.per_id)) (SELECT *
   
  FROM (SELECT client_id,
      rtl_id,
      rtl_lvl,
      per_id,
      prom_id,
      meas_id,
      lift_cat_id,
      currency_iso_cd,
      rtl_tp_id,
      0 AS dsc_nr,
      ROUND(revenuechange_internal_percentage, 2) AS revenuechange_percentage,
      ROUND(revenuechange_to_ejr, 2) AS revenuechange_to_ejr,
      ROUND(trend_ratio, 2) AS trend_ratio,
      ROUND(cover, 2) AS cover,
      ROUND(cover_ljp, 2) AS cover_ljp,
      ROUND(cover_delta, 2) AS cover_delta
     FROM REPORT_LAYER
     UNION DISTINCT
     SELECT client_id,
      rtl_id,
      rtl_lvl,
      per_id,
      prom_id,
      meas_id,
      lift_cat_id,
      currency_iso_cd,
      rtl_tp_id,
      dsc_nr,
      ROUND(revenuechange_external_percentage, 2) AS revenuechange,
      ROUND(revenuechange_to_ejr, 2) AS revenuechange_to_ejr,
      ROUND(trend_ratio, 2) AS trend_ratio,
      ROUND(cover, 2) AS cover,
      ROUND(cover_ljp, 2) AS cover_ljp,
      ROUND(cover_delta, 2) AS cover_delta
     FROM REPORT_LAYER));