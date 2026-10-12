TRUNCATE TABLE ldl_data_production_core_dim.t_fact_real_estate_lifecycle_1;


INSERT INTO ldl_data_production_core_dim.t_fact_real_estate_lifecycle_1 (real_estate_sid, real_estate_nr, real_estate_name
 , real_estate_type_cd, real_estate_status_cd, precontract_dt, contract_dt, construction_start_dt, construction_end_dt,
 planned_open_dt, open_dt, opening_reason_cd, temp_closing_start_dt, temp_closing_end_dt, closed_bus_days_cnt,
 temp_closing_reason_cd, planned_close_dt, close_dt, closing_reason_cd, project_cancel_dt, project_cancel_reason_cd,
 project_term_dt, dwh_created_tmsp, dwh_updated_tmsp, dwh_load_id, dwh_node_cd)
(SELECT DISTINCT real_estate_sid,
  real_estate_nr,
  real_estate_name,
  real_estate_type_cd,
  real_estate_status_cd,
  precontract_dt,
  contract_dt,
  construction_start_dt,
  construction_end_dt,
  planned_open_dt,
  open_dt,
  opening_reason_cd,
  temp_closing_start_dt,
  temp_closing_end_dt,
  closed_busines_days_cnt,
  temp_closing_reason_cd,
  planned_close_dt,
  close_dt,
  closing_reason_cd,
  project_cancel_dt,
  project_cancel_reason_cd,
  project_term_dt,
  dwh_created_tmsp,
  dwh_updated_tmsp,
  dwh_load_id,
  dwh_node_cd
 FROM (WITH re_status AS (SELECT real_estate_sid,
       real_estate_status_cd,
       real_estate_status_reason_cd,
       comment_txt,
       dwh_valid_fg
      FROM ldl_data_production_core_rel.t_real_estate_status_1 AS res
      WHERE real_estate_status_categ_cd = 'BS'
      QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(real_estate_sid AS STRING), real_estate_status_cd ORDER BY
            dwh_valid_from_tmsp IS NULL DESC, dwh_valid_from_tmsp DESC)) = 1), tmp_closed AS (SELECT real_estate_sid,
       closed_from_dt,
       closed_until_dt,
       closed_bus_days_cnt
      FROM ldl_data_production_core_rel.t_real_estate_closing_plan_1
      QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(real_estate_sid AS STRING) ORDER BY closed_from_dt IS NULL DESC,
            closed_from_dt DESC, closed_until_dt IS NULL DESC, closed_until_dt DESC)) = 1) (SELECT re.real_estate_sid,
       re.real_estate_nr,
       re.real_estate_name,
       IFNULL(re.real_estate_type_cd, '@') AS real_estate_type_cd,
       IFNULL(curr_res.real_estate_status_cd, '@') AS real_estate_status_cd,
        CASE
        WHEN re.precontract_dt BETWEEN CAST(db.min_dt AS DATE) AND (CAST(db.max_dt AS DATE))
        THEN re.precontract_dt
        ELSE NULL
        END AS precontract_dt,
        CASE
        WHEN re.contract_dt BETWEEN CAST(db.min_dt AS DATE) AND (CAST(db.max_dt AS DATE))
        THEN re.contract_dt
        ELSE NULL
        END AS contract_dt,
        CASE
        WHEN re.construction_start_dt BETWEEN CAST(db.min_dt AS DATE) AND (CAST(db.max_dt AS DATE))
        THEN re.construction_start_dt
        ELSE NULL
        END AS construction_start_dt,
        CASE
        WHEN re.construction_end_dt BETWEEN CAST(db.min_dt AS DATE) AND (CAST(db.max_dt AS DATE))
        THEN re.construction_end_dt
        ELSE NULL
        END AS construction_end_dt,
        CASE
        WHEN re.planned_open_dt BETWEEN CAST(db.min_dt AS DATE) AND (CAST(db.max_dt AS DATE))
        THEN re.planned_open_dt
        ELSE NULL
        END AS planned_open_dt,
        CASE
        WHEN re.open_dt BETWEEN CAST(db.min_dt AS DATE) AND (CAST(db.max_dt AS DATE))
        THEN re.open_dt
        ELSE NULL
        END AS open_dt,
       IFNULL(rs_op.real_estate_status_reason_cd, '@') AS opening_reason_cd,
        CASE
        WHEN t17.closed_from_dt BETWEEN CAST(db.min_dt AS DATE) AND (CAST(db.max_dt AS DATE))
        THEN t17.closed_from_dt
        ELSE NULL
        END AS temp_closing_start_dt,
        CASE
        WHEN t17.closed_until_dt BETWEEN CAST(db.min_dt AS DATE) AND (CAST(db.max_dt AS DATE))
        THEN t17.closed_until_dt
        ELSE NULL
        END AS temp_closing_end_dt,
       IFNULL(t17.closed_bus_days_cnt, 0) AS closed_busines_days_cnt,
       IFNULL(rs_tc.real_estate_status_reason_cd, '@') AS temp_closing_reason_cd,
        CASE
        WHEN re.planned_close_dt BETWEEN CAST(db.min_dt AS DATE) AND (CAST(db.max_dt AS DATE))
        THEN re.planned_close_dt
        ELSE NULL
        END AS planned_close_dt,
        CASE
        WHEN re.close_dt BETWEEN CAST(db.min_dt AS DATE) AND (CAST(db.max_dt AS DATE))
        THEN re.close_dt
        ELSE NULL
        END AS close_dt,
       IFNULL(rs_cl.real_estate_status_reason_cd, '@') AS closing_reason_cd,
        CASE
        WHEN re.project_cancel_dt BETWEEN CAST(db.min_dt AS DATE) AND (CAST(db.max_dt AS DATE))
        THEN re.project_cancel_dt
        ELSE NULL
        END AS project_cancel_dt,
       IFNULL(rs_cn.real_estate_status_reason_cd, '@') AS project_cancel_reason_cd,
        CASE
        WHEN re.project_term_dt BETWEEN CAST(db.min_dt AS DATE) AND (CAST(db.max_dt AS DATE))
        THEN re.project_term_dt
        ELSE NULL
        END AS project_term_dt,
       re.dwh_created_tmsp,
       CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
       1 AS dwh_load_id,
       'P_LEW_CORE' AS dwh_node_cd
      FROM ldl_data_production_core_rel.t_real_estate_1 AS re_1
       LEFT JOIN ldl_data_production_core_rel.t_real_estate_status_1 AS curr_res ON re.real_estate_sid = curr_res.real_estate_sid
           AND curr_res.real_estate_status_categ_cd = 'BS' AND curr_res.dwh_valid_fg
       LEFT JOIN re_status AS rs_op ON re.real_estate_sid = rs_op.real_estate_sid AND rs_op.real_estate_status_cd = 'OP'
         
       LEFT JOIN re_status AS rs_cl ON re.real_estate_sid = rs_cl.real_estate_sid AND rs_cl.real_estate_status_cd = 'CL'
         
       LEFT JOIN re_status AS rs_cn ON re.real_estate_sid = rs_cn.real_estate_sid AND rs_cn.real_estate_status_cd = 'CN'
         
       LEFT JOIN re_status AS rs_tc ON re.real_estate_sid = rs_tc.real_estate_sid AND rs_tc.real_estate_status_cd = 'TC'
         
       LEFT JOIN tmp_closed AS t17 ON re.real_estate_sid = t17.real_estate_sid
       INNER JOIN (SELECT MIN(calendar_date) AS min_dt,
         MAX(calendar_date) AS max_dt
        FROM ldl_data_production_eval.tmp_date_time_1) AS db ON TRUE
      WHERE re.dwh_valid_fg)) AS t22
 WHERE NOT EXISTS (SELECT 1 AS `A12180`
   FROM ldl_data_production_core_dim.t_fact_real_estate_lifecycle_1
   WHERE real_estate_sid = t22.real_estate_sid)
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY real_estate_sid)) = 1);