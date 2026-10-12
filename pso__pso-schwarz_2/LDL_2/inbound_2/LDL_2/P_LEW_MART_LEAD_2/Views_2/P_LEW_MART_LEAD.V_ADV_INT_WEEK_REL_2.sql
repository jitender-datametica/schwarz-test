CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_ADV_INT_WEEK_REL_2
AS
  /*
  2021-12-30 Martin Murtenthaler Correction of evaluation of column cy,
                               as sometimes it is incorrect  Incident INC4030129
  */
   SELECT
     CASE
       WHEN dt.adv_wt_nr_int = 0
         THEN dt.cy_week * 10
       ELSE dt.cy_week
     END AS cy_week
   ,dt.cy
   ,dt.adv_week_int
   ,dt.adv_wt_nr_int
  FROM
  (
   SELECT
      cw.cy_week
     ,(cw.cy_week - MOD(cw.cy_week,100)) / 100 AS cy
     ,MOD( cw.cy_week, 100)                    AS adv_week_int
     ,dt.adv_wt_nr_int                         AS adv_wt_nr_int
   FROM p_lew_core_ac.v_cal_week_2 AS cw
   CROSS JOIN   (SELECT    0   AS adv_wt_nr_int
   FROM      (SELECT 'x' AS colname) dt
   UNION ALL
   SELECT    1
   FROM      (SELECT 'x' AS colname) dt
   UNION ALL
   SELECT    2
   FROM      (SELECT 'x' AS colname) dt
   UNION ALL
   SELECT    3
   FROM      (SELECT 'x' AS colname) dt
  ) dt
) dt

;