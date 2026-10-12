-- !SET exit_on_error=True;


BEGIN TRANSACTION;


TRUNCATE TABLE ldl_data_production_core_dim.t_fact_store_open_days;

--BUS_YEAR
--and cd.CAL_DT <= si.store_close_dt
--,sod.BUS_YEAR
INSERT INTO ldl_data_production_core_dim.t_fact_store_open_days (bus_dt, store_sid, real_estate_sid, country_org_cd,
 store_open_fg, store_open_days_bytd_cnt, store_open_py_fg, store_open_days_py_bytd_cnt, store_open_py_swday_fg,
 store_open_days_py_swday_bytd_cnt, relevant_for_comp_fg, relevant_for_comp_py_fg, relevant_for_comp_py_swday_fg,
 open_tm, close_tm, open_hr_cnt, open_hr_bytd_cnt, open_hr_py_cnt, open_hr_py_bytd_cnt, open_hr_py_swday_cnt,
 open_hr_py_swday_bytd_cnt, emp_hr_cnt, emp_hr_bytd_cnt, emp_hr_py_cnt, emp_hr_py_bytd_cnt, emp_hr_py_swday_cnt,
 emp_hr_py_swday_bytd_cnt, real_estate_status_cd, real_estate_event_reason_cd, dwh_created_tmsp, dwh_updated_tmsp,
 dwh_load_id, dwh_node_cd, break_start_tm, break_end_tm)
WITH store_interval AS (SELECT t1.store_sid,
    MAX(t1.country_org_cd) AS country_org_cd,
    MIN(t1.open_dt) AS store_open_dt,
    MAX(t1.close_dt) AS store_close_dt,
    DATE_ADD(DATE_ADD(DATE_ADD(DATE_SUB(MIN(t1.open_dt), INTERVAL CAST(FORMAT_DATE('%u', MIN(t1.open_dt)) AS INTEGER)
        DAY), INTERVAL 1 DAY), INTERVAL 364 DAY), INTERVAL 7 DAY) AS store_open_53w_later_dt,-- Monday of the week + 52 weeks + 1 week
    LEAST(DATE_ADD(DATE_SUB(MAX(t1.close_dt), INTERVAL CAST(FORMAT_DATE('%u', MAX(t1.close_dt)) AS INTEGER) DAY),
      INTERVAL 7 DAY), DATE '9999-12-31') AS store_close_sunday_dt -- Sunday of the week
   FROM (SELECT io.int_org_sid AS store_sid,
      COALESCE(sh.parent_country_org_cd, dh.parent_country_org_cd, nkch.parent_country_org_cd) AS country_org_cd,
      io.open_dt,
      IFNULL(io.close_dt, DATE '9999-12-31') AS close_dt,
      io.int_org_sid,
      io.int_org_nr,
      io.dwh_valid_fg,
      io.dwh_valid_from_tmsp
     FROM ldl_data_production_core_rel.t_internal_organization AS io
      LEFT JOIN ldl_data_production_etl.t_r2d_full_internal_organization_hierarchy AS sh ON io.int_org_sid = sh.child_org_sid
            AND io.dwh_valid_to_tmsp >= sh.dwh_valid_from_tmsp AND io.dwh_valid_from_tmsp <= sh.dwh_valid_to_tmsp AND sh
         .top_hierarchy_type_cd = 'CNTRY_ORG_REGION' AND sh.levels_above_leaf = 5
      LEFT JOIN ldl_data_production_etl.t_r2d_full_internal_organization_hierarchy AS dh ON io.int_org_sid = dh.child_org_sid
            AND io.dwh_valid_to_tmsp >= dh.dwh_valid_from_tmsp AND io.dwh_valid_from_tmsp <= dh.dwh_valid_to_tmsp AND dh
         .top_hierarchy_type_cd = 'CNTRY_ORG_REGION' AND dh.levels_above_leaf = 3
      LEFT JOIN ldl_data_production_etl.t_r2d_full_internal_organization_hierarchy AS nkch ON io.int_org_sid = nkch.child_org_sid
            AND io.dwh_valid_to_tmsp >= nkch.dwh_valid_from_tmsp AND io.dwh_valid_from_tmsp <= nkch.dwh_valid_to_tmsp
        AND nkch.top_hierarchy_type_cd = 'CNTRY_ORG_STORE' AND nkch.levels_above_leaf = 1
     WHERE io.int_org_nr <> '@'
      AND io.int_org_type_cd = 'STORE'
     QUALIFY (ROW_NUMBER() OVER (PARTITION BY io.int_org_sid, io.int_org_nr ORDER BY CASE
            WHEN io.dwh_valid_fg
            THEN 1
            ELSE 2
            END IS NULL, CASE
            WHEN io.dwh_valid_fg
            THEN 1
            ELSE 2
            END, io.dwh_valid_from_tmsp IS NULL DESC, io.dwh_valid_from_tmsp DESC)) = 1) AS t1
   GROUP BY t1.store_sid), store_days AS (SELECT si.store_sid,
    iore.real_estate_sid,
    cd.cal_dt AS bus_dt,
    cd.bus_year,
    cd.day_of_week,
    si.country_org_cd,
    res.real_estate_status_cd,
    res.real_estate_status_reason_cd,
     CASE
     WHEN cd.cal_dt BETWEEN si.store_open_dt AND si.store_close_dt
     THEN 1
     ELSE 0
     END AS store_open_fg,
    SUM(CASE
      WHEN cd.cal_dt BETWEEN si.store_open_dt AND si.store_close_dt
      THEN 1
      ELSE 0
      END) OVER (PARTITION BY si.store_sid, iore.real_estate_sid, CAST(cd.bus_year AS STRING) ORDER BY cd.cal_dt IS NULL
       , cd.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS store_open_days_bytd_cnt,
     CASE
     WHEN cd.cal_dt BETWEEN si.store_open_53w_later_dt AND si.store_close_sunday_dt
     THEN 1
     ELSE 0
     END AS relevant_for_comp_fg,
     CASE
     WHEN CASE
       WHEN cd.cal_dt BETWEEN si.store_open_dt AND si.store_close_dt
       THEN 1
       ELSE 0
       END = 1
     THEN soh.open_tm
     ELSE NULL
     END AS store_open_tm,
     CASE
     WHEN CASE
       WHEN cd.cal_dt BETWEEN si.store_open_dt AND si.store_close_dt
       THEN 1
       ELSE 0
       END = 1
     THEN soh.close_tm
     ELSE NULL
     END AS store_close_tm,
     CASE
     WHEN CASE
       WHEN cd.cal_dt BETWEEN si.store_open_dt AND si.store_close_dt
       THEN 1
       ELSE 0
       END = 1
     THEN soh.break_start_tm
     ELSE NULL
     END AS store_break_start_tm,
     CASE
     WHEN CASE
       WHEN cd.cal_dt BETWEEN si.store_open_dt AND si.store_close_dt
       THEN 1
       ELSE 0
       END = 1
     THEN soh.break_end_tm
     ELSE NULL
     END AS store_break_end_tm,
     cast(TIME_DIFF(CASE
       WHEN CASE
         WHEN cd.cal_dt BETWEEN si.store_open_dt AND si.store_close_dt
         THEN 1
         ELSE 0
         END = 1
       THEN soh.close_tm
       ELSE NULL
       END, CASE
       WHEN CASE
         WHEN cd.cal_dt BETWEEN si.store_open_dt AND si.store_close_dt
         THEN 1
         ELSE 0
         END = 1
       THEN soh.open_tm
       ELSE NULL
       END, MINUTE) / 60 as numeric) AS open_hr_cnt,
    cast(SUM(TIME_DIFF(CASE
        WHEN CASE
          WHEN cd.cal_dt BETWEEN si.store_open_dt AND si.store_close_dt
          THEN 1
          ELSE 0
          END = 1
        THEN soh.close_tm
        ELSE NULL
        END, CASE
        WHEN CASE
          WHEN cd.cal_dt BETWEEN si.store_open_dt AND si.store_close_dt
          THEN 1
          ELSE 0
          END = 1
        THEN soh.open_tm
        ELSE NULL
        END, MINUTE) / 60) OVER (PARTITION BY si.store_sid, iore.real_estate_sid, CAST(cd.bus_year AS STRING) ORDER BY
       cd.cal_dt IS NULL, cd.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as numeric) AS open_hr_bytd_cnt
   FROM store_interval AS si
    INNER JOIN ldl_data_production_core_dim.t_dim_calendar_date AS cd ON si.store_open_dt <= cd.cal_dt AND cd.cal_dt <=
      CURRENT_DATE
    LEFT JOIN ldl_data_production_core_rel.t_store_opening_hours AS soh ON si.store_sid = soh.store_sid AND cd.day_of_week
         = soh.day_of_week AND soh.dwh_valid_from_tmsp <= CAST(cd.cal_dt AS TIMESTAMP) AND soh.dwh_valid_to_tmsp
       >= CAST(cd.cal_dt AS TIMESTAMP)
    LEFT JOIN ldl_data_production_core_rel.t_internal_organization_real_estate AS iore ON si.store_sid = iore.int_org_sid
         AND iore.dwh_valid_from_tmsp <= CAST(cd.cal_dt AS TIMESTAMP) AND iore.dwh_valid_to_tmsp >= CAST(cd.cal_dt AS TIMESTAMP)
        AND iore.int_org_real_estate_usg_type_cd = 'USED_BY'
    LEFT JOIN ldl_data_production_core_rel.t_real_estate_status AS res ON iore.real_estate_sid = res.real_estate_sid AND
        res.dwh_valid_from_tmsp <= CAST(cd.cal_dt AS TIMESTAMP) AND res.dwh_valid_to_tmsp >= CAST(cd.cal_dt AS TIMESTAMP)
        AND res.real_estate_status_categ_cd = 'BS'), py_m AS (SELECT c.cal_dt AS bus_dt,
    sod.store_sid,
    sod.real_estate_sid,
    MAX(sod.store_open_fg) AS store_open_py_fg,
    MAX(sod.relevant_for_comp_fg) AS relevant_for_comp_py_fg,
    SUM(sod.open_hr_cnt) AS open_hr_py_cnt
   FROM store_days AS sod
    INNER JOIN ldl_data_production_core_rel.t_cal_date_adjusted_relationship AS c ON sod.bus_dt = c.rel_cal_dt AND c.cal_dt_adjust_type_cd
        = 'M' AND c.bus_year_diff = 1
   GROUP BY bus_dt,
    sod.store_sid,
    sod.real_estate_sid), py_mc AS (SELECT c0.cal_dt AS bus_dt,
    sod.store_sid,
    sod.real_estate_sid,
    SUM(MAX(sod.store_open_fg)) OVER (PARTITION BY sod.store_sid, sod.real_estate_sid, CAST(sod.bus_year AS STRING)
     ORDER BY c0.cal_dt IS NULL, c0.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
    store_open_days_py_bytd_cnt,
    SUM(SUM(sod.open_hr_cnt)) OVER (PARTITION BY sod.store_sid, sod.real_estate_sid, CAST(sod.bus_year AS STRING)
     ORDER BY c0.cal_dt IS NULL, c0.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS open_hr_py_bytd_cnt
   FROM store_days AS sod
    INNER JOIN ldl_data_production_core_rel.t_cal_date_adjusted_relationship AS c0 ON sod.bus_dt = c0.rel_cal_dt AND c0
       .cal_dt_adjust_type_cd = 'MC' AND c0.bus_year_diff = 1
   GROUP BY bus_dt,
    sod.store_sid,
    sod.real_estate_sid,
    sod.bus_year), py_w AS (SELECT c1.cal_dt AS bus_dt,
    sod.store_sid,
    sod.real_estate_sid,
    MAX(sod.store_open_fg) AS store_open_py_swday_fg,
    MAX(sod.relevant_for_comp_fg) AS relevant_for_comp_py_swday_fg,
    SUM(sod.open_hr_cnt) AS open_hr_py_swday_cnt
   FROM store_days AS sod
    INNER JOIN ldl_data_production_core_rel.t_cal_date_adjusted_relationship AS c1 ON sod.bus_dt = c1.rel_cal_dt AND c1
       .cal_dt_adjust_type_cd = 'W' AND c1.bus_year_diff = 1
   GROUP BY bus_dt,
    sod.store_sid,
    sod.real_estate_sid), py_wc AS (SELECT c2.cal_dt AS bus_dt,
    sod.store_sid,
    sod.real_estate_sid,
    SUM(MAX(sod.store_open_fg)) OVER (PARTITION BY sod.store_sid, sod.real_estate_sid, CAST(sod.bus_year AS STRING)
     ORDER BY c2.cal_dt IS NULL, c2.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
    store_open_days_py_swday_bytd_cnt,
    SUM(SUM(sod.open_hr_cnt)) OVER (PARTITION BY sod.store_sid, sod.real_estate_sid, CAST(sod.bus_year AS STRING)
     ORDER BY c2.cal_dt IS NULL, c2.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
    open_hr_py_swday_bytd_cnt
   FROM store_days AS sod
    INNER JOIN ldl_data_production_core_rel.t_cal_date_adjusted_relationship AS c2 ON sod.bus_dt = c2.rel_cal_dt AND c2
       .cal_dt_adjust_type_cd = 'WC' AND c2.bus_year_diff = 1
   GROUP BY bus_dt,
    sod.store_sid,
    sod.real_estate_sid,
    sod.bus_year) (SELECT sod.bus_dt,
    sod.store_sid,
    IFNULL(sod.real_estate_sid, - 1) AS sod_real_estate_sid,
    IFNULL(sod.country_org_cd, '@') AS sod_country_org_cd,
     sod.store_open_fg <> 0 AS store_open_fg,
    sod.store_open_days_bytd_cnt,
     IFNULL(t14.store_open_py_fg, 0) <> 0 AS py_m_store_open_py_fg,
    IFNULL(t24.store_open_days_py_bytd_cnt, 0) AS py_mc_store_open_days_py_bytd_cnt,
     IFNULL(t34.store_open_py_swday_fg, 0) <> 0 AS py_w_store_open_py_swday_fg,
    IFNULL(t44.store_open_days_py_swday_bytd_cnt, 0) AS py_wc_store_open_days_py_swday_bytd_cnt,
     IFNULL(sod.relevant_for_comp_fg, 0) <> 0 AS sod_relevant_for_comp_fg,
     IFNULL(t14.relevant_for_comp_py_fg, 0) <> 0 AS py_m_relevant_for_comp_py_fg,
     IFNULL(t34.relevant_for_comp_py_swday_fg, 0) <> 0 AS py_w_relevant_for_comp_py_swday_fg,
    sod.store_open_tm,
    sod.store_close_tm,
    sod.open_hr_cnt,
    sod.open_hr_bytd_cnt,
    t14.open_hr_py_cnt,
    t24.open_hr_py_bytd_cnt,
    t34.open_hr_py_swday_cnt,
    t44.open_hr_py_swday_bytd_cnt,
    NULL AS emp_hr_cnt,
    NULL AS emp_hr_bytd_cnt,
    NULL AS emp_hr_py_cnt,
    NULL AS emp_hr_py_bytd_cnt,
    NULL AS emp_hr_py_swday_cnt,
    NULL AS emp_hr_py_swday_bytd_cnt,
    IFNULL(sod.real_estate_status_cd, '@') AS real_estate_status_cd,
    IFNULL(sod.real_estate_status_reason_cd, '@') AS real_estate_even_reason_cd,
    CURRENT_TIMESTAMP() AS dwh_created_tmsp,
    CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
    - 1 AS dwh_load_id,
    'CORE_REL' AS dwh_node_cd,
    sod.store_break_start_tm,
    sod.store_break_end_tm
   FROM store_days AS sod
    LEFT JOIN py_m AS t14 ON sod.store_sid = t14.store_sid AND sod.real_estate_sid = t14.real_estate_sid AND sod.bus_dt
      = t14.bus_dt
    LEFT JOIN py_mc AS t24 ON sod.store_sid = t24.store_sid AND sod.real_estate_sid = t24.real_estate_sid AND sod.bus_dt
       = t24.bus_dt
    LEFT JOIN py_w AS t34 ON sod.store_sid = t34.store_sid AND sod.real_estate_sid = t34.real_estate_sid AND sod.bus_dt
      = t34.bus_dt
    LEFT JOIN py_wc AS t44 ON sod.store_sid = t44.store_sid AND sod.real_estate_sid = t44.real_estate_sid AND sod.bus_dt
       = t44.bus_dt);


COMMIT TRANSACTION;