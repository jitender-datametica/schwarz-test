CREATE OR REPLACE VIEW ldl_scm_core_rel.v_busyear_month_week AS SELECT BL.land,
 BL.ba_nr,
 BL.ian,
 BL.busyear,
 BL.start_month,
 BL.end_month,
 wi.cy_month,
 CM.cy_month_sequence,
 wi.cy_week
FROM ldl_scm_core_rel.t_busyear_lookup AS BL
 INNER JOIN (SELECT cy_month,
   cy_week
  FROM (SELECT cy_month,
     cy_week,
     COUNT(*) AS day_cnt_in_week
    FROM ldl_scm_core_rel.v_cal_calendarday
    GROUP BY cy_week,
     cy_month
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(cy_week AS STRING) ORDER BY cy_week IS NULL, cy_week, day_cnt_in_week
          IS NULL DESC, day_cnt_in_week DESC)) = 1) AS t1) AS wi ON wi.cy_month BETWEEN BL.start_month AND BL.end_month
 INNER JOIN ldl_scm_core_rel.v_cal_month AS CM ON wi.cy_month = CM.cy_month
ORDER BY BL.land NULLS LAST,
 BL.ba_nr NULLS LAST,
 BL.ian NULLS LAST,
 BL.busyear NULLS LAST,
 BL.start_month NULLS LAST,
 BL.end_month NULLS LAST,
 wi.cy_month NULLS LAST,
 wi.cy_week NULLS LAST;