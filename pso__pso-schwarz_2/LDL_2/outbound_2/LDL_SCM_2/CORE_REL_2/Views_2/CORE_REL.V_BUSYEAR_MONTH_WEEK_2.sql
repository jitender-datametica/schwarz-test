CREATE OR REPLACE VIEW ldl_scm_core_rel.v_busyear_month_week_2 AS SELECT BL.land_2,
 BL.ba_nr,
 BL.ian,
 BL.busyear,
 BL.start_month,
 BL.end_month,
 wi.cy_month,
 CM.cy_month_sequence,
 wi.cy_week
FROM ldl_scm_core_rel.t_busyear_lookup_2 AS BL
 INNER JOIN (SELECT cy_month,
   cy_week
  FROM (SELECT cy_month,
     cy_week,
     COUNT(*) AS day_cnt_in_week
    FROM ldl_scm_core_rel.v_cal_calendarday_2
    GROUP BY cy_week,
     cy_month
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(cy_week AS STRING) ORDER BY cy_week IS NULL, cy_week, day_cnt_in_week
          IS NULL DESC, day_cnt_in_week DESC)) = 1) AS t1_2) AS wi ON wi.cy_month BETWEEN BL.start_month AND BL.end_month
 INNER JOIN ldl_scm_core_rel.v_cal_month_2 AS CM ON wi.cy_month = CM.cy_month
ORDER BY BL.land_2 NULLS LAST,
 BL.ba_nr NULLS LAST,
 BL.ian NULLS LAST,
 BL.busyear NULLS LAST,
 BL.start_month NULLS LAST,
 BL.end_month NULLS LAST,
 wi.cy_month NULLS LAST,
 wi.cy_week NULLS LAST;